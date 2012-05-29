
CREATE TABLE `contexts` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `position` int(11) NOT  NULL,
  PRIMARY KEY  (`id`)
);

# Dump of table projects
# ------------------------------------------------------------

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `position` int(11) NOT  NULL,
  PRIMARY KEY  (`id`)
);

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
);

