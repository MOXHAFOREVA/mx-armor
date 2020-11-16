ALTER TABLE `users` ADD `armor` INT UNSIGNED NOT NULL DEFAULT '0';

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('smallarmor', 'Hafif Yelek', 1),
	('armor', 'Yelek', 1),
	('heavyarmor', 'Ağır Yelek', 1)
;