<?php

include_once('DB.php');

include_once('MVC/MvcSession.php');
include_once('MVC/MvcAuthUser.php');
include_once('MVC/MvcAuth.php');
include_once('MVC/MvcController.php');
include_once('MVC/MvcModel.php');

include_once('config.php');

include_once('markdown.php');
include_once('template.php');
include_once('date.php');

include_once('IndexController.php');
include_once('TodoController.php');
include_once('TodoEditController.php');
include_once('LoginController.php');
include_once('AgingController.php');
include_once('WeekController.php');
include_once('ContextController.php');
include_once('ProjectController.php');
include_once('TextController.php');
include_once('ContactController.php');
include_once('SomedayMaybeController.php');
include_once('WaitingForController.php');
include_once('CompletedController.php');

include_once('ProjectModel.php');
include_once('TodoModel.php');
include_once('ContextModel.php');
include_once('LoginModel.php');

function db_start()
{
	$config = Config::singleton();

	$options = array(
		'debug'       => 2,
		'portability' => DB_PORTABILITY_ALL,
	);

	$db=&DB::connect($config->dsn, $config->options);

	if(PEAR::isError($db))
	{
		print $db->getMessage();
	}
	
	$db->setFetchMode(DB_FETCHMODE_ASSOC);

	return $db;
}

function auth_start()
{
	return new MvcAuthUser();
}

function loginFunction($username, $status)
{
     /**
      * Change the HTML output so that it fits to your
      * application.
      */
     echo "<form method=\"post\" action=\"" . $_SERVER['PHP_SELF'] . "?login=1\">";
     echo "<input type=\"text\" name=\"username\">";
     echo "<input type=\"password\" name=\"password\">";
     echo "<input type=\"submit\">";
     echo "</form>";

	echo "<br><br>$username : $status";
}

function DisplayStatus($statuslevel = "", $statusmessage = "")
{
	print '<div class="'. $statuslevel . '">' . $statusmessage. '</div>';
}

function even($num)
{
	return $num % 2 == 0;
}

// Function to calculate script execution time.
function microtime_float()
{
    list ($msec, $sec) = explode(' ', microtime());
    $microtime = (float)$msec + (float)$sec;
    return $microtime;
} 


?>
