-- MySQL dump 10.13  Distrib 8.0.15, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: tur
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('f23387f6aeec');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `attribute` (
  `deleted` tinyint(1) DEFAULT NULL,
  `attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
INSERT INTO `attribute` VALUES (0,1,'Size'),(0,2,'Color');
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_value`
--

DROP TABLE IF EXISTS `attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `attribute_value` (
  `deleted` tinyint(1) DEFAULT NULL,
  `attribute_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`attribute_value_id`),
  KEY `attribute_id` (`attribute_id`),
  CONSTRAINT `attribute_value_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_value`
--

LOCK TABLES `attribute_value` WRITE;
/*!40000 ALTER TABLE `attribute_value` DISABLE KEYS */;
INSERT INTO `attribute_value` VALUES (0,1,1,'S'),(0,2,1,'M'),(0,3,1,'L'),(0,4,1,'XL'),(0,5,1,'XXL'),(0,6,2,'White'),(0,7,2,'Black'),(0,8,2,'Red'),(0,9,2,'Orange'),(0,10,2,'Yellow'),(0,11,2,'Green'),(0,12,2,'Blue'),(0,13,2,'Indigo'),(0,14,2,'Purple');
/*!40000 ALTER TABLE `attribute_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `category` (
  `deleted` tinyint(1) DEFAULT NULL,
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (NULL,1,1,'French','The French have always had an eye for beauty. One look at the T-shirts below and you\'ll see that same appreciation has been applied abundantly to their postage stamps. Below are some of our most beautiful and colorful T-shirts, so browse away! And don\'t forget to go all the way to the bottom - you don\'t want to miss any of them!'),(NULL,2,1,'Italian','The full and resplendent treasure chest of art, literature, music, and science that Italy has given the world is reflected splendidly in its postal stamps. If we could, we would dedicate hundreds of T-shirts to this amazing treasure of beautiful images, but for now we will have to live with what you see here. You don\'t have to be Italian to love these gorgeous T-shirts, just someone who appreciates the finer things in life!'),(NULL,3,1,'Irish','It was Churchill who remarked that he thought the Irish most curious because they didn\'t want to be English. How right he was! But then, he was half-American, wasn\'t he? If you have an Irish genealogy you will want these T-shirts! If you suddenly turn Irish on St. Patrick\'s Day, you too will want these T-shirts! Take a look at some of the coolest T-shirts we have!'),(NULL,4,2,'Animal',' Our ever-growing selection of beautiful animal T-shirts represents critters from everywhere, both wild and domestic. If you don\'t see the T-shirt with the animal you\'re looking for, tell us and we\'ll find it!'),(NULL,5,2,'Flower','These unique and beautiful flower T-shirts are just the item for the gardener, flower arranger, florist, or general lover of things beautiful. Surprise the flower in your life with one of the beautiful botanical T-shirts or just get a few for yourself!'),(NULL,6,3,'Christmas',' Because this is a unique Christmas T-shirt that you\'ll only wear a few times a year, it will probably last for decades (unless some grinch nabs it from you, of course). Far into the future, after you\'re gone, your grandkids will pull it out and argue over who gets to wear it. What great snapshots they\'ll make dressed in Grandpa or Grandma\'s incredibly tasteful and unique Christmas T-shirt! Yes, everyone will remember you forever and what a silly goof you were when you would wear only your Santa beard and cap so you wouldn\'t cover up your nifty T-shirt.'),(NULL,7,3,'Valentine\'s','For the more timid, all you have to do is wear your heartfelt message to get it across. Buy one for you and your sweetie(s) today!');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `deleted` tinyint(1) DEFAULT NULL,
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `credit_card` text COLLATE utf8mb4_general_ci,
  `address_1` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_2` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `region` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postal_code` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_region_id` int(11) NOT NULL,
  `day_phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `eve_phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mob_phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  KEY `shipping_region_id` (`shipping_region_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`shipping_region_id`) REFERENCES `shipping_region` (`shipping_region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (NULL,1,'x','y','dfehvb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(0,2,'x','janbee@gmail.com','pbkdf2:sha256:150000$39an6HFF$a49f8c37c26697bab7ca4c9f433d67a9ad42fd95e5ceb4be807b141f4510632c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(0,3,'x','x','pbkdf2:sha256:150000$uyWLwmrS$e96520203e9b3f9b42648c96c4920ba6ac505c266275ba8bfc19225d02d1a412',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(0,4,'x','juliet@yahoo.com','pbkdf2:sha256:150000$4hi8SiVs$4a8db295d97a03fd8aee667718ac2682db4a4ec06b8eff3b834a1187e43937d5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(0,5,'x','jemtabc@yahoo.com','pbkdf2:sha256:150000$rlc0eXVY$168ff53c0c602c3322ef090f869df0b4fb3355500064992d19da6b8c90ec8ef3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(0,6,'x','b','pbkdf2:sha256:150000$uC4GlRSe$5cb2ad9760c721321a3ac93d3f37f04c183fdde8e84147e5e6798ed58535cb9b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(0,7,'x','z','pbkdf2:sha256:150000$8ar6Bexl$0a05063c6fbb2db8e52cee9884d94a608324748ad76e10ba2c9364082c9a2aa2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `department` (
  `deleted` tinyint(1) DEFAULT NULL,
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (0,1,'Regional','Proud of your country? Wear a T-shirt with a national symbol stamp!'),(0,2,'Nature','Find beautiful T-shirts with animals and flowers in our Nature department!'),(0,3,'Seasonal','Each time of the year has a special flavor. Our seasonal T-shirts express traditional symbols using unique postal stamp pictures.');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order_detail` (
  `deleted` tinyint(1) DEFAULT NULL,
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `attributes` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_cost` float NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `deleted` tinyint(1) DEFAULT NULL,
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `total_amount` float DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `shipped_on` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `comments` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `auth_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reference` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_id` int(11) DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `shipping_id` (`shipping_id`),
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`shipping_id`) REFERENCES `shipping` (`shipping_id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `deleted` tinyint(1) DEFAULT NULL,
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discounted_price` decimal(10,2) DEFAULT NULL,
  `image` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image_2` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `thumbnail` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `display` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (0,1,'Arc d\'Triomphe','This beautiful and iconic T-shirt will no doubt lead you to your own triumph.',14.99,0.00,'arc-d-triomphe.gif','arc-d-triomphe-2.gif','arc-d-triomphe-thumbnail.gif',0,1,1),(0,2,'Chartres Cathedral','\"The Fur Merchants\". Not all the beautiful stained glass in the great cathedrals depicts saints and angels! Lay aside your furs for the summer and wear this beautiful T-shirt!',16.95,15.95,'chartres-cathedral.gif','chartres-cathedral-2.gif','chartres-cathedral-thumbnail.gif',2,1,1),(0,3,'Coat of Arms','There\'s good reason why the ship plays a prominent part on this shield!',14.50,0.00,'coat-of-arms.gif','coat-of-arms-2.gif','coat-of-arms-thumbnail.gif',0,1,1),(0,4,'Gallic Cock','This fancy chicken is perhaps the most beloved of all French symbols. Unfortunately, there are only a few hundred left, so you\'d better get your T-shirt now!',18.99,16.99,'gallic-cock.gif','gallic-cock-2.gif','gallic-cock-thumbnail.gif',2,1,1),(0,5,'Marianne','She symbolizes the \"Triumph of the Republic\" and has been depicted many different ways in the history of France, as you will see below!',15.95,14.95,'marianne.gif','marianne-2.gif','marianne-thumbnail.gif',2,1,1),(0,6,'Alsace','It was in this region of France that Gutenberg perfected his movable type. If he could only see what he started!',16.50,0.00,'alsace.gif','alsace-2.gif','alsace-thumbnail.gif',0,1,1),(0,7,'Apocalypse Tapestry','One of the most famous tapestries of the Loire Valley, it dates from the 14th century. The T-shirt is of more recent vintage, however.',20.00,18.95,'apocalypse-tapestry.gif','apocalypse-tapestry-2.gif','apocalypse-tapestry-thumbnail.gif',0,1,1),(0,8,'Centaur','There were never any lady centaurs, so these guys had to mate with nymphs and mares. No wonder they were often in such bad moods!',14.99,0.00,'centaur.gif','centaur-2.gif','centaur-thumbnail.gif',0,1,1),(0,9,'Corsica','Borrowed from Spain, the \"Moor\'s head\" may have celebrated the Christians\' victory over the Moslems in that country.',22.00,0.00,'corsica.gif','corsica-2.gif','corsica-thumbnail.gif',0,1,1),(0,10,'Haute Couture','This stamp publicized the dress making industry. Use it to celebrate the T-shirt industry!',15.99,14.95,'haute-couture.gif','haute-couture-2.gif','haute-couture-thumbnail.gif',3,1,1),(0,11,'Iris','Iris was the Goddess of the Rainbow, daughter of the Titans Thaumas and Electra. Are you up to this T-shirt?!',17.50,0.00,'iris.gif','iris-2.gif','iris-thumbnail.gif',0,1,1),(0,12,'Lorraine','The largest American cemetery in France is located in Lorraine and most of the folks there still appreciate that fact.',16.95,0.00,'lorraine.gif','lorraine-2.gif','lorraine-thumbnail.gif',0,1,1),(0,13,'Mercury','Besides being the messenger of the gods, did you know that Mercury was also the god of profit and commerce? This T-shirt is for business owners!',21.99,18.95,'mercury.gif','mercury-2.gif','mercury-thumbnail.gif',2,1,1),(0,14,'County of Nice','Nice is so nice that it has been fought over for millennia, but now it all belongs to France.',12.95,0.00,'county-of-nice.gif','county-of-nice-2.gif','county-of-nice-thumbnail.gif',0,1,1),(0,15,'Notre Dame','Commemorating the 800th anniversary of the famed cathedral.',18.50,16.99,'notre-dame.gif','notre-dame-2.gif','notre-dame-thumbnail.gif',2,1,1),(0,16,'Paris Peace Conference','The resulting treaties allowed Italy, Romania, Hungary, Bulgaria, and Finland to reassume their responsibilities as sovereign states in international affairs and thus qualify for membership in the UN.',16.95,15.99,'paris-peace-conference.gif','paris-peace-conference-2.gif','paris-peace-conference-thumbnail.gif',2,1,1),(0,17,'Sarah Bernhardt','The \"Divine Sarah\" said this about Americans: \"You are younger than we as a race, you are perhaps barbaric, but what of it? You are still in the molding. Your spirit is superb. It is what helped us win the war.\" Perhaps we\'re still barbaric but we\'re still winning wars for them too!',14.99,0.00,'sarah-bernhardt.gif','sarah-bernhardt-2.gif','sarah-bernhardt-thumbnail.gif',0,1,1),(0,18,'Hunt','A scene from \"Les Tres Riches Heures,\" a medieval \"book of hours\" containing the text for each liturgical hour of the day. This scene is from a 14th century painting.',16.99,15.95,'hunt.gif','hunt-2.gif','hunt-thumbnail.gif',2,1,1),(0,19,'Italia','The War had just ended when this stamp was designed, and even so, there was enough optimism to show the destroyed oak tree sprouting again from its stump! What a beautiful T-shirt!',22.00,18.99,'italia.gif','italia-2.gif','italia-thumbnail.gif',2,2,1),(0,20,'Torch','The light goes on! Carry the torch with this T-shirt and be a beacon of hope for the world!',19.99,17.95,'torch.gif','torch-2.gif','torch-thumbnail.gif',2,2,1),(0,21,'Espresso','The winged foot of Mercury speeds the Special Delivery mail to its destination. In a hurry? This T-shirt is for you!',16.95,0.00,'espresso.gif','espresso-2.gif','espresso-thumbnail.gif',0,2,1),(0,22,'Galileo','This beautiful T-shirt does honor to one of Italy\'s (and the world\'s) most famous scientists. Show your appreciation for the education you\'ve received!',14.99,0.00,'galileo.gif','galileo-2.gif','galileo-thumbnail.gif',0,2,1),(0,23,'Italian Airmail','Thanks to modern Italian post, folks were able to reach out and touch each other. Or at least so implies this image. This is a very fast and friendly T-shirt--you\'ll make friends with it!',21.00,17.99,'italian-airmail.gif','italian-airmail-2.gif','italian-airmail-thumbnail.gif',0,2,1),(0,24,'Mazzini','Giuseppe Mazzini is considered one of the patron saints of the \"Risorgimiento.\" Wear this beautiful T-shirt to tell the world you agree!',20.50,18.95,'mazzini.gif','mazzini-2.gif','mazzini-thumbnail.gif',2,2,1),(0,25,'Romulus & Remus','Back in 753 BC, so the story goes, Romulus founded the city of Rome (in competition with Remus, who founded a city on another hill). Their adopted mother is shown in this image. When did they suspect they were adopted?',17.99,16.95,'romulus-remus.gif','romulus-remus-2.gif','romulus-remus-thumbnail.gif',2,2,1),(0,26,'Italy Maria','This beautiful image of the Virgin is from a work by Raphael, whose life and death it honors. It is one of our most popular T-shirts!',14.00,0.00,'italy-maria.gif','italy-maria-2.gif','italy-maria-thumbnail.gif',0,2,1),(0,27,'Italy Jesus','This image of Jesus teaching the gospel was issued to commemorate the third centenary of the \"propagation of the faith.\" Now you can do your part with this T-shirt!',16.95,0.00,'italy-jesus.gif','italy-jesus-2.gif','italy-jesus-thumbnail.gif',0,2,1),(0,28,'St. Francis','Here St. Francis is receiving his vision. This dramatic and attractive stamp was issued on the 700th anniversary of that event.',22.00,18.99,'st-francis.gif','st-francis-2.gif','st-francis-thumbnail.gif',2,2,1),(0,29,'Irish Coat of Arms','This was one of the first stamps of the new Irish Republic, and it makes a T-shirt you\'ll be proud to wear on St. Paddy\'s Day!',14.99,0.00,'irish-coat-of-arms.gif','irish-coat-of-arms-2.gif','irish-coat-of-arms-thumbnail.gif',0,3,1),(0,30,'Easter Rebellion','The Easter Rebellion of 1916 was a defining moment in Irish history. Although only a few hundred participated and the British squashed it in a week, its leaders were executed, which galvanized the uncommitted.',19.00,16.95,'easter-rebellion.gif','easter-rebellion-2.gif','easter-rebellion-thumbnail.gif',2,3,1),(0,31,'Guiness','Class! Who is this man and why is he important enough for his own T-shirt?!',15.00,0.00,'guiness.gif','guiness-2.gif','guiness-thumbnail.gif',0,3,1),(0,32,'St. Patrick','This stamp commemorated the 1500th anniversary of the revered saint\'s death. Is there a more perfect St. Patrick\'s Day T-shirt?!',20.50,17.95,'st-patrick.gif','st-patrick-2.gif','st-patrick-thumbnail.gif',0,3,1),(0,33,'St. Peter','This T-shirt commemorates the holy year of 1950.',16.00,14.95,'st-peter.gif','st-peter-2.gif','st-peter-thumbnail.gif',2,3,1),(0,34,'Sword of Light','This was the very first Irish postage stamp, and what a beautiful and cool T-shirt it makes for the Irish person in your life!',14.99,0.00,'sword-of-light.gif','sword-of-light-2.gif','sword-of-light-thumbnail.gif',0,3,1),(0,35,'Thomas Moore','One of the greatest if not the greatest of Irish poets and writers, Moore led a very interesting life, though plagued with tragedy in a somewhat typically Irish way. Remember \"The Last Rose of Summer\"?',15.95,14.99,'thomas-moore.gif','thomas-moore-2.gif','thomas-moore-thumbnail.gif',2,3,1),(0,36,'Visit the Zoo','This WPA poster is a wonderful example of the art produced by the Works Projects Administration during the Depression years. Do you feel like you sometimes live or work in a zoo? Then this T-shirt is for you!',20.00,16.95,'visit-the-zoo.gif','visit-the-zoo-2.gif','visit-the-zoo-thumbnail.gif',2,4,2),(0,37,'Sambar','This handsome Malayan Sambar was a pain in the neck to get to pose like this, and all so you could have this beautiful retro animal T-shirt!',19.00,17.99,'sambar.gif','sambar-2.gif','sambar-thumbnail.gif',2,4,2),(0,38,'Buffalo','Of all the critters in our T-shirt zoo, this is one of our most popular. A classic animal T-shirt for an individual like yourself!',14.99,0.00,'buffalo.gif','buffalo-2.gif','buffalo-thumbnail.gif',0,4,2),(0,39,'Mustache Monkey','This fellow is more than equipped to hang out with that tail of his, just like you\'ll be fit for hanging out with this great animal T-shirt!',20.00,17.95,'mustache-monkey.gif','mustache-monkey-2.gif','mustache-monkey-thumbnail.gif',2,4,2),(0,40,'Colobus','Why is he called \"Colobus,\" \"the mutilated one\"? He doesn\'t have a thumb, just four fingers! He is far from handicapped, however; his hands make him the great swinger he is. Speaking of swinging, that\'s what you\'ll do with this beautiful animal T-shirt!',17.00,15.99,'colobus.gif','colobus-2.gif','colobus-thumbnail.gif',2,4,2),(0,41,'Canada Goose','Being on a major flyway for these guys, we know all about these majestic birds. They hang out in large numbers on a lake near our house and fly over constantly. Remember what Frankie Lane said? \"I want to go where the wild goose goes!\" And when you go, wear this cool Canada goose animal T-shirt.',15.99,0.00,'canada-goose.gif','canada-goose-2.gif','canada-goose-thumbnail.gif',0,4,2),(0,42,'Congo Rhino','Among land mammals, this white rhino is surpassed in size only by the elephant. He has a big fan base too, working hard to make sure he sticks around. You\'ll be a fan of his, too, when people admire this unique and beautiful T-shirt on you!',20.00,18.99,'congo-rhino.gif','congo-rhino-2.gif','congo-rhino-thumbnail.gif',2,4,2),(0,43,'Equatorial Rhino','There\'s a lot going on in this frame! A black rhino is checking out that python slithering off into the bush--or is he eyeing you? You can bet all eyes will be on you when you wear this T-shirt!',19.95,17.95,'equatorial-rhino.gif','equatorial-rhino-2.gif','equatorial-rhino-thumbnail.gif',2,4,2),(0,44,'Ethiopian Rhino','Another white rhino is honored in this classic design that bespeaks the Africa of the early century. This pointillist and retro T-shirt will definitely turn heads!',16.00,0.00,'ethiopian-rhino.gif','ethiopian-rhino-2.gif','ethiopian-rhino-thumbnail.gif',0,4,2),(0,45,'Dutch Sea Horse','I think this T-shirt is destined to be one of our most popular simply because it is one of our most beautiful!',12.50,0.00,'dutch-sea-horse.gif','dutch-sea-horse-2.gif','dutch-sea-horse-thumbnail.gif',0,4,2),(0,46,'Dutch Swans','This stamp was designed in the middle of the Nazi occupation, as was the one above. Together they reflect a spirit of beauty that evil could not suppress. Both of these T-shirts will make it impossible to suppress your artistic soul, too!',21.00,18.99,'dutch-swans.gif','dutch-swans-2.gif','dutch-swans-thumbnail.gif',2,4,2),(0,47,'Ethiopian Elephant','From the same series as the Ethiopian Rhino and the Ostriches, this stylish elephant T-shirt will mark you as a connoisseur of good taste!',18.99,16.95,'ethiopian-elephant.gif','ethiopian-elephant-2.gif','ethiopian-elephant-thumbnail.gif',2,4,2),(0,48,'Laotian Elephant','This working guy is proud to have his own stamp, and now he has his own T-shirt!',21.00,18.99,'laotian-elephant.gif','laotian-elephant-2.gif','laotian-elephant-thumbnail.gif',0,4,2),(0,49,'Liberian Elephant','And yet another Jumbo! You need nothing but a big heart to wear this T-shirt (or a big sense of style)!',22.00,17.50,'liberian-elephant.gif','liberian-elephant-2.gif','liberian-elephant-thumbnail.gif',2,4,2),(0,50,'Somali Ostriches','Another in an old series of beautiful stamps from Ethiopia. These big birds pack quite a wallop, and so will you when you wear this uniquely retro T-shirt!',12.95,0.00,'somali-ostriches.gif','somali-ostriches-2.gif','somali-ostriches-thumbnail.gif',0,4,2),(0,51,'Tankanyika Giraffe','The photographer had to stand on a step ladder for this handsome portrait, but his efforts paid off with an angle we seldom see of this lofty creature. This beautiful retro T-shirt would make him proud!',15.00,12.99,'tankanyika-giraffe.gif','tankanyika-giraffe-2.gif','tankanyika-giraffe-thumbnail.gif',3,4,2),(0,52,'Ifni Fish','This beautiful stamp was issued to commemorate National Colonial Stamp Day (you can do that when you have a colony). When you wear this fancy fish T-shirt, your friends will think it\'s national T-shirt day!',14.00,0.00,'ifni-fish.gif','ifni-fish-2.gif','ifni-fish-thumbnail.gif',0,4,2),(0,53,'Sea Gull','A beautiful stamp from a small enclave in southern Morocco that belonged to Spain until 1969 makes a beautiful bird T-shirt.',19.00,16.95,'sea-gull.gif','sea-gull-2.gif','sea-gull-thumbnail.gif',2,4,2),(0,54,'King Salmon','You can fish them and eat them and now you can wear them with this classic animal T-shirt.',17.95,15.99,'king-salmon.gif','king-salmon-2.gif','king-salmon-thumbnail.gif',2,4,2),(0,55,'Laos Bird','This fellow is also known as the \"White Crested Laughing Thrush.\" What\'s he laughing at? Why, at the joy of being on your T-shirt!',12.00,0.00,'laos-bird.gif','laos-bird-2.gif','laos-bird-thumbnail.gif',0,4,2),(0,56,'Mozambique Lion','The Portuguese were too busy to run this colony themselves so they gave the Mozambique Company a charter to do it. I think there must be some pretty curious history related to that (the charter only lasted for 50 years)! If you\'re a Leo, or know a Leo, you should seriously consider this T-shirt!',15.99,14.95,'mozambique-lion.gif','mozambique-lion-2.gif','mozambique-lion-thumbnail.gif',2,4,2),(0,57,'Peru Llama','This image is nearly 100 years old! Little did this little llama realize that he was going to be made immortal on the Web and on this very unique animal T-shirt (actually, little did he know at all)!',21.50,17.99,'peru-llama.gif','peru-llama-2.gif','peru-llama-thumbnail.gif',2,4,2),(0,58,'Romania Alsatian','If you know and love this breed, there\'s no reason in the world that you shouldn\'t buy this T-shirt right now!',15.95,0.00,'romania-alsatian.gif','romania-alsatian-2.gif','romania-alsatian-thumbnail.gif',0,4,2),(0,59,'Somali Fish','This is our most popular fish T-shirt, hands down. It\'s a beauty, and if you wear this T-shirt, you\'ll be letting the world know you\'re a fine catch!',19.95,16.95,'somali-fish.gif','somali-fish-2.gif','somali-fish-thumbnail.gif',2,4,2),(0,60,'Trout','This beautiful image will warm the heart of any fisherman! You must know one if you\'re not one yourself, so you must buy this T-shirt!',14.00,0.00,'trout.gif','trout-2.gif','trout-thumbnail.gif',0,4,2),(0,61,'Baby Seal','Ahhhhhh! This little harp seal would really prefer not to be your coat! But he would like to be your T-shirt!',21.00,18.99,'baby-seal.gif','baby-seal-2.gif','baby-seal-thumbnail.gif',2,4,2),(0,62,'Musk Ox','Some critters you just don\'t want to fool with, and if I were facing this fellow I\'d politely give him the trail! That is, of course, unless I were wearing this T-shirt.',15.50,0.00,'musk-ox.gif','musk-ox-2.gif','musk-ox-thumbnail.gif',0,4,2),(0,63,'Suvla Bay',' In 1915, Newfoundland sent its Newfoundland Regiment to Suvla Bay in Gallipoli to fight the Turks. This classic image does them honor. Have you ever heard of them? Share the news with this great T-shirt!',12.99,0.00,'suvla-bay.gif','suvla-bay-2.gif','suvla-bay-thumbnail.gif',0,4,2),(0,64,'Caribou','There was a time when Newfoundland was a self-governing dominion of the British Empire, so it printed its own postage. The themes are as typically Canadian as can be, however, as shown by this \"King of the Wilde\" T-shirt!',21.00,19.95,'caribou.gif','caribou-2.gif','caribou-thumbnail.gif',2,4,2),(0,65,'Afghan Flower','This beautiful image was issued to celebrate National Teachers Day. Perhaps you know a teacher who would love this T-shirt?',18.50,16.99,'afghan-flower.gif','afghan-flower-2.gif','afghan-flower-thumbnail.gif',2,5,2),(0,66,'Albania Flower','Well, these crab apples started out as flowers, so that\'s close enough for us! They still make for a uniquely beautiful T-shirt.',16.00,14.95,'albania-flower.gif','albania-flower-2.gif','albania-flower-thumbnail.gif',2,5,2),(0,67,'Austria Flower','Have you ever had nasturtiums on your salad? Try it--they\'re almost as good as having them on your T-shirt!',12.99,0.00,'austria-flower.gif','austria-flower-2.gif','austria-flower-thumbnail.gif',0,5,2),(0,68,'Bulgarian Flower','For your interest (and to impress your friends), this beautiful stamp was issued to honor the George Dimitrov state printing works. You\'ll need to know this when you wear the T-shirt.',16.00,14.99,'bulgarian-flower.gif','bulgarian-flower-2.gif','bulgarian-flower-thumbnail.gif',2,5,2),(0,69,'Colombia Flower','Celebrating the 75th anniversary of the Universal Postal Union, a date to mark on your calendar and on which to wear this T-shirt!',14.50,12.95,'colombia-flower.gif','colombia-flower-2.gif','colombia-flower-thumbnail.gif',1,5,2),(0,70,'Congo Flower','The Congo is not at a loss for beautiful flowers, and we\'ve picked a few of them for your T-shirts.',21.00,17.99,'congo-flower.gif','congo-flower-2.gif','congo-flower-thumbnail.gif',2,5,2),(0,71,'Costa Rica Flower','This national flower of Costa Rica is one of our most beloved flower T-shirts (you can see one on Jill, above). You will surely stand out in this T-shirt!',12.99,0.00,'costa-rica-flower.gif','costa-rica-flower.gif','costa-rica-flower-thumbnail.gif',0,5,2),(0,72,'Gabon Flower','The combretum, also known as \"jungle weed,\" is used in China as a cure for opium addiction. Unfortunately, when you wear this T-shirt, others may become hopelessly addicted to you!',19.00,16.95,'gabon-flower.gif','gabon-flower-2.gif','gabon-flower-thumbnail.gif',2,5,2),(0,73,'Ghana Flower','This is one of the first gingers to bloom in the spring--just like you when you wear this T-shirt!',21.00,18.99,'ghana-flower.gif','ghana-flower-2.gif','ghana-flower-thumbnail.gif',2,5,2),(0,74,'Israel Flower','This plant is native to the rocky and sandy regions of the western United States, so when you come across one, it really stands out. And so will you when you put on this beautiful T-shirt!',19.50,17.50,'israel-flower.gif','israel-flower-2.gif','israel-flower-thumbnail.gif',2,5,2),(0,75,'Poland Flower','A beautiful and sunny T-shirt for both spring and summer!',16.95,15.99,'poland-flower.gif','poland-flower-2.gif','poland-flower-thumbnail.gif',2,5,2),(0,76,'Romania Flower','Also known as the spring pheasant\'s eye, this flower belongs on your T-shirt this summer to help you catch a few eyes.',12.95,0.00,'romania-flower.gif','romania-flower-2.gif','romania-flower-thumbnail.gif',0,5,2),(0,77,'Russia Flower','Someone out there who can speak Russian needs to tell me what this plant is. I\'ll sell you the T-shirt for $10 if you can!',21.00,18.95,'russia-flower.gif','russia-flower-2.gif','russia-flower-thumbnail.gif',0,5,2),(0,78,'San Marino Flower','\"A white sport coat and a pink carnation, I\'m all dressed up for the dance!\" Well, how about a white T-shirt and a pink carnation?!',19.95,17.99,'san-marino-flower.gif','san-marino-flower-2.gif','san-marino-flower-thumbnail.gif',2,5,2),(0,79,'Uruguay Flower','The Indian Queen Anahi was the ugliest woman ever seen. But instead of living a slave when captured by the Conquistadores, she immolated herself in a fire and was reborn the most beautiful of flowers: the ceibo, national flower of Uruguay. Of course, you won\'t need to burn to wear this T-shirt, but you may cause some pretty hot glances to be thrown your way!',17.99,16.99,'uruguay-flower.gif','uruguay-flower-2.gif','uruguay-flower-thumbnail.gif',2,5,2),(0,80,'Snow Deer','Tarmo has produced some wonderful Christmas T-shirts for us, and we hope to have many more soon.',21.00,18.95,'snow-deer.gif','snow-deer-2.gif','snow-deer-thumbnail.gif',2,6,3),(0,81,'Holly Cat','Few things make a cat happier at Christmas than a tree suddenly appearing in the house!',15.99,0.00,'holly-cat.gif','holly-cat-2.gif','holly-cat-thumbnail.gif',0,6,3),(0,82,'Christmas Seal','Is this your grandmother? It could be, you know, and I\'d bet she\'d recognize the Christmas seal on this cool Christmas T-shirt.',19.99,17.99,'christmas-seal.gif','christmas-seal-2.gif','christmas-seal-thumbnail.gif',2,6,3),(0,83,'Weather Vane','This weather vane dates from the 1830\'s and is still showing which way the wind blows! Trumpet your arrival with this unique Christmas T-shirt.',15.95,14.99,'weather-vane.gif','weather-vane-2.gif','weather-vane-thumbnail.gif',2,6,3),(0,84,'Mistletoe','This well-known parasite and killer of trees was revered by the Druids, who would go out and gather it with great ceremony. Youths would go about with it to announce the new year. Eventually more engaging customs were attached to the strange plant, and we\'re here to see that they continue with these cool Christmas T-shirts.',19.00,17.99,'mistletoe.gif','mistletoe-2.gif','mistletoe-thumbnail.gif',3,6,3),(0,85,'Altar Piece','This beautiful angel Christmas T-shirt is awaiting the opportunity to adorn your chest!',20.50,18.50,'altar-piece.gif','altar-piece-2.gif','altar-piece-thumbnail.gif',2,6,3),(0,86,'The Three Wise Men','This is a classic rendition of one of the seasons most beloved stories, and now showing on a Christmas T-shirt for you!',12.99,0.00,'the-three-wise-men.gif','the-three-wise-men-2.gif','the-three-wise-men-thumbnail.gif',0,6,3),(0,87,'Christmas Tree','Can you get more warm and folksy than this classic Christmas T-shirt?',20.00,17.95,'christmas-tree.gif','christmas-tree-2.gif','christmas-tree-thumbnail.gif',2,6,3),(0,88,'Madonna & Child','This exquisite image was painted by Filipino Lippi, a 15th century Italian artist. I think he would approve of it on a Going Postal Christmas T-shirt!',21.95,18.50,'madonna-child.gif','madonna-child-2.gif','madonna-child-thumbnail.gif',0,6,3),(0,89,'The Virgin Mary','This stained glass window is found in Glasgow Cathedral, Scotland, and was created by Gabriel Loire of France, one of the most prolific of artists in this medium--and now you can have it on this wonderful Christmas T-shirt.',16.95,15.95,'the-virgin-mary.gif','the-virgin-mary-2.gif','the-virgin-mary-thumbnail.gif',2,6,3),(0,90,'Adoration of the Kings','This design is from a miniature in the Evangelistary of Matilda in Nonantola Abbey, from the 12th century. As a Christmas T-shirt, it will cause you to be adored!',17.50,16.50,'adoration-of-the-kings.gif','adoration-of-the-kings-2.gif','adoration-of-the-kings-thumbnail.gif',2,6,3),(0,91,'A Partridge in a Pear Tree','The original of this beautiful stamp is by Jamie Wyeth and is in the National Gallery of Art. The next best is on our beautiful Christmas T-shirt!',14.99,0.00,'a-partridge-in-a-pear-tree.gif','a-partridge-in-a-pear-tree-2.gif','a-partridge-in-a-pear-tree-thumbnail.gif',0,6,3),(0,92,'St. Lucy','This is a tiny detail of a large work called \"Mary, Queen of Heaven,\" done in 1480 by a Flemish master known only as \"The Master of St. Lucy Legend.\" The original is in a Bruges church. The not-quite-original is on this cool Christmas T-shirt.',18.95,0.00,'st-lucy.gif','st-lucy-2.gif','st-lucy-thumbnail.gif',0,6,3),(0,93,'St. Lucia','Saint Lucia\'s tradition is an important part of Swedish Christmas, and an important part of that are the candles. Next to the candles in importance is this popular Christmas T-shirt!',19.00,17.95,'st-lucia.gif','st-lucia-2.gif','st-lucia-thumbnail.gif',2,6,3),(0,94,'Swede Santa','Santa as a child. You must know a child who would love this cool Christmas T-shirt!?',21.00,18.50,'swede-santa.gif','swede-santa-2.gif','swede-santa-thumbnail.gif',2,6,3),(0,95,'Wreath','Hey! I\'ve got an idea! Why not buy two of these cool Christmas T-shirts so you can wear one and tack the other one to your door?!',18.99,16.99,'wreath.gif','wreath-2.gif','wreath-thumbnail.gif',2,6,3),(0,96,'Love','Here\'s a Valentine\'s day T-shirt that will let you say it all in just one easy glance--there\'s no mistake about it!',19.00,17.50,'love.gif','love-2.gif','love-thumbnail.gif',2,7,3),(0,97,'Birds','Is your heart all aflutter? Show it with this T-shirt!',21.00,18.95,'birds.gif','birds-2.gif','birds-thumbnail.gif',2,7,3),(0,98,'Kat Over New Moon','Love making you feel lighthearted?',14.99,0.00,'kat-over-new-moon.gif','kat-over-new-moon-2.gif','kat-over-new-moon-thumbnail.gif',0,7,3),(0,99,'Thrilling Love','This girl\'s got her hockey hunk right where she wants him!',21.00,18.50,'thrilling-love.gif','thrilling-love-2.gif','thrilling-love-thumbnail.gif',2,7,3),(0,100,'The Rapture of Psyche','Now we\'re getting a bit more serious!',18.95,16.99,'the-rapture-of-psyche.gif','the-rapture-of-psyche-2.gif','the-rapture-of-psyche-thumbnail.gif',2,7,3),(0,101,'The Promise of Spring','With Valentine\'s Day come, can Spring be far behind?',21.00,19.50,'the-promise-of-spring.gif','the-promise-of-spring-2.gif','the-promise-of-spring-thumbnail.gif',0,7,3);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attribute`
--

DROP TABLE IF EXISTS `product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product_attribute` (
  `deleted` tinyint(1) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `attribute_value_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`attribute_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attribute`
--

LOCK TABLES `product_attribute` WRITE;
/*!40000 ALTER TABLE `product_attribute` DISABLE KEYS */;
INSERT INTO `product_attribute` VALUES (0,1,1),(0,1,2),(0,1,3),(0,1,4),(0,1,5),(0,1,6),(0,1,7),(0,1,8),(0,1,9),(0,1,10),(0,1,11),(0,1,12),(0,1,13),(0,1,14),(0,2,1),(0,2,2),(0,2,3),(0,2,4),(0,2,5),(0,2,6),(0,2,7),(0,2,8),(0,2,9),(0,2,10),(0,2,11),(0,2,12),(0,2,13),(0,2,14),(0,3,1),(0,3,2),(0,3,3),(0,3,4),(0,3,5),(0,3,6),(0,3,7),(0,3,8),(0,3,9),(0,3,10),(0,3,11),(0,3,12),(0,3,13),(0,3,14),(0,4,1),(0,4,2),(0,4,3),(0,4,4),(0,4,5),(0,4,6),(0,4,7),(0,4,8),(0,4,9),(0,4,10),(0,4,11),(0,4,12),(0,4,13),(0,4,14),(0,5,1),(0,5,2),(0,5,3),(0,5,4),(0,5,5),(0,5,6),(0,5,7),(0,5,8),(0,5,9),(0,5,10),(0,5,11),(0,5,12),(0,5,13),(0,5,14),(0,6,1),(0,6,2),(0,6,3),(0,6,4),(0,6,5),(0,6,6),(0,6,7),(0,6,8),(0,6,9),(0,6,10),(0,6,11),(0,6,12),(0,6,13),(0,6,14),(0,7,1),(0,7,2),(0,7,3),(0,7,4),(0,7,5),(0,7,6),(0,7,7),(0,7,8),(0,7,9),(0,7,10),(0,7,11),(0,7,12),(0,7,13),(0,7,14),(0,8,1),(0,8,2),(0,8,3),(0,8,4),(0,8,5),(0,8,6),(0,8,7),(0,8,8),(0,8,9),(0,8,10),(0,8,11),(0,8,12),(0,8,13),(0,8,14),(0,9,1),(0,9,2),(0,9,3),(0,9,4),(0,9,5),(0,9,6),(0,9,7),(0,9,8),(0,9,9),(0,9,10),(0,9,11),(0,9,12),(0,9,13),(0,9,14),(0,10,1),(0,10,2),(0,10,3),(0,10,4),(0,10,5),(0,10,6),(0,10,7),(0,10,8),(0,10,9),(0,10,10),(0,10,11),(0,10,12),(0,10,13),(0,10,14),(0,11,1),(0,11,2),(0,11,3),(0,11,4),(0,11,5),(0,11,6),(0,11,7),(0,11,8),(0,11,9),(0,11,10),(0,11,11),(0,11,12),(0,11,13),(0,11,14),(0,12,1),(0,12,2),(0,12,3),(0,12,4),(0,12,5),(0,12,6),(0,12,7),(0,12,8),(0,12,9),(0,12,10),(0,12,11),(0,12,12),(0,12,13),(0,12,14),(0,13,1),(0,13,2),(0,13,3),(0,13,4),(0,13,5),(0,13,6),(0,13,7),(0,13,8),(0,13,9),(0,13,10),(0,13,11),(0,13,12),(0,13,13),(0,13,14),(0,14,1),(0,14,2),(0,14,3),(0,14,4),(0,14,5),(0,14,6),(0,14,7),(0,14,8),(0,14,9),(0,14,10),(0,14,11),(0,14,12),(0,14,13),(0,14,14),(0,15,1),(0,15,2),(0,15,3),(0,15,4),(0,15,5),(0,15,6),(0,15,7),(0,15,8),(0,15,9),(0,15,10),(0,15,11),(0,15,12),(0,15,13),(0,15,14),(0,16,1),(0,16,2),(0,16,3),(0,16,4),(0,16,5),(0,16,6),(0,16,7),(0,16,8),(0,16,9),(0,16,10),(0,16,11),(0,16,12),(0,16,13),(0,16,14),(0,17,1),(0,17,2),(0,17,3),(0,17,4),(0,17,5),(0,17,6),(0,17,7),(0,17,8),(0,17,9),(0,17,10),(0,17,11),(0,17,12),(0,17,13),(0,17,14),(0,18,1),(0,18,2),(0,18,3),(0,18,4),(0,18,5),(0,18,6),(0,18,7),(0,18,8),(0,18,9),(0,18,10),(0,18,11),(0,18,12),(0,18,13),(0,18,14),(0,19,1),(0,19,2),(0,19,3),(0,19,4),(0,19,5),(0,19,6),(0,19,7),(0,19,8),(0,19,9),(0,19,10),(0,19,11),(0,19,12),(0,19,13),(0,19,14),(0,20,1),(0,20,2),(0,20,3),(0,20,4),(0,20,5),(0,20,6),(0,20,7),(0,20,8),(0,20,9),(0,20,10),(0,20,11),(0,20,12),(0,20,13),(0,20,14),(0,21,1),(0,21,2),(0,21,3),(0,21,4),(0,21,5),(0,21,6),(0,21,7),(0,21,8),(0,21,9),(0,21,10),(0,21,11),(0,21,12),(0,21,13),(0,21,14),(0,22,1),(0,22,2),(0,22,3),(0,22,4),(0,22,5),(0,22,6),(0,22,7),(0,22,8),(0,22,9),(0,22,10),(0,22,11),(0,22,12),(0,22,13),(0,22,14),(0,23,1),(0,23,2),(0,23,3),(0,23,4),(0,23,5),(0,23,6),(0,23,7),(0,23,8),(0,23,9),(0,23,10),(0,23,11),(0,23,12),(0,23,13),(0,23,14),(0,24,1),(0,24,2),(0,24,3),(0,24,4),(0,24,5),(0,24,6),(0,24,7),(0,24,8),(0,24,9),(0,24,10),(0,24,11),(0,24,12),(0,24,13),(0,24,14),(0,25,1),(0,25,2),(0,25,3),(0,25,4),(0,25,5),(0,25,6),(0,25,7),(0,25,8),(0,25,9),(0,25,10),(0,25,11),(0,25,12),(0,25,13),(0,25,14),(0,26,1),(0,26,2),(0,26,3),(0,26,4),(0,26,5),(0,26,6),(0,26,7),(0,26,8),(0,26,9),(0,26,10),(0,26,11),(0,26,12),(0,26,13),(0,26,14),(0,27,1),(0,27,2),(0,27,3),(0,27,4),(0,27,5),(0,27,6),(0,27,7),(0,27,8),(0,27,9),(0,27,10),(0,27,11),(0,27,12),(0,27,13),(0,27,14),(0,28,1),(0,28,2),(0,28,3),(0,28,4),(0,28,5),(0,28,6),(0,28,7),(0,28,8),(0,28,9),(0,28,10),(0,28,11),(0,28,12),(0,28,13),(0,28,14),(0,29,1),(0,29,2),(0,29,3),(0,29,4),(0,29,5),(0,29,6),(0,29,7),(0,29,8),(0,29,9),(0,29,10),(0,29,11),(0,29,12),(0,29,13),(0,29,14),(0,30,1),(0,30,2),(0,30,3),(0,30,4),(0,30,5),(0,30,6),(0,30,7),(0,30,8),(0,30,9),(0,30,10),(0,30,11),(0,30,12),(0,30,13),(0,30,14),(0,31,1),(0,31,2),(0,31,3),(0,31,4),(0,31,5),(0,31,6),(0,31,7),(0,31,8),(0,31,9),(0,31,10),(0,31,11),(0,31,12),(0,31,13),(0,31,14),(0,32,1),(0,32,2),(0,32,3),(0,32,4),(0,32,5),(0,32,6),(0,32,7),(0,32,8),(0,32,9),(0,32,10),(0,32,11),(0,32,12),(0,32,13),(0,32,14),(0,33,1),(0,33,2),(0,33,3),(0,33,4),(0,33,5),(0,33,6),(0,33,7),(0,33,8),(0,33,9),(0,33,10),(0,33,11),(0,33,12),(0,33,13),(0,33,14),(0,34,1),(0,34,2),(0,34,3),(0,34,4),(0,34,5),(0,34,6),(0,34,7),(0,34,8),(0,34,9),(0,34,10),(0,34,11),(0,34,12),(0,34,13),(0,34,14),(0,35,1),(0,35,2),(0,35,3),(0,35,4),(0,35,5),(0,35,6),(0,35,7),(0,35,8),(0,35,9),(0,35,10),(0,35,11),(0,35,12),(0,35,13),(0,35,14),(0,36,1),(0,36,2),(0,36,3),(0,36,4),(0,36,5),(0,36,6),(0,36,7),(0,36,8),(0,36,9),(0,36,10),(0,36,11),(0,36,12),(0,36,13),(0,36,14),(0,37,1),(0,37,2),(0,37,3),(0,37,4),(0,37,5),(0,37,6),(0,37,7),(0,37,8),(0,37,9),(0,37,10),(0,37,11),(0,37,12),(0,37,13),(0,37,14),(0,38,1),(0,38,2),(0,38,3),(0,38,4),(0,38,5),(0,38,6),(0,38,7),(0,38,8),(0,38,9),(0,38,10),(0,38,11),(0,38,12),(0,38,13),(0,38,14),(0,39,1),(0,39,2),(0,39,3),(0,39,4),(0,39,5),(0,39,6),(0,39,7),(0,39,8),(0,39,9),(0,39,10),(0,39,11),(0,39,12),(0,39,13),(0,39,14),(0,40,1),(0,40,2),(0,40,3),(0,40,4),(0,40,5),(0,40,6),(0,40,7),(0,40,8),(0,40,9),(0,40,10),(0,40,11),(0,40,12),(0,40,13),(0,40,14),(0,41,1),(0,41,2),(0,41,3),(0,41,4),(0,41,5),(0,41,6),(0,41,7),(0,41,8),(0,41,9),(0,41,10),(0,41,11),(0,41,12),(0,41,13),(0,41,14),(0,42,1),(0,42,2),(0,42,3),(0,42,4),(0,42,5),(0,42,6),(0,42,7),(0,42,8),(0,42,9),(0,42,10),(0,42,11),(0,42,12),(0,42,13),(0,42,14),(0,43,1),(0,43,2),(0,43,3),(0,43,4),(0,43,5),(0,43,6),(0,43,7),(0,43,8),(0,43,9),(0,43,10),(0,43,11),(0,43,12),(0,43,13),(0,43,14),(0,44,1),(0,44,2),(0,44,3),(0,44,4),(0,44,5),(0,44,6),(0,44,7),(0,44,8),(0,44,9),(0,44,10),(0,44,11),(0,44,12),(0,44,13),(0,44,14),(0,45,1),(0,45,2),(0,45,3),(0,45,4),(0,45,5),(0,45,6),(0,45,7),(0,45,8),(0,45,9),(0,45,10),(0,45,11),(0,45,12),(0,45,13),(0,45,14),(0,46,1),(0,46,2),(0,46,3),(0,46,4),(0,46,5),(0,46,6),(0,46,7),(0,46,8),(0,46,9),(0,46,10),(0,46,11),(0,46,12),(0,46,13),(0,46,14),(0,47,1),(0,47,2),(0,47,3),(0,47,4),(0,47,5),(0,47,6),(0,47,7),(0,47,8),(0,47,9),(0,47,10),(0,47,11),(0,47,12),(0,47,13),(0,47,14),(0,48,1),(0,48,2),(0,48,3),(0,48,4),(0,48,5),(0,48,6),(0,48,7),(0,48,8),(0,48,9),(0,48,10),(0,48,11),(0,48,12),(0,48,13),(0,48,14),(0,49,1),(0,49,2),(0,49,3),(0,49,4),(0,49,5),(0,49,6),(0,49,7),(0,49,8),(0,49,9),(0,49,10),(0,49,11),(0,49,12),(0,49,13),(0,49,14),(0,50,1),(0,50,2),(0,50,3),(0,50,4),(0,50,5),(0,50,6),(0,50,7),(0,50,8),(0,50,9),(0,50,10),(0,50,11),(0,50,12),(0,50,13),(0,50,14),(0,51,1),(0,51,2),(0,51,3),(0,51,4),(0,51,5),(0,51,6),(0,51,7),(0,51,8),(0,51,9),(0,51,10),(0,51,11),(0,51,12),(0,51,13),(0,51,14),(0,52,1),(0,52,2),(0,52,3),(0,52,4),(0,52,5),(0,52,6),(0,52,7),(0,52,8),(0,52,9),(0,52,10),(0,52,11),(0,52,12),(0,52,13),(0,52,14),(0,53,1),(0,53,2),(0,53,3),(0,53,4),(0,53,5),(0,53,6),(0,53,7),(0,53,8),(0,53,9),(0,53,10),(0,53,11),(0,53,12),(0,53,13),(0,53,14),(0,54,1),(0,54,2),(0,54,3),(0,54,4),(0,54,5),(0,54,6),(0,54,7),(0,54,8),(0,54,9),(0,54,10),(0,54,11),(0,54,12),(0,54,13),(0,54,14),(0,55,1),(0,55,2),(0,55,3),(0,55,4),(0,55,5),(0,55,6),(0,55,7),(0,55,8),(0,55,9),(0,55,10),(0,55,11),(0,55,12),(0,55,13),(0,55,14),(0,56,1),(0,56,2),(0,56,3),(0,56,4),(0,56,5),(0,56,6),(0,56,7),(0,56,8),(0,56,9),(0,56,10),(0,56,11),(0,56,12),(0,56,13),(0,56,14),(0,57,1),(0,57,2),(0,57,3),(0,57,4),(0,57,5),(0,57,6),(0,57,7),(0,57,8),(0,57,9),(0,57,10),(0,57,11),(0,57,12),(0,57,13),(0,57,14),(0,58,1),(0,58,2),(0,58,3),(0,58,4),(0,58,5),(0,58,6),(0,58,7),(0,58,8),(0,58,9),(0,58,10),(0,58,11),(0,58,12),(0,58,13),(0,58,14),(0,59,1),(0,59,2),(0,59,3),(0,59,4),(0,59,5),(0,59,6),(0,59,7),(0,59,8),(0,59,9),(0,59,10),(0,59,11),(0,59,12),(0,59,13),(0,59,14),(0,60,1),(0,60,2),(0,60,3),(0,60,4),(0,60,5),(0,60,6),(0,60,7),(0,60,8),(0,60,9),(0,60,10),(0,60,11),(0,60,12),(0,60,13),(0,60,14),(0,61,1),(0,61,2),(0,61,3),(0,61,4),(0,61,5),(0,61,6),(0,61,7),(0,61,8),(0,61,9),(0,61,10),(0,61,11),(0,61,12),(0,61,13),(0,61,14),(0,62,1),(0,62,2),(0,62,3),(0,62,4),(0,62,5),(0,62,6),(0,62,7),(0,62,8),(0,62,9),(0,62,10),(0,62,11),(0,62,12),(0,62,13),(0,62,14),(0,63,1),(0,63,2),(0,63,3),(0,63,4),(0,63,5),(0,63,6),(0,63,7),(0,63,8),(0,63,9),(0,63,10),(0,63,11),(0,63,12),(0,63,13),(0,63,14),(0,64,1),(0,64,2),(0,64,3),(0,64,4),(0,64,5),(0,64,6),(0,64,7),(0,64,8),(0,64,9),(0,64,10),(0,64,11),(0,64,12),(0,64,13),(0,64,14),(0,65,1),(0,65,2),(0,65,3),(0,65,4),(0,65,5),(0,65,6),(0,65,7),(0,65,8),(0,65,9),(0,65,10),(0,65,11),(0,65,12),(0,65,13),(0,65,14),(0,66,1),(0,66,2),(0,66,3),(0,66,4),(0,66,5),(0,66,6),(0,66,7),(0,66,8),(0,66,9),(0,66,10),(0,66,11),(0,66,12),(0,66,13),(0,66,14),(0,67,1),(0,67,2),(0,67,3),(0,67,4),(0,67,5),(0,67,6),(0,67,7),(0,67,8),(0,67,9),(0,67,10),(0,67,11),(0,67,12),(0,67,13),(0,67,14),(0,68,1),(0,68,2),(0,68,3),(0,68,4),(0,68,5),(0,68,6),(0,68,7),(0,68,8),(0,68,9),(0,68,10),(0,68,11),(0,68,12),(0,68,13),(0,68,14),(0,69,1),(0,69,2),(0,69,3),(0,69,4),(0,69,5),(0,69,6),(0,69,7),(0,69,8),(0,69,9),(0,69,10),(0,69,11),(0,69,12),(0,69,13),(0,69,14),(0,70,1),(0,70,2),(0,70,3),(0,70,4),(0,70,5),(0,70,6),(0,70,7),(0,70,8),(0,70,9),(0,70,10),(0,70,11),(0,70,12),(0,70,13),(0,70,14),(0,71,1),(0,71,2),(0,71,3),(0,71,4),(0,71,5),(0,71,6),(0,71,7),(0,71,8),(0,71,9),(0,71,10),(0,71,11),(0,71,12),(0,71,13),(0,71,14),(0,72,1),(0,72,2),(0,72,3),(0,72,4),(0,72,5),(0,72,6),(0,72,7),(0,72,8),(0,72,9),(0,72,10),(0,72,11),(0,72,12),(0,72,13),(0,72,14),(0,73,1),(0,73,2),(0,73,3),(0,73,4),(0,73,5),(0,73,6),(0,73,7),(0,73,8),(0,73,9),(0,73,10),(0,73,11),(0,73,12),(0,73,13),(0,73,14),(0,74,1),(0,74,2),(0,74,3),(0,74,4),(0,74,5),(0,74,6),(0,74,7),(0,74,8),(0,74,9),(0,74,10),(0,74,11),(0,74,12),(0,74,13),(0,74,14),(0,75,1),(0,75,2),(0,75,3),(0,75,4),(0,75,5),(0,75,6),(0,75,7),(0,75,8),(0,75,9),(0,75,10),(0,75,11),(0,75,12),(0,75,13),(0,75,14),(0,76,1),(0,76,2),(0,76,3),(0,76,4),(0,76,5),(0,76,6),(0,76,7),(0,76,8),(0,76,9),(0,76,10),(0,76,11),(0,76,12),(0,76,13),(0,76,14),(0,77,1),(0,77,2),(0,77,3),(0,77,4),(0,77,5),(0,77,6),(0,77,7),(0,77,8),(0,77,9),(0,77,10),(0,77,11),(0,77,12),(0,77,13),(0,77,14),(0,78,1),(0,78,2),(0,78,3),(0,78,4),(0,78,5),(0,78,6),(0,78,7),(0,78,8),(0,78,9),(0,78,10),(0,78,11),(0,78,12),(0,78,13),(0,78,14),(0,79,1),(0,79,2),(0,79,3),(0,79,4),(0,79,5),(0,79,6),(0,79,7),(0,79,8),(0,79,9),(0,79,10),(0,79,11),(0,79,12),(0,79,13),(0,79,14),(0,80,1),(0,80,2),(0,80,3),(0,80,4),(0,80,5),(0,80,6),(0,80,7),(0,80,8),(0,80,9),(0,80,10),(0,80,11),(0,80,12),(0,80,13),(0,80,14),(0,81,1),(0,81,2),(0,81,3),(0,81,4),(0,81,5),(0,81,6),(0,81,7),(0,81,8),(0,81,9),(0,81,10),(0,81,11),(0,81,12),(0,81,13),(0,81,14),(0,82,1),(0,82,2),(0,82,3),(0,82,4),(0,82,5),(0,82,6),(0,82,7),(0,82,8),(0,82,9),(0,82,10),(0,82,11),(0,82,12),(0,82,13),(0,82,14),(0,83,1),(0,83,2),(0,83,3),(0,83,4),(0,83,5),(0,83,6),(0,83,7),(0,83,8),(0,83,9),(0,83,10),(0,83,11),(0,83,12),(0,83,13),(0,83,14),(0,84,1),(0,84,2),(0,84,3),(0,84,4),(0,84,5),(0,84,6),(0,84,7),(0,84,8),(0,84,9),(0,84,10),(0,84,11),(0,84,12),(0,84,13),(0,84,14),(0,85,1),(0,85,2),(0,85,3),(0,85,4),(0,85,5),(0,85,6),(0,85,7),(0,85,8),(0,85,9),(0,85,10),(0,85,11),(0,85,12),(0,85,13),(0,85,14),(0,86,1),(0,86,2),(0,86,3),(0,86,4),(0,86,5),(0,86,6),(0,86,7),(0,86,8),(0,86,9),(0,86,10),(0,86,11),(0,86,12),(0,86,13),(0,86,14),(0,87,1),(0,87,2),(0,87,3),(0,87,4),(0,87,5),(0,87,6),(0,87,7),(0,87,8),(0,87,9),(0,87,10),(0,87,11),(0,87,12),(0,87,13),(0,87,14),(0,88,1),(0,88,2),(0,88,3),(0,88,4),(0,88,5),(0,88,6),(0,88,7),(0,88,8),(0,88,9),(0,88,10),(0,88,11),(0,88,12),(0,88,13),(0,88,14),(0,89,1),(0,89,2),(0,89,3),(0,89,4),(0,89,5),(0,89,6),(0,89,7),(0,89,8),(0,89,9),(0,89,10),(0,89,11),(0,89,12),(0,89,13),(0,89,14),(0,90,1),(0,90,2),(0,90,3),(0,90,4),(0,90,5),(0,90,6),(0,90,7),(0,90,8),(0,90,9),(0,90,10),(0,90,11),(0,90,12),(0,90,13),(0,90,14),(0,91,1),(0,91,2),(0,91,3),(0,91,4),(0,91,5),(0,91,6),(0,91,7),(0,91,8),(0,91,9),(0,91,10),(0,91,11),(0,91,12),(0,91,13),(0,91,14),(0,92,1),(0,92,2),(0,92,3),(0,92,4),(0,92,5),(0,92,6),(0,92,7),(0,92,8),(0,92,9),(0,92,10),(0,92,11),(0,92,12),(0,92,13),(0,92,14),(0,93,1),(0,93,2),(0,93,3),(0,93,4),(0,93,5),(0,93,6),(0,93,7),(0,93,8),(0,93,9),(0,93,10),(0,93,11),(0,93,12),(0,93,13),(0,93,14),(0,94,1),(0,94,2),(0,94,3),(0,94,4),(0,94,5),(0,94,6),(0,94,7),(0,94,8),(0,94,9),(0,94,10),(0,94,11),(0,94,12),(0,94,13),(0,94,14),(0,95,1),(0,95,2),(0,95,3),(0,95,4),(0,95,5),(0,95,6),(0,95,7),(0,95,8),(0,95,9),(0,95,10),(0,95,11),(0,95,12),(0,95,13),(0,95,14),(0,96,1),(0,96,2),(0,96,3),(0,96,4),(0,96,5),(0,96,6),(0,96,7),(0,96,8),(0,96,9),(0,96,10),(0,96,11),(0,96,12),(0,96,13),(0,96,14),(0,97,1),(0,97,2),(0,97,3),(0,97,4),(0,97,5),(0,97,6),(0,97,7),(0,97,8),(0,97,9),(0,97,10),(0,97,11),(0,97,12),(0,97,13),(0,97,14),(0,98,1),(0,98,2),(0,98,3),(0,98,4),(0,98,5),(0,98,6),(0,98,7),(0,98,8),(0,98,9),(0,98,10),(0,98,11),(0,98,12),(0,98,13),(0,98,14),(0,99,1),(0,99,2),(0,99,3),(0,99,4),(0,99,5),(0,99,6),(0,99,7),(0,99,8),(0,99,9),(0,99,10),(0,99,11),(0,99,12),(0,99,13),(0,99,14),(0,100,1),(0,100,2),(0,100,3),(0,100,4),(0,100,5),(0,100,6),(0,100,7),(0,100,8),(0,100,9),(0,100,10),(0,100,11),(0,100,12),(0,100,13),(0,100,14),(0,101,1),(0,101,2),(0,101,3),(0,101,4),(0,101,5),(0,101,6),(0,101,7),(0,101,8),(0,101,9),(0,101,10),(0,101,11),(0,101,12),(0,101,13),(0,101,14);
/*!40000 ALTER TABLE `product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product_category` (
  `deleted` tinyint(1) DEFAULT NULL,
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (0,1,1),(0,2,1),(0,3,1),(0,4,1),(0,5,1),(0,6,1),(0,7,1),(0,8,1),(0,9,1),(0,10,1),(0,11,1),(0,12,1),(0,13,1),(0,14,1),(0,15,1),(0,16,1),(0,17,1),(0,18,1),(0,19,2),(0,118,2),(0,119,2),(0,120,2),(0,121,2),(0,122,2),(0,123,2),(0,124,2),(0,125,2),(0,126,2),(0,127,3),(0,128,3),(0,129,3),(0,130,3),(0,131,3),(0,132,3),(0,133,3),(0,134,4),(0,135,4),(0,136,4),(0,137,4),(0,138,4),(0,139,4),(0,140,4),(0,141,4),(0,142,4),(0,143,4),(0,144,4),(0,145,4),(0,146,4),(0,147,4),(0,148,4),(0,149,4),(0,150,4),(0,151,4),(0,152,4),(0,153,4),(0,154,4),(0,155,4),(0,156,4),(0,157,4),(0,158,4),(0,159,4),(0,160,4),(0,161,4),(0,162,4),(0,163,4),(0,164,4),(0,165,4),(0,166,5),(0,167,5),(0,168,5),(0,169,5),(0,170,5),(0,171,5),(0,172,5),(0,173,5),(0,174,5),(0,175,5),(0,176,5),(0,177,5),(0,178,5),(0,179,5),(0,180,5),(0,181,6),(0,182,6),(0,183,6),(0,184,6),(0,185,6),(0,186,6),(0,187,6),(0,188,6),(0,189,6),(0,190,6),(0,191,6),(0,192,6),(0,193,6),(0,194,6),(0,195,6),(0,196,6),(0,197,7),(0,198,7),(0,199,7),(0,200,7),(0,201,7),(0,202,7);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `review` (
  `deleted` tinyint(1) DEFAULT NULL,
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `review` text COLLATE utf8mb4_general_ci NOT NULL,
  `rating` smallint(6) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (0,1,1,1,'this is some nice stuff',4,'2019-05-07 21:37:05'),(0,2,1,1,'Some avarage stuff',3,'2019-05-07 21:50:02'),(0,3,4,2,'Good one',3,'2019-05-08 10:25:44'),(0,4,4,2,'Good one',3,'2019-05-08 17:46:12'),(0,7,4,3,'I love this',4,'2019-05-08 19:39:11');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shipping` (
  `deleted` tinyint(1) DEFAULT NULL,
  `shipping_id` int(11) NOT NULL AUTO_INCREMENT,
  `shipping_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `shipping_cost` decimal(10,2) NOT NULL,
  `shipping_region_id` int(11) NOT NULL,
  PRIMARY KEY (`shipping_id`),
  KEY `shipping_region_id` (`shipping_region_id`),
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`shipping_region_id`) REFERENCES `shipping_region` (`shipping_region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping`
--

LOCK TABLES `shipping` WRITE;
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
INSERT INTO `shipping` VALUES (0,1,'Next Day Delivery ($20)',20.00,2),(0,2,'3-4 Days ($10)',10.00,2),(0,3,'7 Days ($5)',5.00,2),(0,4,'By air (7 days, $25)',25.00,3),(0,5,'By sea (28 days, $10)',10.00,3),(0,6,'By air (10 days, $35)',35.00,4),(0,7,'By sea (28 days, $30)',30.00,4);
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_region`
--

DROP TABLE IF EXISTS `shipping_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shipping_region` (
  `deleted` tinyint(1) DEFAULT NULL,
  `shipping_region_id` int(11) NOT NULL AUTO_INCREMENT,
  `shipping_region` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`shipping_region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_region`
--

LOCK TABLES `shipping_region` WRITE;
/*!40000 ALTER TABLE `shipping_region` DISABLE KEYS */;
INSERT INTO `shipping_region` VALUES (0,1,'Please Select'),(0,2,'US / Canada'),(0,3,'Europe'),(0,4,'Rest of World'),(0,5,'kenya'),(NULL,6,'SA');
/*!40000 ALTER TABLE `shipping_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shopping_cart` (
  `deleted` tinyint(1) DEFAULT NULL,
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `attributes` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `buy_now` tinyint(1) NOT NULL,
  `added_on` datetime NOT NULL,
  `cart_id` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `shopping_cart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
INSERT INTO `shopping_cart` VALUES (0,57,5,'Black',1,1,'2019-05-10 23:44:01','06ddc3da-6076-48e8-a183-6a29cf12b87'),(0,58,2,'Red',19,0,'2019-05-10 23:44:01','06ddc3da-6076-48e8-a183-6a29cf12b87'),(0,62,7,'Yellow',3,1,'2019-05-11 18:42:55','06ddc3da-6076-48e8-a183'),(0,63,71,'Green',8,1,'2019-05-11 18:56:22','06ddc3da-6076-48e8-a183'),(0,64,76,'Green',2,1,'2019-05-12 10:26:11','06ddc3da-6076-48e8-a1835'),(0,65,12,'Brown',1,1,'2019-05-12 10:26:11','06ddc3da-6076-48e8-a1835'),(0,66,12,'Brown',1,1,'2019-05-12 11:35:19','06ddc3da-6076-48e8-a1835jj');
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax`
--

DROP TABLE IF EXISTS `tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tax` (
  `deleted` tinyint(1) DEFAULT NULL,
  `tax_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tax_percentage` decimal(10,2) NOT NULL,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax`
--

LOCK TABLES `tax` WRITE;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` VALUES (0,1,'Sales Tax at 8.5%',8.50),(0,2,'No Tax',0.00);
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-13  8:50:46
