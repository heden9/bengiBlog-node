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

 Date: 10/17/2017 00:46:02 AM
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
INSERT INTO `article` VALUES ('a001', 'bengi\'s blog ', '博客说明', '个人博客站点的第一版，dva + ant-design 的组合已经用过很多次了，每一次使用都能够学到一些新的东西， 发现自己越来越喜欢React这个框架了。这次借着十一放假，用五天的时候搭建了一个博客，顺便能够激发自己写博客的动力。嘻嘻..', '2017-10-12 23:39:51'), ('a002', 'es6（一）', 'es6新特性的说明', 'es6在2017年可谓是大火，越来越多的人频频提及，在React、ReactNative开发中广泛使用。在我看来，javascript在es6的推出后，是越来越健全，真不能认为它是一个\"玩具语言\"啦。haha\n较为深入的学习es6是非常有必要的，我总结了一些es6相关的语法特性及较为详细的使用说明，其中还有一些我的学习心得和总结，希望可以给大家带来帮助。', '2017-10-13 18:21:46'), ('a003', 'es6（二）', 'es6新特性的说明', 'es6在2017年可谓是大火，被越来越多的人频频提及，在React、ReactNative开发中广泛使用。javascript在es6的推出后，是越来越健全，真不能认为它是一个\"玩具语言\"啦。haha 较为深入的学习es6是非常有必要的，我总结了一些es6相关的语法特性及较为详细的使用说明，其中还有一些学习心得，希望可以给大家带来帮助。', '2017-10-14 20:22:14'), ('a004', 'es6之Generator(一)', 'Generator的基本用法简介', '第一次接触这个函数的时候，第一印象是，这个单词咋读...generator 美[ˈdʒɛnəˌretɚ]，然后是，这个函数是干啥的，好难理解啊，function*是啥啊，咋还有个*，咋看着像指针呢...看了好多次阮一峰老师的《ECMAScript 6 入门》,总算有了一些理解。', '2017-10-15 17:26:53'), ('a005', 'es6 之 Generator（二）', 'Generator的异步应用包括thunk和柯里化的一些知识', '如果说主程序是一个行军长队，有两个侦察兵A、B出去探风。同步编程就是行军长队停下来等待A探风回来，保证原来的行军顺序。\n异步编程呢，就是行军长队按照原来的速度前进，侦察兵B在探风结束后，打了个电话回来，告诉部队前方情况如何。此时部队再根据当前情况进行调整策略。\n这个电话 就可以称作为\"回调函数(callback)\"', '2017-10-17 00:45:22');
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
INSERT INTO `t_a` VALUES ('react', 'a001'), ('t005', 'a001'), ('t003', 'a002'), ('t004', 'a002'), ('t003', 'a003'), ('t004', 'a003'), ('t003', 'a004'), ('t004', 'a004'), ('t003', 'a005'), ('t004', 'a005');
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
INSERT INTO `tag` VALUES ('react', 'React'), ('reactnative', 'React Native'), ('t003', 'JavaScript'), ('t004', 'es6'), ('t005', 'dva');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
