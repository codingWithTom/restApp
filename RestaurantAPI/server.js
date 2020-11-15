var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000;


app.use(express.json());
app.use(express.static(__dirname + '/public'));

var routes = require('./api/restaurantRoutes'); //importing route
routes(app); //register the route

app.post(
  '/test',
  (req, res) => res.json(req.body)
)

app.listen(port);