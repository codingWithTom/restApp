'use strict';
module.exports = function(app) {
  var restaurants = require('./restaurantController');

  app.route('/restaurants')
    .get(restaurants.restaurants_all)
};