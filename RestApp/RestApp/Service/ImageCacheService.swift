//
//  ImageCacheService.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-11-14.
//

import UIKit

protocol ImageCacheService {
  func getImage(from: String, completion: @escaping (UIImage?) -> Void)
}

final class ImageCacheServiceAdapter: ImageCacheService {
  static let shared = ImageCacheServiceAdapter()
  private let imageURLDomain = "http://localhost:3000/images"
  private lazy var imageDownloadQueue = DispatchQueue.init(label: "com.CodingWithTom.RestApp.imageQueue", qos: .userInitiated)
  
  private var imageDirectoryURL: URL {
    let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    return URL(fileURLWithPath: "images", relativeTo: path)
  }
  
  private init() {
    createImageDirectory()
  }
  
  func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
    if let image = retrieveCacheImage(for: url) {
      completion(image)
    } else {
      imageDownloadQueue.async { [weak self] in
        guard
          let self = self,
          let imageURL = URL(string: "\(self.imageURLDomain)/\(url)"),
          let data = try? Data(contentsOf: imageURL)
        else {
          completion(nil)
          return
        }
        do {
          try data.write(to: URL(fileURLWithPath: url, relativeTo: self.imageDirectoryURL))
        } catch {
          print("Error storing image: \(error)")
        }
        DispatchQueue(label: "Randomquque").asyncAfter(deadline: .now() + 2.0) { completion(UIImage(data: data)) }
      }
    }
  }
}

private extension ImageCacheServiceAdapter {
  func createImageDirectory() {
    do {
      try FileManager.default.createDirectory(at: imageDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    } catch { }
  }
  
  func retrieveCacheImage(for url: String) -> UIImage? {
    let localImageURL = URL(fileURLWithPath: url, relativeTo: imageDirectoryURL)
    guard let imageData = try? Data(contentsOf: localImageURL) else { return nil }
    return UIImage(data: imageData)
  }
}
