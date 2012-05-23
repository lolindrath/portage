<div id="display_box">
<table class="list" cellspacing="0" cellpadding="5" width="450" border="0">

<?php $rowNum = 0; ?>
<tr>
	<tr>
		<td>Last</td>
		<td>First</td>
		<td>Email</td>
		<td>Home</td>
		<td>Work</td>
		<td>Cell</td>
	</tr>
<?php while($row = $contacts->fetchRow()): ?>
	<?php if(even($rowNum)): ?>
		<tr class="even_row">
	<?php else: ?>
		<tr class="odd_row">
	<?php endif; ?>

	<?php $rowNum++; ?>
	
	<td><a href="<?=$c->BASE_URL?>/contact/edit/<?=$row['id'];?>"><?=$row['last_name'];?></a></td>
	<td><?=$row['first_name'];?></td>
	<td><?=$row['email'];?></td>
	<td><?=$row['home_phone'];?></td>
	<td><?=$row['work_phone'];?></td>
	<td><?=$row['cell_phone'];?></td>
	</tr>

<?php endwhile; ?>

</table>

</div>

<div id="input_box">
	<h2>Add Contact</h2>
	<form method="post" action="<?=$c->BASE_URL?>/contact/submit">
	  <input type="hidden" name="action" value="<?=$action;?>" />
	  <input type="hidden" name="contact_id" value="<?=$contact_id;?>" />
	  <label for="first_name">First Name: </label><br />                                               
	  <input id="first_name" name="first_name" size="30" type="text" value="<?=$first_name;?>" />
		<br />
	  <label for="last_name">Last Name: </label><br />                                               
	  <input id="last_name" name="last_name" size="30" type="text" value="<?=$last_name;?>" />
		<br />
		<label for="email">Email: </label><br />                                               
	  <input id="email" name="email" size="30" type="text" value="<?=$email;?>" />
		<br />
		<label for="home_phone">Home Phone: </label><br />                                               
	  <input id="home_phone" name="home_phone" size="30" type="text" value="<?=$home_phone;?>" />
		<br />
		<label for="work_phone">Work Phone: </label><br />                                               
	  <input id="work_phone" name="work_phone" size="30" type="text" value="<?=$work_phone;?>" />
		<br />
		<label for="cell_phone">Cell Phone: </label><br />                                               
	  <input id="cell_phone" name="cell_phone" size="30" type="text" value="<?=$cell_phone;?>" />
		<br />
		<label for="address1">Address: </label><br />                                               
	  <input id="address1" name="address1" size="30" type="text" value="<?=$address1;?>" />
		<br />
		<label for="address2">Address: </label><br />                                               
	  <input id="address2" name="address2" size="30" type="text" value="<?=$address2;?>" />
		<br />
		<label for="city">City: </label>                                             
	  <input id="city" name="city" size="20" type="text" value="<?=$city;?>" />                                           
		<select name="state" id="state">
			<option  value="AK">AK</option>
			<option  value="AL">AL</option>
			<option  value="AR">AR</option>

			<option  value="AZ">AZ</option>
			<option  value="CA">CA</option>
			<option  value="CO">CO</option>
			<option  value="CT">CT</option>
			<option  value="DC">DC</option>
			<option  value="DE">DE</option>
			<option  value="FL">FL</option>
			<option  value="GA">GA</option>
			<option  value="HI">HI</option>

			<option  value="IA">IA</option>
			<option  value="ID">ID</option>
			<option  value="IL">IL</option>
			<option  value="IN">IN</option>
			<option  value="KS">KS</option>
			<option  value="KY">KY</option>
			<option  value="LA">LA</option>
			<option  value="MA">MA</option>
			<option  value="MD">MD</option>

			<option  value="ME">ME</option>
			<option  value="MI">MI</option>
			<option  value="MN">MN</option>
			<option  value="MO">MO</option>
			<option  value="MS">MS</option>
			<option  value="MT">MT</option>
			<option  value="NC">NC</option>
			<option  value="ND">ND</option>
			<option  value="NE">NE</option>

			<option  value="NH">NH</option>
			<option  value="NJ">NJ</option>
			<option  value="NM">NM</option>
			<option  value="NV">NV</option>
			<option  value="NY">NY</option>
			<option  value="OH">OH</option>
			<option  value="OK">OK</option>
			<option  value="OR">OR</option>
			<option  value="PA">PA</option>

			<option  value="RI">RI</option>
			<option  value="SC">SC</option>
			<option  value="SD">SD</option>
			<option  value="TN">TN</option>
			<option  value="TX">TX</option>
			<option  value="UT">UT</option>
			<option  value="VA">VA</option>
			<option  value="VT">VT</option>
			<option  value="WA">WA</option>

			<option  value="WI">WI</option>
			<option  value="WV">WV</option>
			<option  value="WY">WY</option>
		</select>
		<br />
		<label for="zip">Zip Code: </label><br />                                               
	  <input id="zip" name="zip" size="5" type="text" value="<?=$zip;?>" />
		<br />
	  <input type="submit" name="submit" value="Submit" />
	</form>
</div>

<?= DisplayStatus($statuslevel, $statusmessage); ?>
