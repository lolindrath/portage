<?php
class ContactController extends MvcController
{
	public function route($options, $tpl)
	{
		global $db;
		$tpl->set('title', 'Portage - Contacts');
	
		$body = & new Template('contacts.tpl');
		$body->set('c', Config::singleton());
	
		if($options[2] == "submit")
		{
			if(!empty($_REQUEST["contact_id"]))
			{
				$result = $db->query("SELECT id FROM contacts WHERE id=" . $_REQUEST["contact_id"]);
				
				if($result->numRows() == 1)
				{
					$sql = "UPDATE contacts SET first_name='" . $_REQUEST["first_name"] . "', last_name='" . $_REQUEST["last_name"] .
					"', email='" . $_REQUEST["email"] . "', home_phone='" . $_REQUEST["home_phone"] . "', work_phone='" . $_REQUEST["work_phone"] .
					"', cell_phone='" . $_REQUEST["cell_phone"] . "', address1='" . $_REQUEST["address1"] . "', address2='" . $_REQUEST["address2"] .
					"', city='" . $_REQUEST["city"] . "', state='" . $_REQUEST["state"] . "', zip='" . $_REQUEST["zip"] . "' WHERE id = " . $_REQUEST["contact_id"];
	
					$result = $db->query($sql);
	
					$body->set('statuslevel', 'confirmation');
					$body->set('statusmessage', 'Contact successfully updated.');
				}
			}
			else
			{
				$sql = "INSERT INTO contacts (first_name, last_name, email, home_phone, work_phone, cell_phone, address1, address2, city, state, zip) VALUES ('" .
					$_REQUEST["first_name"] . "', '" . $_REQUEST["last_name"] . "', '" . $_REQUEST["email"] . "', '" . $_REQUEST["home_phone"] . "', '" .
					$_REQUEST["work_phone"] . "', '" . $_REQUEST["cell_phone"] . "', '" . $_REQUEST["address1"] . "', '" . $_REQUEST["address2"] . "', '" .
					$_REQUEST["city"] . "', '" . $_REQUEST["state"] . "', '" . $_REQUEST["zip"] . "')";
	
				$db->query($sql);
	
				$body->set('statuslevel', 'confirmation');
				$body->set('statusmessage', 'Contact successfully added.');
			}
		}
		else if($options[2] == "edit" && !empty($options[3]))
		{
			$sql = "SELECT * FROM contacts WHERE id=" . $options[3];
	
			$result = $db->query($sql);
	
			if(PEAR::isError($result))
			{
				die($result->getMessage() . " $sql");
			}
	
			if($result->numRows() == 1)
			{
				$row = $result->fetchRow();
	
				$body->set('contact_id', $row['id']);
				$body->set('first_name', $row['first_name']);
				$body->set('last_name', $row['last_name']);
				$body->set('email', $row['email']);
				$body->set('home_phone', $row['home_phone']);
				$body->set('work_phone', $row['work_phone']);
				$body->set('cell_phone', $row['cell_phone']);
				$body->set('address1', $row['address1']);
				$body->set('address2', $row['address2']);
				$body->set('city', $row['city']);
				$body->set('state', $row['state']);
				$body->set('zip', $row['zip']);
			}
			else
			{
				$body->set('statuslevel', 'warning');
				$body->set('statusmessage', 'Contact record not found! ' . $sql);
			}
		}
	
		$result = $db->query("SELECT  * FROM contacts");
	
		$body->set('contacts', $result);
	
		$tpl->set('content', $body->fetch());
	
		$result->free();
	}
}
?>
