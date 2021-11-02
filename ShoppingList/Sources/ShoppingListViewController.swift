//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by KEEN on 2021/10/13.
//

import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController {
  
  // MARK: Properties
  let localRealm = try! Realm()
  var tasks: Results<ShoppingItem>!
  
  // MARK: UI
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var addCardView: UIView!
  @IBOutlet weak var emptyLabel: UILabel!
  
  // MARK: View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    print(#function)
    configure()
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
    
    tasks = localRealm.objects(ShoppingItem.self)
  }
  
  @objc func hideKeyboard() {
    self.tableView.endEditing(true)
  }
  
  fileprivate func failAlert(_ message: String) {
    UIAlertController.show(self, contentType: .error, message: message)
  }
  
  // MARK: Action
  @IBAction func onAddButton(_ sender: UIButton) {
    if let itemName = textField.text {
      if itemName.isEmpty {
        failAlert("목록이름이 비어있습니다!\n작성 후 다시시도 해주세요.")
      } else {
        let task = ShoppingItem(name: textField.text!)
        try! localRealm.write {
          localRealm.add(task)
        }
        textField.text = ""
        textField.endEditing(true)
        
        tasks = localRealm.objects(ShoppingItem.self)
        tableView.reloadData()
      }
    } else {
      failAlert("목록 추가에 실패하였습니다.\n다시시도 해주세요!")
    }
  }
  
  @IBAction func onCheckButton(_ sender: UIButton) {
    let index = sender.tag
    let taskToUpdate = tasks[index]
    try! localRealm.write {
      taskToUpdate.isChecked.toggle()
    }
    tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
  }
  
  @IBAction func onStarButton(_ sender: UIButton) {
    let index = sender.tag
    let taskToUpdate = tasks[index]
    try! localRealm.write {
      taskToUpdate.isStared.toggle()
    }
    switch sender.isSelected {
    case true:
      sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
    case false :
      sender.setImage(UIImage(systemName: "star"), for: .normal)
    }
    tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
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
      let taskToDelete = tasks[indexPath.row]
      try! localRealm.write {
        localRealm.delete(taskToDelete)
      }
      tableView.reloadData()
    }
  }
}

// MARK: Extension - UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tasks.count == 0 {
      emptyLabel.textColor = .black
    } else {
      emptyLabel.textColor = .clear
    }
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier) as? ShoppingListTableViewCell else { return UITableViewCell() }
    cell.checkButton.tag = indexPath.row
    cell.starButton.tag = indexPath.row
    cell.cellBackgroundView.layer.cornerRadius = CGFloat(8)
    
    let item = tasks[indexPath.row]
    cell.cellConfigure(item)
    
    return cell
  }
}
