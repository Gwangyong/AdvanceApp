//
//  SavedBooksViewController.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
//

import UIKit
import SnapKit
import Then

class SavedBooksViewController: UIViewController {
  
  private let topBarView = SavedBooksTopBarView()
  private let tableView = UITableView()
  private let bottomBarView = SavedBooksBottomBarView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTabBarTopBorder() // ViewController+UI
    setupUI()
    setupLayout()
  }
  
  // MARK: setupUI
  private func setupUI() {
    view.backgroundColor = .white
    
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    
  }
}
