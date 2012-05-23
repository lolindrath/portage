<?php

class ContextModel extends MvcModel
{
	public function __construct()
	{
		parent::__construct();
	}

	function insertContext($name, $position)
	{
		$query = $this->db->prepare('INSERT INTO contexts (name, position) VALUES (:name, :position)');
		$query->bindParam(':name', $name);
		$query->bindParam(':position', $position);

		$query->execute();
		return $query->errorInfo();
	}

	function updateContext($id, $name)
	{
		$query = $this->db->prepare('UPDATE contexts SET name=:name WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->bindParam(':name', $name);
		return $query->execute();
	}

	function deleteContext($id)
	{
		$query = $this->db->prepare('DELETE FROM contexts WHERE id=:id');
		$query->bindParam(':id', $id);

		return $query->execute();
	}

	function reorderContexts($oldPosition)
	{
		$query = $this->db->prepare('UPDATE contexts SET position=position-1 WHERE position > :old');
		$query->bindParam(':old', $oldPosition);

		return $query->execute();
	}

	function getAllContexts()
	{
		$query = $this->db->prepare('SELECT  P.*, COUNT(T.id) todo_count FROM contexts P LEFT JOIN todos T ON P.id  = T.context_id AND T.done = 0 GROUP BY P.position');
		$query->execute();
		return $query;
	}
	
	function getAllContextsSortedByPosition()
	{
		$query = $this->db->prepare('SELECT * FROM contexts ORDER BY position');
		$query->execute();

		return $query;		
	}

	function getContext($id)
	{
		$query = $this->db->prepare('SELECT * FROM contexts WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->execute();
		return $query->fetch(PDO::FETCH_ASSOC);
	}

	function maxPosition()
	{
		$query = $this->db->prepare('SELECT MAX(position) AS max FROM contexts');
		$query->execute();

		$row = $query->fetch(PDO::FETCH_ASSOC);
		return $row['max'];
	}

	function updatePosition($id, $position)
	{
		$query = $this->db->prepare('UPDATE contexts SET position=:position WHERE id=:id');
		$query->bindParam(':id', $id);
		$query->bindParam(':position', $position);

		$query->execute();
	}

	function getByName($name)
	{
		$query = $this->db->prepare('SELECT * FROM contexts WHERE name=:name');
		$query->bindParam(':name', $name);
		$query->execute();

		return $query;
	}

	function getIdByPosition($position)
	{
		$query = $this->db->prepare('SELECT id FROM contexts WHERE position=:position');
		$query->bindParam(':position', $position);

		$query->execute();

		return $query->fetch(PDO::FETCH_ASSOC);

	}

	function moveDown($id)
	{
		$row = $this->getContext($id);

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
		$row = $this->getContext($id);
	
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
	
	public static function DisplayContext($id, $forceShow = false, $textView = false)
	{
		$contextModel = new ContextModel();
		$todoModel = new TodoModel();
	
		$row = $contextModel->getContext($id); 
		$todoQuery = $todoModel->getContextSortedByDue($id); 
		
		$rows = $todoQuery->fetchAll();
		$rowCount = count($rows);
		
		if($row == null && $forceShow == true)
		{
			print '<h2>Context Not Found</h2>';
			return;
		}
	
		$contextName = $row['name'];
		$contextID = $row['id'];
	
		if($rowCount == 0 && $forceShow == true)
		{
			print '<div class="contexts">';
			print '<h2>'.$contextName.'</a></h2>';
			print '<ul>';
			print '<li>No Next Actions Found</li>';
			print '</ul>';
			print '</div>';
		}
		else if($rowCount > 0)
		{
			$tpl = & new Template('singlecontext.tpl');
	
			if($textView)
			{
				$tpl = & new Template('text_singlecontext.tpl');
			}
	
			$tpl->set('c', Config::singleton());
			$tpl->set('contextID', $contextID);
			$tpl->set('contextName', $contextName);
			$tpl->set('todos', $rows);
			
			print $tpl->fetch();
		}//endif
	}
}
?>
