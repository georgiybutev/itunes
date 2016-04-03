-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 05, 2012 at 09:00 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `audiofarm`
--
DROP DATABASE `audiofarm`;
CREATE DATABASE `audiofarm` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `audiofarm`;

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--
-- Creation: Apr 29, 2012 at 06:37 PM
-- Last update: Apr 30, 2012 at 11:37 AM
--

DROP TABLE IF EXISTS `artist`;
CREATE TABLE IF NOT EXISTS `artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `artist` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `album` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `year` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `album_art` varchar(25) CHARACTER SET ascii NOT NULL,
  `genre` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `album` (`album`),
  FULLTEXT KEY `artist` (`artist`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`id`, `name`, `artist`, `album`, `year`, `time`, `price`, `quantity`, `album_art`, `genre`) VALUES
(1, 'Careless Whisper', 'George Michael', 'Faith', '1986', '5:00', 1.99, 3, 'img/faith.jpg', 'pop'),
(2, 'Time', 'Pink Floyd', 'Dark Side of the Moon', '1973', '10:00', 2.99, 85, 'img/dsotm.png', 'rock'),
(3, 'Tel Aviv', 'Duran Duran', 'Duran Duran', '1981', '5:16', 0, 0, 'img/duranduran.jpg', 'pop'),
(5, 'Save a Prayer', 'Duran Duran', 'Rio', '1983', '4:96', 9.99, 5, 'img/rio.jpg', 'pop'),
(6, 'Five Spot After Dark', 'Curtis Fuller', 'Bluesette', '1959', '5:00', 1.99, 9, 'img/curtis.jpg', 'jazz');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--
-- Creation: Apr 29, 2012 at 04:51 PM
--

DROP TABLE IF EXISTS `history`;
CREATE TABLE IF NOT EXISTS `history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `user_id`, `song_id`) VALUES
(1, 16, 1),
(2, 16, 2),
(3, 16, 6);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--
-- Creation: Mar 06, 2012 at 06:45 PM
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forname` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` text CHARACTER SET ascii NOT NULL,
  `secretquestion` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `secretanswer` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateofbirth` varchar(25) CHARACTER SET ascii NOT NULL,
  `card` int(25) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `forname`, `surname`, `gender`, `country`, `city`, `email`, `username`, `password`, `secretquestion`, `secretanswer`, `dateofbirth`, `card`, `admin`) VALUES
(12, 'Ken', 'Thompson', 'Male', 'England', 'Athens', 'kenthompson@att.org', 'ken', 'kenkentom', 'Whats your favourite movie', 'Matrix', '11/11/1985', 1996, 0),
(14, 'Isabele', 'Ice', 'Female', 'Wales', 'Cardiff', 'isabeleice@ms.com', 'isabele', '334067afdeb49df26973a3dc52fc142cb7f04e27ebc83a68c72ed052c94c1989dc504b2271ae4b3b32e60d5db4474b77c9494bcf0cfe0b1cb9d6801d38c216c9', 'Whats your favourite movie', 'ALF', '1/2/1981', 100, 1),
(15, 'Hillary', 'Scott', 'Female', 'USA', 'Los Angeles', 'hscott@avn.com', 'hscott', '37938399d4205e2c2d91e1ba66bc67063b3a373ff1e1dfb16483fd403ddcc2b4ef6cef86d522b2cf6c9755dba03577506d668ae2716959508fe06a933a436299', 'Whats your favourite movie', 'Hunger Games', '10/10/1996', 100, 0),
(16, 'Dana', 'Dearmond', 'Female', 'Scotland', 'Edinburgh', 'dana@avn.com', 'dana', '6dca4b66011b47e7dead232813476b3fc633777165f52ace55f17b833bf0e6e4a3cb299d8a20979737c6b87a09c36ee8be41893d6fd363a80f000955ef4c0964', 'Whats your favourite movie', 'Matrix', '22/11/1988', 92, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
