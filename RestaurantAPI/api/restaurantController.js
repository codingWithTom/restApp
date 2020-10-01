'use strict';

exports.restaurants_all = function(req, res) {
  res.json([
    { 
    name: "Dinning",
    iconImageName: "sunset.fill",
    restaurants: [
      {
        restaurantID: "M1",
        name: "Island Grill",
        imageName: "restaurant1",
        description: "The best grill in town",
        ratings: []
      },
      {
        restaurantID: "M2",
        name: "Flavoroso",
        imageName: "restaurant2",
        description: "Flavors like you have never tested before",
        ratings: []
      },
      {
        restaurantID: "M3",
        name: "Sweet Escape",
        imageName: "restaurant3",
        description: "Get away from your sour life",
        ratings: []
      },
      {
        restaurantID: "M4",
        name: "Grandma’s Sweets",
        imageName: "restaurant4",
        description: "Makes you remember home",
        ratings: []
      },
      {
        restaurantID: "M5",
        name: "Grassfed Grill",
        imageName: "restaurant5",
        description: "Top quality steaks",
        ratings: []
      }
    ]
  },
  { 
    name: "Lunch",
    iconImageName: "sunrise.fill",
    restaurants: [
      {
        restaurantID: "L1",
        name: "Freddy’s Stove",
        imageName: "restaurant1",
        description: "Food like you've never seen before",
        ratings: []
      },
      {
        restaurantID: "L2",
        name: "Green Curry",
        imageName: "restaurant2",
        description: "Top shelf curry",
        ratings: []
      },
      {
        restaurantID: "L3",
        name: "Pancake World",
        imageName: "restaurant3",
        description: "Best way to start your day",
        ratings: []
      },
      {
        restaurantID: "L4",
        name: "Mediterra Seafood",
        imageName: "restaurant4",
        description: "Unmatched sea food",
        ratings: []
      },
      {
        restaurantID: "L5",
        name: "Greenanic Smoothies",
        imageName: "restaurant5",
        description: "Up your day with these veggie-rich smoothies",
        ratings: []
      }
    ]
  },
  { 
    name: "Desserts",
    iconImageName: "tuningfork",
    restaurants: [
      {
        restaurantID: "N1",
        name: "Freddy’s Stove",
        imageName: "restaurant1",
        description: "Food like you've never seen before",
        ratings: []
      },
      {
        restaurantID: "N2",
        name: "Green Curry",
        imageName: "restaurant2",
        description: "Top shelf curry",
        ratings: []
      },
    ]
  },
  { 
    name: "Brunch",
    iconImageName: "seal.fill",
    restaurants: [
      {
        restaurantID: "O1",
        name: "Island Grill",
        imageName: "restaurant1",
        description: "The best grill in town",
        ratings: []
      },
      {
        restaurantID: "O2",
        name: "Flavoroso",
        imageName: "restaurant2",
        description: "Flavors like you have never tested before",
        ratings: []
      },
      {
        restaurantID: "O3",
        name: "Sweet Escape",
        imageName: "restaurant3",
        description: "Get away from your sour life",
        ratings: []
      },
      {
        restaurantID: "O4",
        name: "Grassfed Grill",
        imageName: "restaurant5",
        description: "Top quality steaks",
        ratings: []
      }
    ]
  }
]);
};