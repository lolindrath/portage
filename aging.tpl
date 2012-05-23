<div id="display_box">
<div class="contexts">
<h2>
<a href="javascript:toggle('1');javascript:toggleImage('Aging')" 
	title="Show/hide context">
<img src="<?=$c->BASE_URL?>/img/collapse.png" name="1" alt="expand/collapse context" /></a>
Aging</h2>
<div id="Aging">
<table class="next_actions" cellspacing="0" cellpadding="0" border="0">

<?php while($t = $todos->fetch(PDO::FETCH_ASSOC)):?>

<?php
	$dueDate = strtodate($t["due"]);
	$now = strtodate("now");
	$created = strtodate($t["created"]);
	$days = datediff('d', $created, $now, true);
	$color = 'green';
	
	if($days < 14)
	{
		$oldaction = 'green';
	}
	else if($days < 30 && $days > 14)
	{
		$oldaction = 'amber';
	}
	else if($days > 30)
	{
		$oldaction = 'red';
	}

	$ageText = '';

	$years = 0;
	$months = 0;
	$weeks = 0;
	
	if(($years = floor($days / 365)) >= 1)
	{
		$ageText = floor($years);

		if($years == 1)
			$ageText .= ' year ';
		else
			$ageText .= ' years ';
			
		$days = $days % 365;
	}

	if(($months = floor($days / 30)) >= 1)
	{
		$ageText .= floor($months);

		if($months == 1)
			$ageText .= ' month ';
		else
			$ageText .= ' months ';
			
		$days = $months % 30;
	}

	if(($weeks = floor($days / 7)) >= 1)
	{
		$ageText .= $weeks;

		if($weeks == 1)
			$ageText .= ' week ';
		else
			$ageText .= ' weeks ';
			
		$days = $weeks % 7;
	}

	$ageText .= $days;

	if($days == 1)
		$ageText .= ' day ';
	else
		$ageText .= ' days ';
	
	$due = "<span class='green'>" . $ageText . " old</span>";

?>
	<tr id="action-<?=$t["id"];?>" class="<?=$oldaction;?>">
	<td valign="top">
	<input type="checkbox" name="completed_check" value="<?=$t["id"];?>" onclick="checkTodo('<?=$t["id"];?>');"/>
	</td>
	<td valign="top">
	<a href="<?=$c->BASE_URL?>/todo/edit/<?=$t["id"];?>">
		<img src="<?=$c->BASE_URL?>/img/edit.png" width="16" height="16" alt="edit context" />
	</a>
	<a href="javascript:void(0);" onclick="deleteTodo('<?=$t['id'];?>');">
		<img src="<?=$c->BASE_URL?>/img/delete.png" width="16" height="16" alt="delete context" />
	</a>
	</td>
	<td valign="top">
	<?=htmlentities($t["description"],ENT_QUOTES, 'utf-8'); ?>
	<?=$due; ?>
	<?php if($t["project_id"] != NULL and $t["project_id"] != -1): ?>
		<a href="<?=$c->BASE_URL?>/project/display/<?=$t["project_id"];?>">[<?=$t["project_name"]; ?>]</a>
	<?php endif; ?>
	<?php if(!empty($t["notes"])): ?>
		<a href="javascript:toggle('n<?=$t['id'];?>')" title="Show notes"><img src="<?=$c->BASE_URL?>/img/show-note.png" height="16" width="16" alt="show note" /></a>
		<div class="notes" id="n<?=$t["id"];?>"><?=Markdown($t["notes"]);?></div>
	<?php endif; ?>

	</td>
	</tr>
<?php

?>

<?php endwhile;?>

</table>
</div>
<!-- end overdue -->
</div>

<div class="contexts">

  <h2>Just done</h2>

  <table class="next_actions" id="holding" cellspacing="5" cellpadding="0" border="0">
  <tr></tr>  
  </table>
</div>

<div class="contexts">
  <h2>Completed items</h2>
  <ul>
    <?php while($completed && $row = $completed->fetch(PDO::FETCH_ASSOC)): ?>
        <li><img src='<?=$c->BASE_URL?>/img/done-checkmark.gif' alt="done checkmark" />&nbsp;<?=htmlentities($row["description"],ENT_QUOTES, 'utf-8');?></li>    <?php endwhile; ?>
   </ul>
</div>

</div>
