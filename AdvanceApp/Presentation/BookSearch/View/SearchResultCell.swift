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

  private let bookImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds  = true
    $0.backgroundColor = .white
    $0.layer.borderWidth = 0.3
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  private let horizontalStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 12
    $0.alignment = .top
  }
  
  // 책 제목, 작가명, 금액을 묶는 세로 스택뷰
  private let verticalStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8
    $0.alignment = .top
  }
  
  // 책 제목
  private let bookTitleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.font = .systemFont(ofSize: 18, weight: .medium)
    $0.textColor = .black
  }
  
  // 작가명
  private let bookAuthorLabel =  UILabel().then {
    $0.numberOfLines = 1
    $0.font = .systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .gray
  }
  
  // 금액
  private let bookPriceLabel =  UILabel().then {
    $0.numberOfLines = 1
    $0.font = .systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
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
    contentView.addSubview(horizontalStackView)
    
    [bookImageView, verticalStackView].forEach { horizontalStackView.addArrangedSubview($0) }

    [bookTitleLabel, bookAuthorLabel, bookPriceLabel].forEach { verticalStackView.addArrangedSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    bookImageView.snp.makeConstraints {
      $0.width.equalTo(80)
      $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5) // 2:3 비율
    }
    
    horizontalStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: configure
  func configure(_ book: Document) {
    bookTitleLabel.text = book.title
    bookAuthorLabel.text = book.authors.joined(separator: ", ")
    bookPriceLabel.text = "\(book.price)"
    
    bookImageView.setImage(urlString: book.thumbnail)
  }
}
