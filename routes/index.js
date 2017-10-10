var express = require('express');
var router = express.Router();
var blogModel = require('../model/blogModel');
var fs = require('fs');
var marked = require('marked');
/* GET home page. */
router.post('/article', function(req, res, next) {
    var id = req.body.id;
    fs.readFile('./MD/'+ id + '.md', function(err, data) {
        var html = marked(data.toString());
        res.send({
            version: new Date().getTime(),
            mdContent: html
        });
    });
});
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
