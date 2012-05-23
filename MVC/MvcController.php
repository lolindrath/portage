<?php

abstract class MvcController
{
	protected $config;

	public function __construct()
	{
		$config = Config::singleton();
	}

	public function __destruct()
	{

	}

	abstract public function route($options, $tpl);
}

?>
