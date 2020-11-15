'use strict';
const model = require('./restaurantModel');

var categories = [
  new model.Category("1", "Dinning", "sunset.fill", [
    new model.Restaurant("M1", "Island Grill", "restaurant1", "The best grill in town", [
      new model.Rating("M1-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("M1-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
    new model.Restaurant("M2", "Flavoroso", "restaurant2", "Flavors like you have never tested before", [
      new model.Rating("M2-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
    new model.Restaurant("M3", "Sweet Escape", "restaurant3", "Get away from your sour life", [
      new model.Rating("M3-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
    new model.Restaurant("M4", "Grandma’s Sweets", "restaurant4", "Makes you remember home", [
      new model.Rating("M4-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("M4-2", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
    new model.Restaurant("M5", "Grassfed Grill", "restaurant5", "Top quality steaks", [
      new model.Rating("M5-1", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
  ]),
  new model.Category("2", "Lunch", "sunrise.fill", [
    new model.Restaurant("L1", "Freddy’s Stove", "restaurant1", "Food like you've never seen before", [
      new model.Rating("L1-1", "1", "Worst place! Couldn't get a decent drink."),
      new model.Rating("L1-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
    new model.Restaurant("L2", "Green Curry", "restaurant2", "Top shelf curry", [
      new model.Rating("L2-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L2-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
    new model.Restaurant("L3", "Pancake World", "restaurant3", "Best way to start your day", [], []),
    new model.Restaurant("L4", "Mediterra Seafood", "restaurant4", "Unmatched sea food", [
      new model.Rating("L4-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
    new model.Restaurant("L5", "Greenanic Smoothies", "restaurant5", "Up your day with these veggie-rich smoothies", [
      new model.Rating("L5-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L5-2", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
  ]),
  new model.Category("3", "Desserts", "tuningfork", [
    new model.Restaurant("N1", "Freddy’s Stove", "restaurant1", "Food like you've never seen before", [
      new model.Rating("N1-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
    new model.Restaurant("N2", "Green Curry", "restaurant2", "Top shelf curry", [
      new model.Rating("N2-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
  ]),
  new model.Category("4", "Brunch", "seal.fill", [
    new model.Restaurant("O1", "Island Grill", "restaurant1", "The best grill in town", [
      new model.Rating("O1-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O1-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
    new model.Restaurant("O2", "Flavoroso", "restaurant2", "Flavors like you have never tested before", [
      new model.Rating("O2-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O2-2", "3", "Average food. Service took longer than expected")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
    new model.Restaurant("O3", "Sweet Escape", "restaurant3", "Get away from your sour life", [
      new model.Rating("O3-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O3-2", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg']),
    new model.Restaurant("O4", "Grassfed Grill", "restaurant5", "Top quality steaks", [
      new model.Rating("O4-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O4-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg']),
  ])
];

var categoryID = "";
var restaurantID = "";
var ratingID = 0;

exports.restaurants_all = function(req, res) {
  res.json(categories);
};

exports.add_rating = function(req, res) {
  restaurantID = req.params.restaurantID;
  categoryID = req.params.categoryID;
  const categoryIndex = categories.findIndex(findCateogryIndex); 
  const resturantIndex = categories[categoryIndex].restaurants.findIndex(findRestaurantIndex);
  var object = req.body;
  object.ratingID = "" + ratingID
  ratingID += 1;
  const rating = JSON.parse(JSON.stringify(req.body));
  categories[categoryIndex].restaurants[resturantIndex].ratings.push(rating);
  res.json(categories);
};

function findCateogryIndex(value, index, array) {
 return value.categoryID == categoryID;
}

function findRestaurantIndex(value, index, array) {
  return value.restaurantID == restaurantID;
 }