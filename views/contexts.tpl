<div id="display_box">
<table class="list" cellspacing="0" cellpadding="5" width="450" border="0">

<?php $rowNum = 0; ?>

<?php while($row = $contexts->fetch(PDO::FETCH_ASSOC)): ?>
	<?php if(even($rowNum)): ?>
		<tr class="even_row">
	<?php else: ?>
		<tr class="odd_row">
	<?php endif; ?>

	<?php $rowNum++; ?>

	<td width="20"><?=$row["position"];?></td>
	<td width="390"><a href="<?=$c->BASE_URL?>/context/display/<?=$row["id"];?>" title="view context"><?=htmlentities($row["name"],ENT_QUOTES, 'utf-8');?></a></td>
	<td width="20">
	<a href="<?=$c->BASE_URL?>/context/edit/<?=$row['id'];?>" title="edit context">
		<img src="<?=$c->BASE_URL?>/img/edit.png" height="16" width="16" alt="edit context" />
	</a>
	</td>
	<td width="20">
	<a href="<?=$c->BASE_URL?>/context/delete/<?=$row["id"];?>" title="delete context">
		<img src="<?=$c->BASE_URL?>/img/delete.png" width="16" height="16" alt="delete context" />
	</a>
	</td>
	<td width="12">
	<a href="<?=$c->BASE_URL?>/context/up/<?=$row["id"];?>" title="move context up">
		<img src="<?=$c->BASE_URL?>/img/up_arrow.png" width="10" height="10" alt="move context up" />
	</a>
	</td>
	<td width="12">
	<a href="<?=$c->BASE_URL?>/context/down/<?=$row["id"];?>" title="move context down">
		<img src="<?=$c->BASE_URL?>/img/down_arrow.png" width="10" height="10" alt="move context up" />
	</a>
	</td>
	</tr>
	
<?php endwhile; ?>

</table>

</div>

<div id="input_box">
	<h2>Add Context</h2>
	<form method="post" action="<?=$c->BASE_URL?>/context/submit">
	  <input type="hidden" name="context_id" value="<?=$context_id;?>" />
	  <label for="context_name">New context</label><br />
	  <input id="context_name" name="context_name" size="30" type="text" value="<?=$context_name;?>" />
		<br />
	  <input type="submit" name="submit" value="Submit" />
	</form>
</div>

<?= DisplayStatus($statuslevel, $statusmessage); ?>
