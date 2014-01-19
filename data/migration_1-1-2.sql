/* 1:35:00 PM MAMP */ ALTER TABLE `user` ADD `certification` varchar(200) NULL DEFAULT NULL  AFTER `confirmation`;
/* 10:45:26 AM MAMP */ ALTER TABLE `dive` CHANGE `fk_user_id` `fk_userid` int(11) NULL DEFAULT NULL;
/* 2:24:07 PM MAMP */ ALTER TABLE `dive` DROP `dateline`;
