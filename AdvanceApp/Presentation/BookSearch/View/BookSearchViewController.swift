//
//  SearchViewController.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: CollectionView + SearchBar

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class BookSearchViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel = BookSearchViewModel()
  
  private lazy var searchBar = UISearchBar().then {
    $0.placeholder = "책 제목"
    $0.searchBarStyle = .minimal
    $0.delegate = self
  }
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ in
      switch sectionIndex {
      case 0:
        return self.createRecentBookSectionLayout()
      case 1:
        return self.createSearchResultSectionLayout()
      default:
        return nil
      }
    }
  ).then {
    $0.backgroundColor = .systemBackground
    $0.delegate = self
    $0.dataSource = self
    $0.register(RecentBookCell.self, forCellWithReuseIdentifier: RecentBookCell.id)
    $0.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.id)
    
    $0.register(
      RecentBookSectionHeader.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: RecentBookSectionHeader.id
    )
    $0.register(
      SearchResultSectionHeader.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SearchResultSectionHeader.id
    )
  }
  
  private let tabBarTopBorder = UIView().then {
    $0.backgroundColor = .systemGray4
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    setupSearchBar()
    addTabBarTopBorder() // ViewController+UI
    bindSearchResults()
  }
  
  // MARK: setupUI
  private func setupUI() {
    view.backgroundColor = .white
    
    [searchBar, collectionView, tabBarTopBorder].forEach{ view.addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    searchBar.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    tabBarTopBorder.snp.makeConstraints {
      $0.leading.trailing.equalTo(view)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.height.equalTo(0.5)
    }
  }
  
  // MARK: searchResults가 변경되면 섹션 리로드!
  private func bindSearchResults() {
    viewModel.searchResults.subscribe(onNext: { [weak self] _ in
      // 여기서 reload를 쓴다고? 넌 전혀 Rx를 하고있지 않아.
      self?.collectionView.reloadSections(IndexSet(integer: 1)) // 1번섹션 리로드
    })
    .disposed(by: disposeBag)
  }
  
  // MARK: - SearchBar 자동완성 끄기
  private func setupSearchBar() {
    if let textField = searchBar.value(forKey: "searchField") as? UITextField { // SearchBar에 내부적으로 있는 TextField
      textField.autocorrectionType = .no       // 자동 수정 끄기
      textField.autocapitalizationType = .none // 자동 대문자 끄기
      textField.spellCheckingType = .no        // 맞춤법 검사 끄기
    }
  }
}

extension BookSearchViewController: UISearchBarDelegate {
  // 검색 버튼 누르면 keyword로 API요청
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let keyword = searchBar.text, !keyword.isEmpty else { return }
    viewModel.searchKeyword.onNext(keyword)
    searchBar.resignFirstResponder() // 키보드를 내리는 코드
  }
}

extension BookSearchViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard indexPath.section == 1 else { return }
    let selectedBook = viewModel.searchResults.value[indexPath.item] // 누른 셀의 데이터
    let detailVC = BookDetailViewController()
    detailVC.book = selectedBook // 누른 셀의 데이터를 전달
    detailVC.modalPresentationStyle = .automatic // 하단에서 올라오는 카드 형식. 스크롤 가능
    present(detailVC, animated: true)
  }
}

extension BookSearchViewController: UICollectionViewDataSource {
  
  // 섹션의 개수
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  
  // 섹션 안에 있는 아이템 개수
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 5
    case 1:
      return viewModel.searchResults.value.count
    default:
      return 0
    }
  }
  
  // 섹션 헤더를 어떻게 보여줄지
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch indexPath.section {
    case 0:
      guard let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: RecentBookSectionHeader.id,
        for: indexPath
      ) as? RecentBookSectionHeader else { return UICollectionReusableView() }
      return header
    case 1:
      guard let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SearchResultSectionHeader.id,
        for: indexPath
      ) as? SearchResultSectionHeader else { return UICollectionReusableView() }
      return header
    default:
      return UICollectionReusableView()
    }
  }
  
  // 아이템의 셀을 어떻게 보여줄지
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: RecentBookCell.id,
        for: indexPath
      ) as? RecentBookCell else { return UICollectionViewCell() }
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: SearchResultCell.id,
        for: indexPath
      ) as? SearchResultCell else { return UICollectionViewCell() }
      let book = viewModel.searchResults.value[indexPath.item]
      cell.configure(book)
      return cell
    default:
      return UICollectionViewCell()
    }
  }
}
