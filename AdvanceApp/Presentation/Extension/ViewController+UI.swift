//
//  ViewController+UI.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/30/25.
//

import UIKit
import Then
import SnapKit

extension UIViewController {
  func addTabBarTopBorder() {
    let border = UIView().then {
      $0.backgroundColor = .systemGray4
    }
    
    view.addSubview(border)
    border.snp.makeConstraints {
      $0.leading.trailing.equalTo(view)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.height.equalTo(0.5)
    }
  }
}
