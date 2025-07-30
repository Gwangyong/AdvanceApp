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
  private let label = UILabel().then {
    $0.text = "담은 책 화면"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTabBarTopBorder() // ViewController+UI
    
    view.backgroundColor = .white
    view.addSubview(label)
    label.snp.makeConstraints {
      $0.center.equalTo(view.safeAreaLayoutGuide)
    }
  }
}
