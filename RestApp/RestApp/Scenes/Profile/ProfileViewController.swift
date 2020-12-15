//
//  PorifleViewController.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-13.
//

import UIKit

class ProfileViewController: UIViewController {
  
  static func instantiateFromStoryboard() -> ProfileViewController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(identifier: "ProfileScene") as? ProfileViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
