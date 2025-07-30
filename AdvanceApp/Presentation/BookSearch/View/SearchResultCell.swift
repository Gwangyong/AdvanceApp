//
//  SearchResultCell.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: 검색 결과 Cell

import UIKit
import SnapKit
import Then

class SearchResultCell: UICollectionViewCell {
  static let id = "SearchResultCell"

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
