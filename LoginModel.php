<?php

class LoginModel extends MvcModel
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getUser($userName)
	{
		$query = $this->db->prepare('SELECT * FROM auth WHERE username=:username');
		$query->bindParam(':username', $userName);
		$query->execute();

		return $query->fetch(PDO::FETCH_ASSOC);
	}
}
