'use strict';

class Category {
  constructor(categoryID, name, iconImageName, restaurants) {
    this.categoryID = categoryID;
    this.name = name;
    this.iconImageName = iconImageName;
    this.restaurants = restaurants;
  }
}

class Restaurant {
  constructor(restaurantID, name, imageName, description, ratings) {
    this.restaurantID = restaurantID;
    this.name = name;
    this.imageName = imageName;
    this.description = description;
    this.ratings = ratings;
  }
}

class Rating {
  constructor(ratingID, score, comment) {
    this.ratingID = ratingID;
    this.score =  parseInt(score, 10);
    this.comment = comment;
  }
}

exports.Category = Category;
exports.Restaurant = Restaurant;
exports.Rating = Rating;