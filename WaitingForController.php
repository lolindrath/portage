<?php
class WaitingForController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
	
		$tpl->set('title', 'Portage - Waiting For');
	
		$body = & new Template('views/waitingfor.tpl');
		$body->set('c', Config::singleton());
		
		$tpl->set('content', $body->fetch());
	}
}
?>
