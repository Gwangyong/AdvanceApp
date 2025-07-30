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

  let titleLabel = UILabel().then {
    $0.text = "검색 결과"
    $0.font = .boldSystemFont(ofSize: 20)
    $0.textColor = .label
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
