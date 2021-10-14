//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by KEEN on 2021/10/13.
//

import UIKit

class ShoppingListViewController: UIViewController {
  
  // MARK: Properties
  var shoppingList: [ShoppingItem] = [] {
    didSet {
      saveData()
    }
  }
  
  // MARK: UI
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var addCardView: UIView!
  @IBOutlet weak var emptyLabel: UILabel!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    loadData()
  }
  
  // MARK: Configure
  func configure() {
    tableView.delegate = self
    tableView.dataSource = self
    
    addButton.layer.cornerRadius = CGFloat(8)
    addCardView.layer.cornerRadius = CGFloat(8)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    tapGesture.cancelsTouchesInView = true
    tableView.addGestureRecognizer(tapGesture)
  }
  
  @objc func hideKeyboard() {
    self.tableView.endEditing(true)
  }
  
  fileprivate func failAlert(_ message: String) {
    UIAlertController.show(self, contentType: .error, message: message)
  }
  
  // MARK: Managing Data
  func loadData() {
    let userDefaults = UserDefaults.standard
    
    if let data = userDefaults.object(forKey: "shoppingList") as? [[String: Any]] {
      var list = [ShoppingItem]()
      
      for d in data {
        guard let name = d["name"] as? String else { return }
        guard let isChecked = d["isChecked"] as? Bool else { return }
        guard let isStarrted = d["isStarred"] as? Bool else { return }
        
        list.append(ShoppingItem(name: name, isChecked: isChecked, isStared: isStarrted))
      }
      self.shoppingList = list
    }
  }
  
  func saveData() {
    var list: [[String: Any]] = []
    
    for item in shoppingList {
      let data: [String: Any] = [
        "name": item.name,
        "isChecked": item.isChecked,
        "isStarred": item.isStared
      ]
      list.append(data)
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(list, forKey: "shoppingList")
    
    tableView.reloadData()
  }
  
  // MARK: Action
  @IBAction func onAddButton(_ sender: UIButton) {
    if let itemName = textField.text {
      if itemName.isEmpty {
        failAlert("목록이름이 비어있습니다!\n작성 후 다시시도 해주세요.")
      } else {
        let shoppingItem = ShoppingItem(name: itemName)
        shoppingList.append(shoppingItem)
        textField.text = ""
        textField.endEditing(true)
      }
    } else {
      failAlert("목록 추가에 실패하였습니다.\n다시시도 해주세요!")
    }
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
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      shoppingList.remove(at: indexPath.row)
      tableView.reloadData()
    }
  }
}

// MARK: Extension - UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if shoppingList.count == 0 {
      emptyLabel.textColor = .black
    } else {
      emptyLabel.textColor = .clear
    }
    return shoppingList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier) as? ShoppingListTableViewCell else { return UITableViewCell() }
    cell.checkButton.tag = indexPath.row
    cell.starButton.tag = indexPath.row
    cell.cellBackgroundView.layer.cornerRadius = CGFloat(8)
    
    let item = shoppingList[indexPath.row]
    cell.titleLabel.text = item.name
    
    cell.selectionStyle = .none
    return cell
  }
}
