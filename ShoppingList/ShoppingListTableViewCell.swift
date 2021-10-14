//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by KEEN on 2021/10/14.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
  static let identifier = "shoppingListCell"

  @IBOutlet weak var checkButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var starButton: UIButton!
  @IBOutlet weak var cellBackgroundView: UIView!
}
