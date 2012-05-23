<?php

abstract class MvcModel
{
	protected $db;
	protected $config;

	public function __construct()
	{
		$this->config = Config::singleton();
		$this->db = new PDO($this->config->dbtype . ':host=' . $this->config->host . ';dbname=' . $this->config->database, $this->config->dbUserName, $this->config->dbPassword, 
array(
  PDO::ATTR_PERSISTENT => true
));
	}

}

?>
