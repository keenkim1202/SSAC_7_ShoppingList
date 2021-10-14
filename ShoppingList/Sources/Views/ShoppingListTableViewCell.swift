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
  
  func cellConfigure(_ item: ShoppingItem) {
    self.titleLabel.text = item.name
    
    if item.isChecked {
      self.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
      self.cellBackgroundView.backgroundColor = UIColor(named: "CheckedCellColor")
    } else {
      self.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
      self.cellBackgroundView.backgroundColor = UIColor(named: "NotCheckedCellColor")
    }
    
    if item.isStared {
      self.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    } else {
      self.starButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    self.selectionStyle = .none
  }
}
