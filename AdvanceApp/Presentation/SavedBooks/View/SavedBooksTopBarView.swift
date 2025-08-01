//
//  SavedBooksTopBarView.swift
//  AdvanceApp
//
//  Created by 서광용 on 8/1/25.
//

import UIKit
import SnapKit
import Then

class SavedBooksTopBarView: UIView {
  
  let deleteAllButton = UIButton().then {
    $0.setTitle("전체 삭제", for: .normal)
    $0.setTitleColor(.lightGray, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
    $0.setTitleColor(.lightGray.withAlphaComponent(0.5), for: .highlighted)
  }
  
  private let titleLabel = UILabel().then {
    $0.text = "담은 책"
    $0.font = .boldSystemFont(ofSize: 24)
    $0.textAlignment = .center
  }
  
  private let addButton = UIButton().then {
    $0.setTitle("추가", for: .normal)
    $0.setTitleColor(.systemGreen, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
    $0.setTitleColor(.systemGreen.withAlphaComponent(0.5), for: .highlighted)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: setupUI
  private func setupUI() {
    backgroundColor = .white
    [deleteAllButton, titleLabel, addButton].forEach { addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    deleteAllButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(24)
      $0.centerY.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    addButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(24)
      $0.centerY.equalToSuperview()
    }
  }
}
