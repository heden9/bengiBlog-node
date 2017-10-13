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

 Date: 10/13/2017 18:47:49 PM
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
INSERT INTO `article` VALUES ('a001', 'bengi\'s blog ', '博客说明', '个人博客站点的第一版，dva + ant-design 的组合已经用过很多次了，每一次使用都能够学到一些新的东西， 发现自己越来越喜欢React这个框架了。这次借着十一放假，用五天的时候搭建了一个博客，顺便能够激发自己写博客的动力。嘻嘻..', '2017-10-12 23:39:51'), ('a002', 'es6（一）', 'es6新特性的说明', 'es6在2017年可谓是大火，越来越多的人频频提及，在React、ReactNative开发中广泛使用。在我看来，javascript在es6的推出后，是越来越健全，真不能认为它是一个\"玩具语言\"啦。haha\n较为深入的学习es6是非常有必要的，我总结了一些es6相关的语法特性及较为详细的使用说明，其中还有一些我的学习心得和总结，希望可以给大家带来帮助。', '2017-10-13 18:21:46'), ('a003', 'React Native 集成分享第三方登录功能分享第三方登录模块开发(Android)', '如何在React Native中实现分享和第三方登录的功能', '在我们常用的App中经常会看到分享与第三方登录的功能，可以说分享与第三方登录已经成为了各大APP的必备功能。对于产品运行与推广来说，分享与第三方登录不仅能加强用户粘性，增加流量及新用户，也能提升用户存、留优化产品质量等。 各大平台都有对应的开发平台来提供分享与第三方登录的服务，比如微信开发平台/腾讯开发平台、新浪开发者平台等。因为各大平台及相关SDK存在很大的差异，单独集成起来比较繁琐', '2017-10-01 11:56:48');
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
INSERT INTO `t_a` VALUES ('react', 'a001'), ('t003', 'a001'), ('t005', 'a001'), ('react', 'a002'), ('t002', 'a002'), ('t004', 'a002'), ('reactnative', 'a003'), ('t002', 'a003');
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
INSERT INTO `tag` VALUES ('react', 'React'), ('reactnative', 'React Native'), ('t002', 'Antv'), ('t003', 'JavaScript'), ('t004', 'es6'), ('t005', 'dva');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
