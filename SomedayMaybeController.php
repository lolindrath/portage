<?php
class SomedayMaybeController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
	
		$tpl->set('title', 'Portage - Someday/Maybe');
	
		$body = & new Template('somedaymaybe.tpl');
		$body->set('c', Config::singleton());
		
		$tpl->set('content', $body->fetch());
	}
}
?>
