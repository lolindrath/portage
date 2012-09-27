<div id="display_box">
<div class="contexts">
<h2>
<a href="javascript:toggle('1');javascript:toggleImage('Overdue')" 
	title="Show/hide context">
<img src="<?=$c->BASE_URL?>/img/collapse.png" name="1" alt="expand/collapse context" /></a>
Overdue</h2>
<div id="Overdue">
<table class="next_actions" cellspacing="0" cellpadding="0" border="0">

<?php while($t = $todos->fetch(PDO::FETCH_ASSOC)):?>

<?php
	$dueDate = strtodate($t["due"]);
	$due = "<span class='red'>" . date("Y-m-d", $dueDate) . "</span>";
	if($dueDate < strtodate("now") && strcmp($t["due"],'') != 0)
	{
?>
	<tr id="action-<?=$t["id"];?>"<?=$oldaction;?>>
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
		<a href="<?=$c->BASE_URL?>/project/display/<?=$t["project_id"];?>">[<?=$t["project_name"];?>]</a>
	<?php endif; ?>
	<?php if(!empty($t["notes"])): ?>
		<a href="javascript:toggle('n<?=$t['id'];?>')" title="Show notes"><img src="<?=$c->BASE_URL?>/img/show-note.png" height="16" width="16" alt="show note" /></a>
		<div class="notes" id="n<?=$t["id"];?>"><?=Markdown($t["notes"]);?></div>
	<?php endif; ?>

	</td>
	</tr>
<?php
	}
	else
	{
		break;
	}
?>

<?php endwhile;?>

</table>
</div>
<!-- end overdue -->
<!-- begin today -->

<h2>
<a href="javascript:toggle('1');javascript:toggleImage('Today')" 
	title="Show/hide context">
<img src="<?=$c->BASE_URL?>/img/collapse.png" name="1" alt="expand/collapse context" /></a>
Today</h2>
<div id="Today">
<table class="next_actions" cellspacing="0" cellpadding="0" border="0">

<?php do { ?>

<?php
	$dueDate = strtodate($t["due"]);
	$due = "<span class='green'>" . date("Y-m-d", $dueDate) . "</span>";

	if($dueDate == strtodate("now"))
	{
?>
	<tr id="action-<?=$t["id"];?>"<?=$oldaction;?>>
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
	}
	else
	{
		break;
	}
?>

<?php } while($t = $todos->fetch(PDO::FETCH_ASSOC));?>

</table>
</div>

<!-- end today -->

<!-- begin tomorrow -->

<h2>
<a href="javascript:toggle('1');javascript:toggleImage('Tomorrow')" 
	title="Show/hide context">
<img src="<?=$c->BASE_URL?>/img/collapse.png" name="1" alt="expand/collapse context" /></a>
Tomorrow</h2>
<div id="Tomorrow">
<table class="next_actions" cellspacing="0" cellpadding="0" border="0">

<?php do{?>

<?php
	$dueDate = strtodate($t["due"]);
	$due = "<span class='green'>" . date("Y-m-d", $dueDate) . "</span>";

	if($dueDate == strtodate("now + 1 day"))
	{
?>
	<tr id="action-<?=$t["id"];?>"<?=$oldaction;?>>
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
	}
	else
	{
		break;
	}
?>

<?php }while($t = $todos->fetch(PDO::FETCH_ASSOC));?>

</table>
</div>

<!-- end tommorrow -->

<!-- begin next seven -->

<h2>
<a href="javascript:toggle('1');javascript:toggleImage('The Rest')" 
	title="Show/hide context">
<img src="<?=$c->BASE_URL?>/img/collapse.png" name="1" alt="expand/collapse context" /></a>
The Next Seven Days</h2>
<div id="The Rest">
<table class="next_actions" cellspacing="0" cellpadding="0" border="0">

<?php do{?>

<?php
	$dueDate = strtodate($t["due"]);
	$due = "<span class='green'>" . date("Y-m-d", $dueDate) . "</span>";

	if($dueDate > strtodate("now + 1 day") && $dueDate < strtodate("now + 7 day"))
	{
?>
	<tr id="action-<?=$t["id"];?>"<?=$oldaction;?>>
	<td valign="top">
	<input type="checkbox" name="completed_check" value="<?=$t["id"];?>" onclick="checkTodo('<?=$t["id"];?>');"/>
	</td>
	<td valign="top">
	<a href="<?=$c->BASE_URL?>/todo/edit/<?=$t["id"];?>">
		<img src="<?=$c->BASE_URL?>/img/edit.png" width="16" height="16" alt="edit context" />
	</a>
	<a href="javascript:void(0);" onclick="deleteTodo('<?=$t['id'];?>');"/>
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
	}
	else
	{
		break;
	}
?>

<?php }while($t = $todos->fetch(PDO::FETCH_ASSOC));?>

</table>
</div>

<!-- end next seven -->

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
