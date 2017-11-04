var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/upload', function(req, res, next) {
  res.render('upload');
});

module.exports = router;
