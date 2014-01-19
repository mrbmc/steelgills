ALTER TABLE divesite ADD coord POINT NOT NULL;
UPDATE divesite AS d SET coord = PointFromWKB(POINT(d.latitude,d.longitude ));
CREATE SPATIAL INDEX coord ON divesite (coord);
/* 12:36:21 PM MAMP */ ALTER TABLE `user` ADD `twitter_uid` int NULL DEFAULT NULL  AFTER `email`;
/* 12:36:28 PM MAMP */ ALTER TABLE `user` ADD `twitter_token` int NULL DEFAULT NULL  AFTER `twitter_uid`;
/* 12:36:35 PM MAMP */ ALTER TABLE `user` ADD `twitter_secret` int NULL DEFAULT NULL  AFTER `twitter_token`;
/* 12:36:21 PM MAMP */ ALTER TABLE `user` ADD `facebook_uid` int NULL DEFAULT NULL  AFTER `twitter_secret`;
/* 12:36:28 PM MAMP */ ALTER TABLE `user` ADD `facebook_token` int NULL DEFAULT NULL  AFTER `facebook_uid`;
/* 12:36:35 PM MAMP */ ALTER TABLE `user` ADD `facebook_secret` int NULL DEFAULT NULL  AFTER `facebook_token`;
