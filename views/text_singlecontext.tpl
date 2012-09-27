<?php
print("\n[".$contextName."]\n");

foreach($todos as $t)
{
	$due = '';

	if($t["due"] > 0 && !is_null($t["due"]))
	{
                                $dueDate = strtotime($t["due"]);
		$due = date("Y-m-d", $dueDate);

		if(($days = datediff('d', strtotime(date("Y-m-d")), $dueDate, true)) < 0)
		{
			$due = "[Overdue " . $due . "]";
		}
		else if(($days = datediff('d', strtotime(date("Y-m-d")), $dueDate, true)) == 0)
		{
			$due = "[Today]";
		}
		else
		{
			$days = datediff('d', strtotime(date("Y-m-d")), $dueDate, true);
			if($days < 7 && $days != 1)
			{
				$due = "[" . $days . " days]";
			}
			else if($days == 1)
			{
				$due = "[Tomorrow]";
			}
			else
			{
				$due = "[". $due . "]";
			}
		}
	}

	print("    ".$due . " " . $t["description"]);

	if($t["project_name"])
		print(" [" . $t["project_name"] . "]\n");
	else
		print("\n");
	}	
?>
