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
  
  private let bookImageView = UIImageView().then {
    $0.image = UIImage(named: "Placeholder")
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds  = true
    $0.backgroundColor = .white
    $0.layer.borderWidth = 0.3
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  private let bookTitleLabel = UILabel().then {
    $0.text = "[국내도서] 임시"
    $0.font = .systemFont(ofSize: 14, weight: .regular)
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
    backgroundColor = .systemBackground
    
    [bookImageView, bookTitleLabel].forEach { contentView.addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    bookImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5) // 2:3비율
    }
    
    bookTitleLabel.snp.makeConstraints {
      $0.top.equalTo(bookImageView.snp.bottom).offset(8)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  // MARK: configure
  func configure(_ book: Document) {
    bookImageView.setImage(urlString: book.thumbnail)
    bookTitleLabel.text = book.title
  }
}
