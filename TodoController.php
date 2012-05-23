<?php

class TodoController extends MvcController
{

	public function route($options, $tpl)
	{
		global $db;
		
		$model = new TodoModel();
		
		$c = Config::singleton();

		$tpl->set('title', 'Portage - Next Actions');

		$body = & new Template('todo.tpl');
		$body->set('c', Config::singleton());

		if($options[$c->offset+1] == "submit")
		{
			if(!isset($_REQUEST["description"]) || $_REQUEST["description"] == '')
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Description not set');
			}
			else if(!is_null($_REQUEST["due"]) && $_REQUEST["due"] != '' && strtotime($_REQUEST["due"]) == -1)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Due date is badly formatted');
			}
			else if(strlen($_REQUEST["description"]) > 100)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Description is too long, max length is 100');
			}
			else if(strlen($_REQUEST["notes"]) > 6000)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Notes field is too long, max length is 6,000');
			}
			else
			{
				if(!isset($_REQUEST["project_id"]) || $_REQUEST["project_id"] == '')
					$_REQUEST["project_id"] = 'NULL';
	
				$date = 'NULL';
				if(!empty($_REQUEST["due"]) && $_REQUEST["due"] !== '')
				{
					
					$date = "'".date("Y-m-d", strtotime($_REQUEST["due"]))."'";
				}
	
				if(isset($_REQUEST["todo_id"]) && !empty($_REQUEST["todo_id"]))
				{
					$model->updateTodo($_REQUEST['todo_id'], $_REQUEST['context_edit_id'], $_REQUEST['description'], $_REQUEST['notes'], $_REQUEST['due'], $_REQUEST['project_id']);
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Next action was successfully updated');
				}
				else
				{
					$model->insertTodo($_REQUEST['context_edit_id'], $_REQUEST['description'], $_REQUEST['notes'], $_REQUEST['due'], $_REQUEST['project_id']);
					$status =  '<div class="confirmation">Next action was successfully added</div>';
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Next action was successfully added');
				}
			}
		}
		else if($options[$c->offset+1] == "check" && !empty($options[$c->offset+2]))
		{
			$model->checkTodo($options[$c->offset+2]);
	
			$body->set('statuslevel', 'confirmation');
			$body->set('statusmessage', 'Action successfully marked complete');
			
		}
		else if($options[$c->offset+1] == "delete" && !empty($options[$c->offset+2]))
		{
			$model->deleteTodo($options[$c->offset+2]);
	
			$body->set('statuslevel', 'confirmation');
			$body->set('statusmessage', 'Action successfully deleted');
		}

		$body->set('contexts', $model->getTodoContexts());
		$body->set('context_id', $_REQUEST["context_id"]);
		$body->set('display_context', $_REQUEST["action"]);
	
		$body->set('completed', $model->getLastCompleted());
	
		$tpl->set('content', $body->fetch());
	
		return;
	}
}
?>
