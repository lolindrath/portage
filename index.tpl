<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="<?=$c->BASE_URL?>/favicon.ico">
	<style type="text/css" media="screen">
		@import url(<?=$c->BASE_URL?>/standard.css);
	</style>
	<link rel="stylesheet" type="text/css" media="all" href="<?=$c->BASE_URL?>/datechooser.css">
	<script type="text/javascript">
		var baseUrl = "<?=$c->BASE_URL?>";
	</script>

	<script type="text/javascript" src="<?=$c->BASE_URL?>/mootools.js"></script>
	<script type="text/javascript" src="<?=$c->BASE_URL?>/standard.js"></script>
	<script type="text/javascript" src="<?=$c->BASE_URL?>/datechooser.js"></script>

	<script type="text/javascript">
	<!--
		function bodyLoad()
		{
			<?=$javascript_bodyLoad; ?>
		}
	-->
	</script>

<title><?=$title; ?></title>
</head>
<body onload="javascript:bodyLoad();javascript:toggleAll('notes','none');toggleAllImages();document.f.description.focus();">
<!-- Todays Date -->
<div id="Header">
<div id="shortcuts">
	<a href="<?=$c->BASE_URL?>/project/" title="Projects">Projects</a> &nbsp; <a href="<?=$c->BASE_URL?>/context/" title="Contexts">Contexts</a> &nbsp; <a href="<?=$c->BASE_URL?>/completed/" title="Completed">Completed</a> &nbsp;<a href="<?=$c->BASE_URL?>/login/logout/" title="Logout">Logout</a>&nbsp;<a accesskey="x" href="<?=$c->BASE_URL?>/text/" title="View a plain text feed of your next actions Access Key: Alt+X"><span style="font-family: verdana, sans-serif; font-size: 10px; font-weight:bold; text-decoration:none; color: white; background-color: #F60; border:1px solid;border-color: #FC9 #630 #330 #F96; padding:0px 3px 0px 3px; margin:0px;">TXT</span></a>
</div>
<h1>
	<span class="badge" id="not_done"><?=$not_done; ?></span>
	<?=date("F j, Y, g:i a");?>
</h1>

<div id="Tabs">
<ul>
	<li><a accesskey="t" href="<?=$c->BASE_URL?>/" title="Home Access Key: Alt+T">Home</a></li>
	<li><a accesskey="w" href="<?=$c->BASE_URL?>/week/" title="Weekly Summary Key: Alt+W">Agenda</a></li>
	<li><a accesskey="w" href="<?=$c->BASE_URL?>/waitingfor/" title="Waiting For: Alt+W">@Waiting For</a></li>
	<li><a accesskey="w" href="<?=$c->BASE_URL?>/somedaymaybe/" title="Someday/Maybe Key: Alt+W">@Someday/Maybe</a></li>
	<li><a accesskey="a" href="<?=$c->BASE_URL?>/aging/" title="Aging Report Key: Alt+A">Aging</a></li>
</ul>
</div>

</div>

<?=$content; ?>

<div id="footer">Execution time: <?=$time;?>s <br />Made with <a href="http://php.net">PHP</a> and <a href="http://www.michelf.com/projects/php-markdown/">PHP Markdown</a> and <a href="http://validator.w3.org/check/referer">Valid XHTML</a></div>
<div id="debug"></div>
</body>
</html>
