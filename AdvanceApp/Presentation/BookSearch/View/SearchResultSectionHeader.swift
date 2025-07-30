//
//  SearchResultSectionHeader.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: 검색 결과 SectionHeader

import UIKit
import SnapKit
import Then

class SearchResultSectionHeader: UICollectionReusableView {
  static let id = "SearchResultSectionHeader"
  
  private let divider = UIView().then {
    $0.backgroundColor = .systemGray4
  }
  
  let titleLabel = UILabel().then {
    $0.text = "검색 결과"
    $0.font = .boldSystemFont(ofSize: 20)
    $0.textColor = .label
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
    [divider, titleLabel].forEach { addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    divider.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
