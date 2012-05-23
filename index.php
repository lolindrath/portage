<?php
	include_once('global.php');
	$start = microtime_float();
	
//	$db = db_start();
	$session = MvcSession::singleton();
	$auth = auth_start();

	$c = new IndexController();
	$c->route(null, null);

?>
