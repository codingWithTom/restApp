//
//  Rating.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import Foundation

struct Rating: Decodable {
  let ratingID: String
  let score: String
  let comment: String
}
