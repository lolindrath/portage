<?php
class TodoEditController extends MvcController
{	
	public function route($options, $tpl)
	{
		global $db;
		$model = new TodoModel();

		$c = Config::singleton();
		$tpl->set('title', 'Portage - Edit Next Action');
	
		if(!empty($options[$c->offset+2]))
		{
			$row = $model->getTodoById($options[$c->offset+2]);

			if($row)
			{
				$tpl->set('content', TodoModel::DisplayTodoBox($row['id'], $row['description'], $row['notes'], $row['context_id'], $row['project_id'], $row['due']));
			}
			else
			{
				$tpl->set('statuslevel', 'warning');
				$tpl->set('statusmessage', 'Next Action not found!');
			}
		}
		else
		{
			$tpl->set('statuslevel', 'warning');
			$tpl->set('statusmessage', 'Next Action not found!');
		}
	}
}
?>
