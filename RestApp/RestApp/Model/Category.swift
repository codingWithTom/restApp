//
//  Category.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-09-29.
//

import Foundation

struct Category: Codable {
  let categoryID: String
  let name: String
  let iconImageName: String
  let restaurants: [Restaurant]
}
