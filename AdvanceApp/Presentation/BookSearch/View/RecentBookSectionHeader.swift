//
//  RecentBookSectionHeader.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: 최근 본 책 SectionHeader

import UIKit
import SnapKit
import Then

class RecentBookSectionHeader: UICollectionReusableView {
  static let id = "RecentBookSectionHeader"
  
  let titleLabel = UILabel().then {
    $0.text = "최근 본 책"
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
    addSubview(titleLabel)
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
