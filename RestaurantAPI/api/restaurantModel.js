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
  constructor(restaurantID, name, imageName, description, ratings, images) {
    this.restaurantID = restaurantID;
    this.name = name;
    this.imageName = imageName;
    this.description = description;
    this.ratings = ratings;
    this.images = images;
  }
}

class Rating {
  constructor(ratingID, score, comment) {
    this.ratingID = ratingID;
    this.score =  score;
    this.comment = comment;
  }
}

exports.Category = Category;
exports.Restaurant = Restaurant;
exports.Rating = Rating;