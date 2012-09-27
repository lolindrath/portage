<?php

class ProjectModel extends MvcModel
{
	public function __construct()
	{
		parent::__construct();
	}

	function insertProject($name, $position)
	{
		$query = $this->db->prepare('INSERT INTO projects (name, position) VALUES (:name, :position)');
		$query->bindParam(':name', $name);
		$query->bindParam(':position', $position);

		$query->execute();
		return $query->errorInfo();
	}

	function updateProject($id, $name)
	{
		$query = $this->db->prepare('UPDATE projects SET name=:name WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->bindParam(':name', $name);

		return $query->execute();
	}

	function deleteProject($id)
	{
		$query = $this->db->prepare('DELETE FROM projects WHERE id=:id');
		$query->bindParam(':id', $id);

		return $query->execute();
	}

	function reorderProjects($oldPosition)
	{
		$query = $this->db->prepare('UPDATE projects SET position=position-1 WHERE position > :old');
		$query->bindParam(':old', $oldPosition);

		return $query->execute();
	}

	function getAllProjects()
	{
		$query = $this->db->prepare('SELECT  P.*, COUNT(T.id) todo_count FROM projects P LEFT JOIN todos T ON P.id  = T.project_id AND T.done = 0 GROUP BY P.position');
		$query->execute();
		return $query;
	}

	function getProject($id)
	{
		$query = $this->db->prepare('SELECT * FROM projects WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->execute();
		return $query->fetch(PDO::FETCH_ASSOC);
	}

	function maxPosition()
	{
		$query = $this->db->prepare('SELECT MAX(position) AS max FROM projects');
		$query->execute();

		$row = $query->fetch(PDO::FETCH_ASSOC);
		return $row['max'];
	}

	function updatePosition($id, $position)
	{
		$query = $this->db->prepare('UPDATE projects SET position=:position WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->bindParam(':position', $position);

		$query->execute();
	}

	function getByName($name)
	{
		$query = $this->db->prepare('SELECT * FROM projects WHERE name=:name');
		$query->bindParam(':name', $name);
		$query->execute();

		return $query;
	}

	function getIdByPosition($position)
	{
		$query = $this->db->prepare('SELECT id FROM projects WHERE position=:position');
		$query->bindParam(':position', $position);

		$query->execute();

		return $query->fetch(PDO::FETCH_ASSOC);

	}

	function moveDown($id)
	{
		$row = $this->getProject($id);

		$max = $this->maxPosition(); 

		if($row['position'] != $max)
		{
			$id = $this->getIdByPosition($row['position']+1);

			$this->updatePosition($row['id'], $row['position']+1);

			$this->updatePosition($id['id'], $row['position']);

			return true;
		}
		else
		{
			return false;
		}	
	}

	function moveUp($id)
	{
		$row = $this->getProject($id);
	
		if($row['position'] != 0)
		{
			$id = $this->getIdByPosition($row['position']-1);

			$this->updatePosition($row['id'], $row['position']-1);
			$this->updatePosition($id['id'], $row['position']);
			return true;	
		}
		else
		{
			return false;
		}
	}

	function getAllProjectsSortedByPosition()
    {
        $query = $this->db->prepare('SELECT * FROM projects ORDER BY position');
        $query->execute();

        return $query;
    }

	public static function DisplayProject($id, $forceShow = false)
	{
		$model = new ProjectModel();
		$todoModel = new TodoModel();
	
		$row = $model->getProject($id);
		$todoQuery = $todoModel->getProjectSortedByDue($id);
	
		if(!$row && $forceShow)
		{
			print '<h2>Project Not Found</h2>';
			return;
		}
	
		$projectName = $row['name'];
		$projectID = $row['id'];

		$rows = $todoQuery->fetchAll();
		$rowCount = count($rows);

		if($rowCount == 0 && $forceShow)
		{
			print '<div class="contexts">';
			print '<h2>'.$projectName.'</a></h2>';
			print '<ul>';
			print '<li>No Next Actions Found</li>';
			print '</ul>';
			print '</div>';
		}
		else if($rowCount > 0)
		{
			print '<div class="contexts">';
			$imgSrc = "collapse.png";
	
			$tpl = & new Template('views/singleproject.tpl');
			$tpl->set('c', Config::singleton());
			$tpl->set('projectID', $projectID);
			$tpl->set('projectName', $projectName);
			$tpl->set('todos', $rows);
	
			print $tpl->fetch();

			print  "</div>\n";
			
		}//endif
	}
}
?>
