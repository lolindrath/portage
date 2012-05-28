<?php

//set the timezone
putenv("TZ=US/Eastern");
class Config
{

	private static $instance;

	public $OLD_ACTION = 30;
	public $COOKIE_TIMEOUT = 2592000; //30 days
	public $offset = 2;

	public $BASE_URL;
	public $dbUserName = "";
	public $dbPassword = "";
	public $host = "";
	public $database = "";
	public $dbtype = "mysql";

	public $dsn;

	private function __construct()
	{
		$this->BASE_URL = (($_SERVER['HTTPS'] != '') ? "https://" : "http://");

		$this->BASE_URL .= $_SERVER['HTTP_HOST'] . '/portage'; //no trailing slash and don't include the host
		$this->dsn = "$this->dbtype://$this->dbUserName:$this->dbPassword@$this->host/$this->database";
	}

	public static function singleton()
	{
		if(!isset(self::$instance))
		{
			$c = __CLASS__;
			self::$instance = new $c;
		}

		return self::$instance;
	}
}
?>
