<?php $c = Config::singleton(); ?>
<div id="display_box">
<table class="list" cellspacing="0" cellpadding="5" width="450" border="0">

<?php $rowNum = 0; ?>

<?php while($row = $projects->fetch()): ?>
	<?php if(even($rowNum)): ?>
		<tr class="even_row">
	<?php else: ?>
		<tr class="odd_row">
	<?php endif; ?>

	<?php $rowNum++; ?>

	<td width="20"><?=$row["position"]+1;?></td>
	<td width="390"><a href="<?=$c->BASE_URL?>/project/display/<?=$row["id"];?>" title="view project"><?=htmlentities($row["name"],ENT_QUOTES, 'utf-8');?></a> (<?=$row["todo_count"];?> actions)</td>
	<td width="20">
		<a href="<?=$c->BASE_URL?>/project/edit/<?=$row['id'];?>" title="edit project">
			<img src="<?=$c->BASE_URL?>/img/edit.png" height="16" width="16" alt="edit project" />
		</a>
	</td>
	<td width="20">
		<a href="<?=$c->BASE_URL?>/project/delete/<?=$row["id"];?>" title="delete project">
			<img src="<?=$c->BASE_URL?>/img/delete.png" width="16" height="16" alt="delete project" />
		</a>
	</td>
	<td width="12">
	<a href="<?=$c->BASE_URL?>/project/up/<?=$row["id"];?>" title="move project up">
		<img src="<?=$c->BASE_URL?>/img/up_arrow.png" width="10" height="10" alt="move project up" />
	</a>
	</td>
	<td width="12">
	<a href="<?=$c->BASE_URL?>/project/down/<?=$row["id"];?>" title="move project down">
		<img src="<?=$c->BASE_URL?>/img/down_arrow.png" width="10" height="10" alt="move project up" />
	</a>
	</td>
	</tr>
	
<?php endwhile; ?>

</table>

</div>

<div id="input_box">
	<h2>Add Project</h2>
	<form method="post" action="<?=$c->BASE_URL?>/project/submit">
	  <input type="hidden" name="action" value="<?=$action;?>" />
	  <input type="hidden" name="project_id" value="<?=$project_id;?>" />
	  <label for="project_name">Project Name: </label><br />                                               
	  <input id="project_name" name="project_name" size="30" type="text" value="<?=$project_name;?>" />
		<br />
	  <input type="submit" name="submit" value="Submit" />
	</form>
</div>

<?= DisplayStatus($statuslevel, $statusmessage); ?>
