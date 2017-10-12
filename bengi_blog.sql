/*
 Navicat Premium Data Transfer

 Source Server         : SnsProject
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost
 Source Database       : bengi_blog

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : utf-8

 Date: 10/12/2017 23:53:54 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `a_id` varchar(255) NOT NULL,
  `a_title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `a_sub_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `a_content` varchar(255) CHARACTER SET utf8 NOT NULL,
  `a_time` datetime NOT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `article`
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES ('a001', 'bengi\'s blog ', '博客说明', '', '2017-10-12 23:39:51'), ('a002', '教你轻松在React Native中集成统计的功能', 'React Native 集成统计的功能', '有时我们需要知道一款产品上线后的受欢迎程度，推广效果、有多少人安装、使用率，平均在线时长、活跃用户、启动次数、版本分布等数据，这个时候我们不得不用到统计分析。如果条件允许我们可以自己实现统计分析的功能，但如果要做的很专业很详细那么则需要一个庞大的工作量。在这里我们也可以采用第三方统计umneng。 在这篇文章中我会向大家分享，在React Native中集成umeng统计的方法及流程。因为', '2017-10-02 11:53:08'), ('a003', 'React Native 集成分享第三方登录功能分享第三方登录模块开发(Android)', '如何在React Native中实现分享和第三方登录的功能', '在我们常用的App中经常会看到分享与第三方登录的功能，可以说分享与第三方登录已经成为了各大APP的必备功能。对于产品运行与推广来说，分享与第三方登录不仅能加强用户粘性，增加流量及新用户，也能提升用户存、留优化产品质量等。 各大平台都有对应的开发平台来提供分享与第三方登录的服务，比如微信开发平台/腾讯开发平台、新浪开发者平台等。因为各大平台及相关SDK存在很大的差异，单独集成起来比较繁琐', '2017-10-01 11:56:48');
COMMIT;

-- ----------------------------
--  Table structure for `t_a`
-- ----------------------------
DROP TABLE IF EXISTS `t_a`;
CREATE TABLE `t_a` (
  `t_id` varchar(255) NOT NULL,
  `a_id` varchar(255) NOT NULL,
  PRIMARY KEY (`t_id`,`a_id`),
  KEY `a_id` (`a_id`),
  CONSTRAINT `a_id` FOREIGN KEY (`a_id`) REFERENCES `article` (`a_id`),
  CONSTRAINT `t_id` FOREIGN KEY (`t_id`) REFERENCES `tag` (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `t_a`
-- ----------------------------
BEGIN;
INSERT INTO `t_a` VALUES ('react', 'a001'), ('reactnative', 'a001'), ('t003', 'a001'), ('react', 'a002'), ('t002', 'a002'), ('t004', 'a002'), ('t002', 'a003');
COMMIT;

-- ----------------------------
--  Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `t_id` varchar(255) NOT NULL,
  `t_title` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `tag`
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES ('react', 'React'), ('reactnative', 'React Native'), ('t002', 'Antv'), ('t003', 'JavaScript'), ('t004', 'es6');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
