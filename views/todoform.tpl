<div id="input_box">

<h2>Next Action</h2>
<form method="post" name="f" action="<?=$c->BASE_URL?>/todo/submit">
<input type="hidden" name="todo_id" value="<?=$id;?>" />
<input type="hidden" name="action" value="edit_todo" />
<label for="description">Next action</label><br />
<input id="description" name="description" type="text" size="30" value="<?=$description;?>"/>
<br />


<label for="due">Due</label><br />

<input id="due" maxlength="10" name="due" size="10" type="text" value="<?=$due;?>"class="datechooser dc-dateformat='Y-m-j' dc-iconlink='<?=$c->BASE_URL?>/img/datechooser.png' dc-startdate='<?=$dueNoDashes;?>' dc-onupdate='updateDate'" />
&nbsp;&nbsp;<a accesskey="m" href="#" onclick="javascript:Today(); return false;">Today</a>&nbsp;&nbsp;<a accesskey="n" href="#" onclick="javascript:Tomorrow(); return false;">Tomorrow</a>
<br />
<label for="notes">Notes</label><br />
<textarea cols="35" id="notes" name="notes" rows="15"><?=$notes;?></textarea>
<br />
<label for="context_edit_id">Context</label><br />
<select name="context_edit_id" id="context_edit_id">
	<?php while($c = $contexts->fetch(PDO::FETCH_ASSOC)): ?>
		<?php
			if($context == $c['id'])
				$selected = 'selected="selected"';
			else if($context == '' && $_COOKIE['last_context'] == $c['id'])
				$selected = 'selected="selected"';
			else
				$selected = '';
		?>
		<option value="<?=$c['id'];?>" <?=$selected?>><?=$c['name'];?></option>
	<?php endwhile; ?>


</select>
<br />
<label for="project_id">Project</label><br />
<select name="project_id" id="project_id">

<?php if($project == '' && !isset($_COOKIE['last_project'])): ?>
<option value="-1" selected="selected">None</option>
<?php else: ?>
<option value="-1" >None</option>
<?php endif; ?>

	<?php while($p = $projects->fetch(PDO::FETCH_ASSOC)): ?>
		<?php
			if($project == $p['id'])
				$selected = 'selected="selected"';
			else if($project == '' && $_COOKIE['last_project'] == $p['id'])
				$selected = 'selected="selected"';
			else
				$selected = '';
		?>
		<option value="<?=$p['id'];?>" <?=$selected?>><?=$p['name'];?></option>
	<?php endwhile; ?>
</select>
<br />

		
<input type="submit" value="Submit" id="submit" name="submit" />
</form>
</div>
