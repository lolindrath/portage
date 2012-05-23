<?php

require_once('MVC/MvcSession.php');

class LoginController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db, $session;
		$c = Config::singleton();

		$tpl->set('title', 'Portage - Login');
		$body = & new Template('login.tpl');
		$body->set('c', Config::singleton());
	
		if($options[$c->offset+1] == 'submit')
		{
			$model = new LoginModel();
		
			$row = $model->getUser($_REQUEST['username']);
			
			if($row['password'] == md5($_REQUEST['password']))
			{
				setcookie('loggedin', 1, time()+60*60*24*30, "/"); //expires in 30 days
				header("Location: " . $c->BASE_URL);
				exit();
			}
			else
			{
				$body->set('error', 'Bad username/password');
			}

		}
		else if($options[$c->offset+1] == 'logout')
		{
			setcookie('loggedin', 0, -60*60*24*30, "/");
			header("Location: " . $c->BASE_URL);
			exit();
		}

		$body->set('username', '');
		$body->set('password', '');
		$tpl->set('javascript_bodyLoad', "document.loginForm.username.focus();\n");
	
		$tpl->set('content', $body->fetch());
	}
}
?>
