<?php 
$todoModel = new TodoModel();
$projectModel = new ProjectModel(); 

$projects = $projectModel->getAllProjects();
?>

Portage -=TextViewExport=- -=<?=date("F j, Y, g:i a");?>=- -=<?php print $todoModel->getNotDone(); ?>=-

<?php while($row = $contexts->fetch(PDO::FETCH_ASSOC)): ?>
		<?php ContextModel::DisplayContext($row["id"], false, true); ?>
<?php endwhile; ?>

[Projects]
<?php foreach($projects as $p): ?>
	<?=$p["name"]; ?> (<?=$p["todo_count"]; ?>)
<?php endforeach; ?>
