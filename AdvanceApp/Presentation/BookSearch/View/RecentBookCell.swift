//
//  RecentBookCell.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: 최근 본 책 Cell

import UIKit
import SnapKit
import Then

class RecentBookCell: UICollectionViewCell {
  static let id = "RecentBookCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .blue
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
