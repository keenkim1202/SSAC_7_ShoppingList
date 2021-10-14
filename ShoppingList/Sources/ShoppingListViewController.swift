//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by KEEN on 2021/10/13.
//

import UIKit

class ShoppingListViewController: UIViewController {
  
  // MARK: Properties
  let dummyData: [String] = ["쇼핑목록1", "쇼핑목록2", "쇼핑목록3", "쇼핑목록4"]

  // MARK: UI
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var addCardView: UIView!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  // MARK: Configure
  func configure() {
    tableView.delegate = self
    tableView.dataSource = self
    
    addButton.layer.cornerRadius = CGFloat(8)
    addCardView.layer.cornerRadius = CGFloat(8)
  }
  
  // MARK: Action
  @IBAction func onAddButton(_ sender: UIButton) {
    print("add button tapped.")
  }
  
  @IBAction func onCheckButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    
    switch sender.isSelected {
    case true:
      sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    case false :
      sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
  }

  @IBAction func onStarButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    
    switch sender.isSelected {
    case true:
      sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
    case false :
      sender.setImage(UIImage(systemName: "star"), for: .normal)
    }
  }
  
}

// MARK: Extension - UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
}

// MARK: Extension - UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dummyData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier) as? ShoppingListTableViewCell else { return UITableViewCell() }
    cell.checkButton.tag = indexPath.row
    cell.starButton.tag = indexPath.row
    
    cell.cellBackgroundView.layer.cornerRadius = CGFloat(8)
    cell.titleLabel.text = dummyData[indexPath.row]
    return cell
  }
}
