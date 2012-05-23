<?php
class CompletedController extends MvcController
{
	public function route($options, $tpl)
	{	
		global $db;
	
		$todoModel = new TodoModel();		

		$tpl->set('title', 'Portage - Projects');
	
		$body = & new Template('completed.tpl');
		$body->set('c', Config::singleton());
	
		
		$body->set('completed', $todoModel->getCompletedSortedByCompleted());
	
		$tpl->set('content', $body->fetch());
	}
}
?>
