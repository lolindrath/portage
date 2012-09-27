<?php $c = Config::singleton(); ?>

<h2>
<a href="javascript:toggle('c<?=$projectID;?>');javascript:toggleImage('toggle_context_<?=$projectID;?>')" 
	title="Show/hide context">
<img src="<?=$c->BASE_URL?>/img/collapse.png" name="toggle_context_<?=$projectID;?>" alt="expand/collapse context" /></a>
<a href="<?=$c->BASE_URL?>/project/display/<?=$projectID;?>"><?=$projectName;?></a></h2>
<div id="c<?=$projectID;?>">
<table class="next_actions" cellspacing="0" cellpadding="0" border="0">
		
<?php foreach($todos as $t):?>
	<?php
	$due = '';
	if($t["due"] > 0 && !is_null($t["due"]))
	{
		$dueDate = strtotime($t["due"]);
		$due = date("Y-m-d", $dueDate);

		if(($days = datediff('d', strtotime(date("Y-m-d")), $dueDate, true)) < 0)
		{
			$due = '<span class="red">Overdue: '.$due.'</span>';
		}
		else if(($days = datediff('d', strtotime(date("Y-m-d")), $dueDate, true)) == 0)
		{
			$due = '<span class="amber">Due Today</span>';
		}
		else
		{
			$days = datediff('d', strtotime(date("Y-m-d")), $dueDate, true);
			if($days < 7 && $days != 1)
			{
				$due = "<span class=\"green\">Due in $days days</span>";
			}
			else if($days == 1)
			{
				$due = "<span class=\"amber\">Due tomorrow</span>";
			}
			else
			{
				$due = '<span class="green">Due: '.$due.'</span>';
			}
		}
	}

	$created = strtotime($t["created"]);
	$oldaction = '';
	if(datediff('d', $created, strtotime(date("Y-m-d")), true) > $c->OLD_ACTION)
	{
		$oldaction = ' class="oldaction"';
	}
	?>
	
	<tr id="action-<?=$t["id"];?>"<?=$oldaction;?>>
	<td valign="top">
	<input type="checkbox" name="completed_check" value="<?=$t["id"];?>" onclick="checkTodo('<?=$t["id"];?>');"/>
	</td>
	<td valign="top">
	<a href="<?=$c->BASE_URL?>/todo/edit/<?=$t["id"];?>">
		<img src="<?=$c->BASE_URL?>/img/edit.png" width="16" height="16" alt="edit context" />
	</a>
	<a href="javascript:void(0)" onclick="deleteTodo('<?=$t['id'];?>');">
		<img src="<?=$c->BASE_URL?>/img/delete.png" width="16" height="16" alt="delete context" />
	</a>
	</td>
	<td valign="top">
	<?=htmlentities($t["description"],ENT_QUOTES, 'utf-8'); ?>
	<?=$due; ?>
	<?php if($t["project_id"] != NULL and $t["project_id"] != -1): ?>
		<a href="<?=$c->BASE_URL?>/project/display/<?=$t["project_id"];?>">[<?=$projectName;?>]</a>
	<?php endif; ?>
	<?php if(!empty($t["notes"])): ?>
		<a href="javascript:toggle('n<?=$t['id'];?>')" title="Show notes"><img src="<?=$c->BASE_URL?>/img/show-note.png" height="16" width="16" alt="show note" /></a>
		<div class="notes" id="n<?=$t["id"];?>"><?=Markdown($t["notes"]);?></div>
	<?php endif; ?>

	</td>
	</tr>
			
			
<?php endforeach; ?>
		
</table>
</div>
