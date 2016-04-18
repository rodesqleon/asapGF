-- Creating data base --
CREATE DATABASE 03162016;
-- Creating tables --
/* USERS */
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `email`, `password`)
VALUES
	(1,'Rodrigo Esquivel','rodrigo.esquivel.leon@gmail.com','rodrygo9'),
	(2,'Tiara Krupitzky','arq.krupitzky@gmail.com','0109'),
	(3,'adad','asdasda','asdasd'),
	(4,'Mauricio Esquivel','maesquivel@manquehue.net','mesquivel1234'),
	(5,'Mauricio Esquivel','maesquivel@manquehue.net','mesquivel1234'),
	(6,'testUser1','testUser1','testUser1'),
	(7,'testUser2','testUser2','testUser2'),
	(8,'testUser3','testUser3','testUser3'),
	(9,'val1','val2','val3'),
	(10,'test3','test3','test3'),
	(11,'test4','test4','test4'),
	(12,'rodesq','rorrork@gmail.com','Tg45igual1'),
	(13,'moofwd','rorrork@gmail.com','moofwd123');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

/* PRODUCTS */


/* PRODUCTS_CATEGORY */