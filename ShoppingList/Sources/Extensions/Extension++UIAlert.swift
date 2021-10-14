//
//  Extension++UIAlert.swift
//  ShoppingList
//
//  Created by KEEN on 2021/10/14.
//

import UIKit

extension UIAlertController {
  enum ContentType: String {
    case error = "⚠️ 실패 🤯"
  }
  
  static func show(_ presentedHost: UIViewController,
                   contentType: ContentType,
                   message: String) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    let okAction = UIAlertAction(
      title: "확인", style: .default, handler: nil)
    alert.addAction(okAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
}
