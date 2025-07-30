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

  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
