<?php

class WeekController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;

		$model = new TodoModel();

		$tpl->set('title', 'Portage - Weekly');
	
		$body = & new Template('views/week.tpl');
		$body->set('c', Config::singleton());
		$body->set('completed', $model->getLastCompleted());
	
		$weekQuery = $model->getSortedByDue(); 
		
		$body->set('todos', $weekQuery);
	
		$tpl->set('content', $body->fetch());
	
		return;
	}		
}
?>
