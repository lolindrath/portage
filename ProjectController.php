<?php
class ProjectController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
		$c = Config::singleton();
		
		$model = new ProjectModel();

		$tpl->set('title', 'Portage - Projects');
	
		$body = & new Template('views/projects.tpl');
		$body->set('c', Config::singleton());
	
		if($options[$c->offset+1] == "delete" && !empty($options[$c->offset+2]))
		{

			$oldId = $model->getProject($options[$c->offset+2]);
	
			$model->deleteProject($oldId['id']);
	
			$model->reorderProjects($oldId['position']);
	
			$body->set('statuslevel', 'confirmation');
			$body->set('statusmessage', 'Project successfully deleted.');
	
			$body->set('action', 'add_project');
		}
		else if($options[$c->offset+1] == "edit" && !empty($options[$c->offset + 2]))
		{
			$body->set('project_id', $options[$c->offset+2]);
	
			$row = $model->getProject($options[$c->offset+2]);
	
			$body->set('project_name', $row['name']);
	
			$body->set('action', 'submit_edit_project');
		}
		else if($options[$c->offset+1] == "submit")
		{
			$result = $model->getByName($_REQUEST['project_name']);
	
			if(!isset($_REQUEST["project_name"]) || empty($_REQUEST["project_name"]))
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Project name cannot be blank.');
			}
			else if(strlen($_REQUEST["project_name"]) > 255)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Project name cannot be longer than 255 characters.');
			}
			else if($result->rowCount() > 0)
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Project name must be unique.');
			}
			else
			{
				if(empty($_REQUEST["project_id"]))
				{
					$max = $model->maxPosition();	
					
					$model->insertProject($_REQUEST['project_name'], $max+1);
					
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Project successfully added.');
					$body->set('action', 'add_project');
				}
				else
				{
					$model->updateProject($_REQUEST['project_id'], $_REQUEST['project_name']);
	
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Project successfully updated.');
				}
			}
		}
		else if($options[$c->offset+1] == "up" && !empty($options[$c->offset+2]))
		{
			if($model->moveUp($options[$c->offset+2]))
			{	
				$body->set('statuslevel', 'confirmation');
				$body->set('statusmessage', 'Project successfully reordered.');
			}
			else
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Projects cannot move past the top of the list.');
			}
		}
		else if($options[$c->offset+1] == "down" && !empty($options[$c->offset+2]))
		{
			if($model->moveDown($options[$c->offset+2]))
			{
				$body->set('statuslevel', 'confirmation');
				$body->set('statusmessage', 'Project successfully reordered.');
			}
			else
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Projects cannot move past the bottom of the list.');
			}
		}
		else if($options[$c->offset+1] == "display" && !empty($options[$c->offset+2]))
		{
			$body = & new Template('views/project.tpl');
			$body->set('c', Config::singleton());
			$body->set('project_id', $options[$c->offset+2]);
			$todoModel = new TodoModel();
			$body->set('completed', $todoModel->getLastCompleted());
			$body->set('statuslevel', '');
			$body->set('statusmessage', '');
		}
		else
		{
			$body->set('action', 'add_project');
		}
	
		$body->set('projects', $model->getAllProjects());
	
		$tpl->set('content', $body->fetch());
	
	}
}
?>
