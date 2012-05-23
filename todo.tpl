<div id="display_box">

<?php if(isset($context_id) && !empty($context_id) && $display_context == "display_context"): ?>

	<?php ContextModel::DisplayContext($context_id, true); ?>

<?php else:?>

	<?php while($row = $contexts->fetch(PDO::FETCH_ASSOC)): ?>
		<?php ContextModel::DisplayContext($row["id"], false); ?>
	<?php endwhile; ?>
	
<?php endif; ?>

<div class="contexts">

  <h2>Just done</h2>
  <table class="next_actions" id="holding" cellspacing="5" cellpadding="0" border="0">
  <tr></tr>  
  </table>
</div>

<div class="contexts">
  <h2>Completed items</h2>
  <ul>
	<?php while($row = $completed->fetch(PDO::FETCH_ASSOC)): ?>
		<li><img src='<?=$c->BASE_URL?>/img/done-checkmark.gif' alt="done checkmark" />&nbsp;<?=htmlentities($row["description"],ENT_QUOTES, 'utf-8');?></li>
	<?php endwhile; ?>
   </ul>
</div>

</div><!-- End of display_box -->

<?= TodoModel::DisplayTodoBox(); ?>

<?= DisplayStatus($statuslevel, $statusmessage); ?>
