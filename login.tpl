<h1><?=$error; ?></h1>
<form action="<?=$c->BASE_URL?>/login/submit" method="post" name="loginForm">
<table border="0">
<tr>
	<td>Username:</td><td><input type="text" name="username" value="<?=$username; ?>" /></td>
</tr>
<tr>
	<td>Password:</td><td><input type="password" name="password" value="<?=$password; ?>" /></td>
</tr>
</table>
	<input type="submit" name="submit" value="Login" />
</form>
