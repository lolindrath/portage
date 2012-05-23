<?php
class TextController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
		$contextModel = new ContextModel();

		$tpl = new Template('textview.tpl');
		$tpl->set('c', Config::singleton());
	
		$tpl->set('contexts', $contextModel->getAllContextsSortedByPosition());

		header("Content-type: text/plain");
	}
}
?>
