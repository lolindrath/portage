
CREATE TABLE `contexts` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `position` int(11) NOT  NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



# Dump of table projects
# ------------------------------------------------------------

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `position` int(11) NOT  NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;




# Dump of table todos
# ------------------------------------------------------------

CREATE TABLE `todos` (
  `id` int(11) NOT NULL auto_increment,
  `context_id` int(11) NOT NULL default '0',
  `description` varchar(100) NOT NULL default '',
  `notes` text,
  `done` tinyint(4) NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `due` date default NULL,
  `completed` datetime default NULL,
  `project_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


CREATE TABLE contacts
(
	id int NOT NULL auto_increment,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	email varchar(255),
	home_phone varchar(100),
	work_phone varchar(100),
	cell_phone varchar(100),
	address1 varchar(255),
	address2 varchar(255),
	city varchar(255),
	state varchar(2),
	zip varchar(5),
	PRIMARY KEY(id)
)

CREATE TABLE events
(
	id int NOT NULL auto_increment,
	description varchar(255),
	location varchar(255),
	title varchar(255) NOT NULL,
	category_id int,
	start_time datetime NOT NULL default '0000-00-00 00:00:00',
	recur_interval,
	recur_type,
	recur_day,
	recur_end_type,
	recur_end_date,
	recur_end_occurances,
	recur_occur_left,
	PRIMARY KEY(id)
)

CREATE TABLE event_attendees
(
	id int NOT NULL auto_increment,
	event_id,
	contact_id,
	PRIMARY KEY(id)
)

CREATE TABLE categories
(
	id int NOT NULL auto_increment,
	name varchar(255) NOT NULL,
	PRIMARY KEY(id)
)