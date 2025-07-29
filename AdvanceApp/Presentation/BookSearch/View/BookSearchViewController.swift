//
//  SearchViewController.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: CollectionView + SearchBar
// searchBar는 만약 커지면 추후 분리 예정

import UIKit
import SnapKit
import Then

class BookSearchViewController: UIViewController {
  private let label = UILabel().then {
    $0.text = "검색 화면"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(label)
    label.snp.makeConstraints {
      $0.center.equalTo(view.safeAreaLayoutGuide)
    }
  }
  

}
