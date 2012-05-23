<?php
class AgingController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
		$model = new TodoModel();

		$tpl->set('title', 'Portage - Aging');
	
		$body = & new Template('aging.tpl');
		$body->set('c', Config::singleton());
		$body->set('completed', $model->getLastCompleted());
	
		$agingQuery = $model->getSortedByCreated();
		
		$body->set('todos', $agingQuery);
	
		$tpl->set('content', $body->fetch());
	
		return;
	}		
}
?>
