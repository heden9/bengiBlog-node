var express = require('express');
var router = express.Router();
var blogModel = require('../model/blogModel');
var fs = require('fs');
var moment = require('moment');
var marked = require('marked');
/* GET home page. */
const article = function(req, res, next) {
    var id = req.body.id;
    blogModel.queryArticle(id, function (rs) {
        if (!rs) {
            res.send({
                err: '该文章不存在'
            });
            return;
        }
        fs.readFile('./MD/' + rs.title + '.md', function (err, data) {
            if (err) {
                res.send({
                    err: '404 notfound'
                });
                return;
            }
            var html = marked(data.toString());
            var stat = fs.statSync('./MD/' + rs.title + '.md');
            var mtime = stat.mtime;
            res.send({
                version: mtime,
                mdContent: html,
                subTitle: rs.subTitle,
                time: moment(rs.time).format('MMMM Do YYYY, h:mm:ss a'),
                title: rs.title
            });
        });
    });

}
router.post('/article', article);
router.get('/article', article);
router.get('/home', function(req, res, next) {
    blogModel.getAll(function(rs){
        res.send({
            version: new Date().getTime(),
            articleList: rs.articleList,
            tags: rs.tags
        });
    });
});

module.exports = router;
