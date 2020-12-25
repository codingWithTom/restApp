//
//  NotificationPresentation.swift
//  RestApp
//
//  Created by Tomas Trujillo on 2020-12-23.
//

import UIKit

protocol NotificationPresentation {
  func promptUserForNotificationSettings(from: UIViewController)
}

final class NotificationPresentationAdapter: NotificationPresentation {
  func promptUserForNotificationSettings(from controller: UIViewController) {
    let alertController = UIAlertController(title: "Notification are currently disabled",
                                            message: "To get notified when this establishment opens, please go to your settings and enable notifications.",
                                            preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { _ in
      guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return}
      UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }))
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    DispatchQueue.main.async {
      controller.present(alertController, animated: true, completion: nil)
    }
  }
}
