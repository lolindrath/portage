<?php

	abstract class MvcAuth
	{
		protected $session;
		function __construct()
		{
			$this->session = MvcSession::singleton();
			//parent::__construct();
		}

		abstract function authenticated();

		function __destruct()
		{
			//parent::__destruct();
		}
	}
?>
