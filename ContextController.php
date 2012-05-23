<?php
class ContextController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
		$c = Config::singleton();
		$model = new ContextModel();

		$tpl->set('title', 'Portage - Contexts');
	
		$body = & new Template('contexts.tpl');
		$body->set('c', Config::singleton());
		
		if($options[$c->offset+1] == "delete" && !empty($options[$c->offset+2]))
		{
			$row = $model->getContext($options[$c->offset+2]);
			$model->deleteContext($row['id']);
	
			$model->reorderContexts($row['position']);
	
			$body->set('statuslevel', 'confirmation');
			$body->set('statusmessage', 'Context successfully deleted.');
		}
		else if($options[$c->offset+1] == "edit" && !empty($options[$c->offset+2]))
		{
			$row = $model->getContext($options[$c->offset+2]);
	
			$body->set('context_id', $row['id']);
			$body->set('context_name', $row['name']);
		}
		else if($options[$c->offset+1] == "submit")
		{
			$result = $model->getByName($_REQUEST['context_name']);
	
			if(!isset($_REQUEST["context_name"]) || empty($_REQUEST["context_name"]))
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Context name cannot be blank.');
			}
			else if(strlen($_REQUEST["context_name"]) > 255)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Context name cannot be longer than 255 characters.');
			}
			else if($result->rowCount() > 0)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Context name must be unique.');
			}
			else
			{
				if(empty($_REQUEST["context_id"]))
				{
					$newMax = $model->maxPosition() + 1;
					
					$model->insertContext($_REQUEST['context_name'], $newMax);
	
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Context successfully added.');
				}
				else
				{
					$body->set('action', 'add_context');
					
					$model->updateContext($_REQUEST['context_id'], $_REQUEST['context_name']);	
	
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Context successfully updated.');
				}
			}
		}
		else if($options[$c->offset+1] == "up" && !empty($options[$c->offset+2]))
		{
			
			if($model->moveUp($options[$c->offset+2]))
			{	
				$body->set('statuslevel', 'confirmation');
				$body->set('statusmessage', 'Context successfully reordered.');
			}
			else
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Contexts cannot move past the top of the list.');
			}
		}
		else if($options[$c->offset+1] == "down" && !empty($options[$c->offset+2]))
		{
			if($model->moveDown($options[$c->offset+2]))	
			{
				$body->set('statuslevel', 'confirmation');
				$body->set('statusmessage', 'Context successfully reordered.');
			}
			else
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Contexts cannot move past the bottom of the list.');
			}
		}
		else if($options[$c->offset+1] == "display" && !empty($options[$c->offset+2]))
		{
			$todoModel = new TodoModel();
			$body =& new Template('todo.tpl');
			$body->set('c', Config::singleton());
			$body->set('completed', $todoModel->getLastCompleted());

			$contextsQuery = $model->getAllContexts(); 

			$body->set('contexts', $contextsQuery);
			$body->set('context_id', $options[$c->offset+2]);
			$body->set('display_context', "display_context");
	
		}
		else
		{
			$body->set('action', 'add_context');
		}
	
		$result = $model->getAllContextsSortedByPosition(); 
		$body->set('contexts', $result);
		
		$tpl->set('content', $body->fetch());
	}
}
?>
