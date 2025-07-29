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
  
  private lazy var searchBar = UISearchBar().then {
    $0.placeholder = "책 제목"
    $0.searchBarStyle = .minimal
    $0.delegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureLayout()
    configureSearchBar()
  }
  
  // MARK: configureUI
  private func configureUI() {
    view.backgroundColor = .white
    
    [searchBar].forEach{ view.addSubview($0) }
  }
  
  // MARK: configureLayout
  private func configureLayout() {
    searchBar.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: - SearchBar 자동완성 끄기
  private func configureSearchBar() {
    if let textField = searchBar.value(forKey: "searchField") as? UITextField { // SearchBar에 내부적으로 있는 TextField
      textField.autocorrectionType = .no       // 자동 수정 끄기
      textField.autocapitalizationType = .none // 자동 대문자 끄기
      textField.spellCheckingType = .no        // 맞춤법 검사 끄기
    }
  }
  
}

extension BookSearchViewController: UISearchBarDelegate {
  
}
