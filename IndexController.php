<?php
class IndexController extends MvcController
{
	function __construct()
	{
		parent::__construct();
	}

	public function route($options, $tpl)
	{
		global $auth;
		$c = Config::singleton();

		if((strpos($_SERVER["REDIRECT_URL"], "login/submit") >= 0
			&& strpos($_SERVER["REDIRECT_URL"], "login/submit") !== false) 
			|| $auth->authenticated() === true )
		{
			//do nothing
		}
		else
		{
			//force them to the login page
			$_SERVER["REDIRECT_URL"] = "/portage/login";
		}

		$tpl = & new Template('views/index.tpl');
		$tpl->set('c', Config::singleton());

		$options = explode("/", $_SERVER["REDIRECT_URL"]);

		if($options[$c->offset] == "login")
		{
			$login = new LoginController();
			$login->route($options, &$tpl);
		}
		else if($options[$c->offset] == "todo")
		{
			if($options[$c->offset+1] == "edit")
			{
				$todoEdit = new TodoEditController();
				$todoEdit->route($options, &$tpl);
			}
			else
			{
				if($options[$c->offset+1] == 'submit')
				{
					//set some cookies
					setcookie("last_project", $_REQUEST["project_id"], time()+$c->COOKIE_TIMEOUT, "/");
					setcookie("last_context", $_REQUEST["context_edit_id"], time()+$c->COOKIE_TIMEOUT, "/");
				}

				$todo = new TodoController();
				$todo->route($options, &$tpl);
			}
		}
		else if($options[$c->offset] == "aging")
		{
			$aging = new AgingController();
			$aging->route($options, &$tpl);
		}
		else if($options[$c->offset] == "week")
		{
			$week = new WeekController();
			$week->route($options, &$tpl);
		}
		else if($options[$c->offset] == "context")
		{
			$context = new ContextController();
			$context->route($options, &$tpl);
		}
		else if($options[$c->offset] == "project")
		{
			$project = new ProjectController();
			$project->route($options, &$tpl);
		}
		else if($options[$c->offset] == "completed")
		{
			$completed = new CompletedController();
			$completed->route($options, &$tpl);
		}
		else if($options[$c->offset] == "text")
		{
			$text = new TextController();
			$text->route($options, &$tpl);
		}
		else if($options[$c->offset] == "not_done")
		{
			$todoModel = new TodoModel();
			
			$tpl = new Template('views/not_done.tpl');
			$tpl->set('c', Config::singleton());
			$tpl->set('not_done', $todoModel->getNotDone());
		}
		else if($options[$c->offset] == "waitingfor")
		{
			$waiting = new WaitingForController();
			$waiting->route($options, &$tpl);
		}
		else if($options[$c->offset] == "somedaymaybe")
		{
			$someday = new SomedayMaybeController();
			$someday->route($options, &$tpl);
		}
		else
		{
			$todo = new TodoController();
			$todo->route($options, &$tpl);
		}

		$todoModel = new TodoModel();
		$tpl->set('not_done', $todoModel->getNotDone());
		$tpl->set('host', $_SERVER['HTTP_HOST']);
		$end = microtime_float();
		global $start;
		$time = round($end-$start, 3);
		$tpl->set('time', $time);
		print $tpl->fetch();
	}
}
?>
