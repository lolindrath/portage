<?php $c = Config::singleton(); ?>
<div id="display_box_projects">
<div class="contexts">
  <h2>Completed items</h2>
  <table class="next_actions" cellspacing="5" cellpadding="0" border="0">
	<?php while($row = $completed->fetch(PDO::FETCH_ASSOC)): ?>
	<tr>
		<td valign="top"><img src='<?=$c->BASE_URL?>/img/done-checkmark.gif' alt="done checkmark" /></td><td valign="top"><?=htmlentities($row["description"],ENT_QUOTES, 'utf-8');?> (<?=$row['context_name'];?>, <?=$row['project_name'];?>)</td>
	</tr>
	<?php endwhile; ?>
   </table>
</div>
</div>
