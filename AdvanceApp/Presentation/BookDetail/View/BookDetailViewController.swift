//
//  BookDetailViewController.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
//

import UIKit
import SnapKit
import Then

class BookDetailViewController: UIViewController {
  // 전달받을 책 정보
  var book: Document?
  
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  
  private let verticalStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 16
    $0.alignment = .center
  }
  
  // 책 제목
  private let bookTitleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.textAlignment = .center
    $0.numberOfLines = 0
  }
  
  // 작가명
  private let bookAuthorLabel =  UILabel().then {
    $0.font = .systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .gray
    $0.textAlignment = .center
    $0.numberOfLines = 0
  }
  
  // 책 이미지
  private let bookImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
    $0.backgroundColor = .white
    $0.layer.borderWidth = 0.3
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  // 금액
  private let bookPriceLabel =  UILabel().then {
    $0.font = .systemFont(ofSize: 18, weight: .medium)
  }
  
  // 책 설명
  private let contentsLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16, weight: .medium)
    $0.numberOfLines = 0
  }
  
  private let dismissButton = UIButton().then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.backgroundColor = .gray
    $0.tintColor = .white
    $0.layer.cornerRadius = 20
  }
  
  private let saveButton = UIButton().then {
    $0.setTitle("담기", for: .normal)
    $0.backgroundColor = .systemGreen
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 20
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    configure()
  }
  
  // MARK: setupUI
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(verticalStackView)
    
    [
      bookTitleLabel,
      bookAuthorLabel,
      bookImageView,
      bookPriceLabel,
      contentsLabel,
      dismissButton
    ].forEach { verticalStackView.addArrangedSubview($0) }
    
    [dismissButton, saveButton].forEach{ view.addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    scrollView.snp.makeConstraints {
      $0.directionalEdges.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
      $0.width.equalToSuperview() // 가로를 붙여서 가로 스크롤 X
    }
    
    verticalStackView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview().inset(16)
    }
    
    bookTitleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
    }
    
    bookAuthorLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  // MARK: configure
  func configure() {
    bookTitleLabel.text = book?.title
    bookAuthorLabel.text = book?.authors.joined(separator: ", ")
    bookImageView.setImage(urlString: book?.thumbnail)
    bookPriceLabel.text = "\(book?.price ?? 0)"
    contentsLabel.text = book?.contents
  }
}

