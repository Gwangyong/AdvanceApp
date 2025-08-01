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
    navigationController?.setNavigationBarHidden(true, animated: false)
    view.backgroundColor = .white
    [topBarView, tableView, bottomBarView].forEach { view.addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    topBarView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(44)
    }
  }
}
