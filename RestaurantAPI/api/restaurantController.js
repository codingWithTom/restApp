'use strict';
const model = require('./restaurantModel');

var categories = [
  new model.Category("1", "Dinning", "sunset.fill", [
    new model.Restaurant("M1", "Island Grill", "restaurant1", "The best grill in town", [
      new model.Rating("M1-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("M1-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("M2", "Flavoroso", "restaurant2", "Flavors like you have never tested before", [
      new model.Rating("M2-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Vegan']),
    new model.Restaurant("M3", "Sweet Escape", "restaurant3", "Get away from your sour life", [
      new model.Rating("M3-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("M4", "Grandma’s Sweets", "restaurant4", "Makes you remember home", [
      new model.Rating("M4-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("M4-2", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], []),
    new model.Restaurant("M5", "Golden Clover Supper Club", "restaurant5", "Top quality steaks", [
      new model.Rating("M5-1", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("M6", "Silver Leaf House", "restaurant6", "The best grill in town", [
      new model.Rating("M6-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("M6-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("M7", "Crazy Blossom Bar and Grill", "restaurant7", "Flavors like you have never tested before", [
      new model.Rating("M7-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Vegan']),
    new model.Restaurant("M8", "Bittersweet Alley Canteen", "restaurant8", "Get away from your sour life", [
      new model.Rating("M8-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("M9", "Slanted Skate Tavern", "restaurant9", "Makes you remember home", [
      new model.Rating("M9-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("M9-2", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], []),
    new model.Restaurant("M10", "Grassfed Grill", "restaurant10", "Top quality steaks", [
      new model.Rating("M10-1", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian']),
  ]),
  new model.Category("2", "Lunch", "sunrise.fill", [
    new model.Restaurant("L1", "The Steak House", "restaurant7", "Food like you've never seen before", [
      new model.Rating("L1-1", "1", "Worst place! Couldn't get a decent drink."),
      new model.Rating("L1-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L2", "Old Towne Kettle Pubhouse", "restaurant3", "Top shelf curry", [
      new model.Rating("L2-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L2-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L3", "Pancake World", "restaurant9", "Best way to start your day", [
      new model.Rating("L3-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L3-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], [], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L4", "Mediterra Seafood", "restaurant4", "Unmatched sea food", [
      new model.Rating("L4-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free']),
    new model.Restaurant("L5", "Great Steak Ristorante", "restaurant10", "Up your day with these veggie-rich smoothies", [
      new model.Rating("L5-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L5-2", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L6", "Freddy’s Stove", "restaurant1", "Food like you've never seen before", [
      new model.Rating("L6-1", "1", "Worst place! Couldn't get a decent drink."),
      new model.Rating("L6-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L7", "Slanted Bicycle Tavern", "restaurant6", "Top shelf curry", [
      new model.Rating("L7-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L7-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L8", "King Tractor Roadhouse", "restaurant3", "Best way to start your day", [
      new model.Rating("L8-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L8-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], [], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("L9", "Brisk Honey Provisions", "restaurant4", "Unmatched sea food", [
      new model.Rating("L9-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free']),
    new model.Restaurant("L10", "Greenanic Smoothies", "restaurant7", "Up your day with these veggie-rich smoothies", [
      new model.Rating("L10-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("L10-2", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan'])
  ]),
  new model.Category("3", "Desserts", "tuningfork", [
    new model.Restaurant("N1", "Black Clover Supper Club", "restaurant1", "Food like you've never seen before", [
      new model.Rating("N1-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("N2", "Tilted Crave Tastes + Taps", "restaurant10", "Top shelf curry", [
      new model.Rating("N2-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], []),
    new model.Restaurant("N3", "Old Towne Kettle Bistro", "restaurant3", "Food like you've never seen before", [
      new model.Rating("N3-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("N4", "The Plate House", "restaurant2", "Top shelf curry", [
      new model.Rating("N4-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], []),
    new model.Restaurant("N5", "Great Spark Ristorante", "restaurant5", "Food like you've never seen before", [
      new model.Rating("N5-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("N6", "Brisk Maple Provisions", "restaurant2", "Top shelf curry", [
      new model.Rating("N6-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], []),
    new model.Restaurant("N7", "Queen's Bee Place", "restaurant9", "Food like you've never seen before", [
      new model.Rating("N7-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("N8", "Chef's Cup Ristorante", "restaurant6", "Top shelf curry", [
      new model.Rating("N8-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], []),
    new model.Restaurant("N9", "Rogue Bazaar Place", "restaurant7", "Food like you've never seen before", [
      new model.Rating("N9-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("N10", "The on Cupertino Bar and Grill", "restaurant1", "Top shelf curry", [
      new model.Rating("N10-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], []),
    new model.Restaurant("N11", "The on Seymour Bar and Grill", "restaurant8", "Food like you've never seen before", [
      new model.Rating("N11-1", "1", "Worst place! Couldn't get a decent drink.")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("N12", "Green Curry", "restaurant10", "Top shelf curry", [
      new model.Rating("N12-1", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], []),
  ]),
  new model.Category("4", "Brunch", "seal.fill", [
    new model.Restaurant("O1", "Pickled Loon Pubhouse", "restaurant1", "The best grill in town", [
      new model.Rating("O1-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O1-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("O2", "Aster and Fork Kitchen", "restaurant4", "Flavors like you have never tested before", [
      new model.Rating("O2-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O2-2", "3", "Average food. Service took longer than expected")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free']),
    new model.Restaurant("O3", "Regal Blossom Café", "restaurant3", "Get away from your sour life", [
      new model.Rating("O3-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O3-2", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("O4", "Craveable Era Pubhouse", "restaurant6", "Top quality steaks", [
      new model.Rating("O4-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O4-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("O5", "Hungry Tom Grill", "restaurant10", "The best grill in town", [
      new model.Rating("O5-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O5-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("O6", "Thirsty Lily Trattoria", "restaurant2", "Flavors like you have never tested before", [
      new model.Rating("O6-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O6-2", "3", "Average food. Service took longer than expected")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free']),
    new model.Restaurant("O7", "Red Clover Supper Club", "restaurant7", "Get away from your sour life", [
      new model.Rating("O7-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O7-2", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("O8", "Outlaw Pubhouse", "restaurant9", "Top quality steaks", [
      new model.Rating("O8-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O8-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("O9", "Fine Farmer Tavern", "restaurant1", "The best grill in town", [
      new model.Rating("O9-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O9-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian']),
    new model.Restaurant("O10", " Forest Tavern", "restaurant8", "Flavors like you have never tested before", [
      new model.Rating("O10-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O10-2", "3", "Average food. Service took longer than expected")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free']),
    new model.Restaurant("O11", "Tin Canoe Supper Club", "restaurant3", "Get away from your sour life", [
      new model.Rating("O11-1", "5", "Had a wonderful evening here! Superb service and attention!"),
      new model.Rating("O11-2", "3", "Average food. Service took longer than expected")
    ], ['fineItalianFood.jpg', 'josephGonzalezFood-2.jpg', 'josephGonzalezFood.jpg', 'pizza.jpg', 'sameOldCakes.jpg', 'thomasTuckerFood.jpg'], ['Gluten Free', 'Vegetarian', 'Vegan']),
    new model.Restaurant("O12", "Crimson Buddha Bar and Grill", "restaurant5", "Top quality steaks", [
      new model.Rating("O12-1", "3", "Average food. Service took longer than expected"),
      new model.Rating("O12-2", "5", "Had a wonderful evening here! Superb service and attention!")
    ], ['alexMunsellFood.jpg', 'bbqFood.jpg','brookeLarkFood.jpg','caseyLeeFood.jpg', 'fastFood.jpg'], ['Gluten Free', 'Vegetarian']),
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