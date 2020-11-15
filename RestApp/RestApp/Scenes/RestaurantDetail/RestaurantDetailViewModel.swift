//
//  RestaurantDetailViewModel.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-04.
//

import UIKit

final class RestaurantDetailViewModel {
  struct Dependencies {
    var getShareableInfo: GetShareableInfo = GetShareableInfoAdapter()
    var imageCacheService: ImageCacheService = ImageCacheServiceAdapter.shared
  }
  private let dependencies: Dependencies
  private let restaurant: Restaurant
  var restaurantImageName: String { return restaurant.imageName }
  var restaurantDescription: String { return restaurant.description }
  var title: String { return restaurant.name }
  
  init(dependencies: Dependencies = .init(), restaurant: Restaurant) {
    self.dependencies = dependencies
    self.restaurant = restaurant
  }
  
  func getRatingItems() -> [RatingViewModel] {
    return restaurant.ratings.map { $0.viewModel }
  }
  
  func getImageItems() -> [ImageViewModel] {
    return restaurant.images.map { ImageViewModel(
      imageURL: $0,
      placeHolderImageName: "foodPlaceholder",
      imageLoading: getLoader(for: $0))
    }
  }
  
  func getShareableItems() -> [Any] {
    return dependencies.getShareableInfo.execute(for: restaurant)
  }
}

private extension RestaurantDetailViewModel {
  func getLoader(for url: String) -> (@escaping (UIImage?) -> Void) -> Void {
    return { [weak self] loader in
      self?.dependencies.imageCacheService.getImage(from: url, completion: loader)
    }
  }
}
