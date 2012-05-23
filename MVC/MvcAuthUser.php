<?php
	
	require_once('MVC/MvcAuth.php');
	
	class MvcAuthUser extends MvcAuth
	{
		function __construct()
		{
			parent::__construct();
		}

		function authenticated()
		{
			return($_COOKIE['loggedin'] == 1);
		}

		function __destruct()
		{
			parent::__destruct();
		}

		function __default()
		{
		}
	}
?>
