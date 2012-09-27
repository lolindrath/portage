<?php

class TodoModel extends MvcModel
{
	public function __construct()
	{
		parent::__construct();
	}

	function getCompletedSortedByCompleted()
	{
		$query = $this->db->prepare('SELECT t.*, projects.name AS project_name, contexts.name AS context_name from todos t LEFT JOIN projects ON projects.id = t.project_id LEFT JOIN contexts ON contexts.id = t.context_id WHERE done=1 ORDER BY completed ASC, created ASC');
		$query->execute();
		return $query;
	}

	function getLastCompleted()
	{
		$query = $this->db->prepare('SELECT * FROM todos WHERE done=1 ORDER BY completed DESC LIMIT 5');
		$query->execute();
		return $query;
	}

	function getSortedByDue()
	{
		$query = $this->db->prepare('SELECT t.*, projects.name AS project_name FROM todos t LEFT JOIN projects ON t.project_id = projects.id WHERE done=0 ORDER BY ISNULL(due), due ASC, created ASC');
		$query->execute();
		return $query;
	}

	function getContextSortedByDue($contextId)
	{
		$query = $this->db->prepare('SELECT t.*, projects.name AS project_name, contexts.name AS context_name from todos t LEFT JOIN projects ON projects.id = t.project_id LEFT JOIN contexts ON contexts.id = t.context_id WHERE done=0 AND context_id=:id ORDER BY ISNULL(due), due ASC, created ASC');
		$query->bindParam(':id', $contextId);
		$query->execute();
		return $query;
	}

	function getProjectSortedByDue($projectId)
	{
		$query = $this->db->prepare('SELECT * from todos t WHERE done=0 AND project_id=:id ORDER BY ISNULL(due), due ASC, created ASC');
		$query->bindParam(':id', $projectId);
		$query->execute();
		return $query;
	}
	
	function getSortedByCreated()
	{
		$query = $this->db->prepare('SELECT t.*, p.name AS project_name FROM todos t LEFT JOIN projects p ON t.project_id = p.id WHERE t.done=0 ORDER BY t.created ASC');
		$query->execute();

		return $query;
	}

	function getTodoById($id)
	{
		$query = $this->db->prepare('SELECT * FROM todos WHERE id=:id');
		$query->bindParam(':id', $id);

		$query->execute();

		return $query->fetch(PDO::FETCH_ASSOC);
	}

	function getNotDone()
	{
		$query = $this->db->prepare('SELECT COUNT(*) not_done FROM todos WHERE done=0 AND context_id <> 27 AND context_id <> 10');
		$query->execute();
		
		$row = $query->fetch(PDO::FETCH_ASSOC);
		
		return $row['not_done'];
	}
	
	function getTodoContexts()
	{
		$query = $this->db->prepare('SELECT DISTINCT C.id id FROM contexts C,todos T WHERE C.id=T.context_id ORDER BY C.position');
		
		$query->execute();
		return $query;
	}
	
	function checkTodo($id)
	{
		$query = $this->db->prepare('UPDATE todos SET done=1, completed=NOW() WHERE id=:id');
		$query->bindParam(':id', $id);

		return $query->execute();
	}

	function deleteTodo($id)
	{
		$query = $this->db->prepare('DELETE FROM todos WHERE id=:id');
		$query->bindParam(':id', $id);

		return $query->execute();
	}

	function updateTodo($id, $context_id, $description, $notes, $due, $project_id)
	{
		if($due == '' || $due == '0000-00-00')
        {
            $due = null;
        }

		$query = $this->db->prepare('UPDATE todos SET context_id=:context_id, description=:description, notes=:notes, due=:due, project_id=:project_id WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->bindParam(':context_id', $context_id);
		$query->bindParam(':description', $description);
		$query->bindParam(':notes', $notes);
		$query->bindParam(':due', $due);
		$query->bindParam(':project_id', $project_id);

		return $query->execute();
	}

	function insertTodo($context_id, $description, $notes, $due, $project_id)
	{
		if($due == '' || $due == '0000-00-00')
		{
			$due = null;
		}

		$query = $this->db->prepare('INSERT INTO todos (context_id, description, notes, created, due, project_id) VALUES (:context_id, :description, :notes, NOW(), :due, :project_id)');
		$query->bindParam(':context_id', $context_id);
		$query->bindParam(':description', $description);
		$query->bindParam(':notes', $notes);
		$query->bindParam(':due', $due);
		$query->bindParam(':project_id', $project_id);
		
		return $query->execute();
	}

	public static function DisplayTodoBox($id = "", $description = "", $notes = "", $context = "", $project = "", $due = "")
	{
		global $db, $options, $offset;
		$contextModel = new ContextModel();
		$projectModel = new ProjectModel();
	
		if($id == "" && $description == "" && $notes == "" && $context == "" && $project == "" && $due == "")
			$add_edit = "add";
		else
			$add_edit = "edit";
		$tpl = & new Template('views/todoform.tpl');
		$tpl->set('c', Config::singleton());
		$tpl->set('id', $id);
		$tpl->set('add_edit', $add_edit);
		$tpl->set('description', $description);
		$tpl->set('notes', $notes);
	
		//this is a hack to set the fields correctly since it can't read the cookies yet (they were just set)
		if($options[$offset+1] == 'submit')
		{
			$tpl->set('context', $_REQUEST['context_edit_id']);
			$tpl->set('project', $_REQUEST['project_id']);
		}
		else
		{
			$tpl->set('context', $context);
			$tpl->set('project', $project);
		}
	
		if($due == "0000-00-00")
		{
			$tpl->set('due', '');
		}
		else
		{
			$tpl->set('due', $due);
		}
	
		if($due == "")
		{
			$tpl->set('dueNoDashes', date("mdY"));
		}
		else
		{	
			$tpl->set('dueNoDashes', date("mdY", strtodate($due)));
		}
	
		$result = $contextModel->getAllContextsSortedByPosition();
		$projects = $projectModel->getAllProjectsSortedByPosition(); 
		$tpl->set('contexts', $result);
		$tpl->set('projects', $projects);
		$temp = $tpl->fetch();
	
		return $temp;
	}
}
?>
