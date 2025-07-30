//
//  SearchViewController.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
// MARK: CollectionView + SearchBar
// searchBar는 만약 커지면 추후 분리 예정

import UIKit
import SnapKit
import Then

class BookSearchViewController: UIViewController {
  
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
    $0.backgroundColor = .red
    $0.delegate = self
    $0.dataSource = self
    $0.register(RecentBookCell.self, forCellWithReuseIdentifier: RecentBookCell.id)
    $0.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.id)
    
    $0.register(
      RecentBookCell.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,
      withReuseIdentifier: RecentBookCell.id
    )
    $0.register(
      SearchResultCell.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SearchResultCell.id
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    setupSearchBar()
  }
  
  // MARK: setupUI
  private func setupUI() {
    view.backgroundColor = .white
    
    [searchBar, collectionView].forEach{ view.addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    searchBar.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: - SearchBar 자동완성 끄기
  private func setupSearchBar() {
    if let textField = searchBar.value(forKey: "searchField") as? UITextField { // SearchBar에 내부적으로 있는 TextField
      textField.autocorrectionType = .no       // 자동 수정 끄기
      textField.autocapitalizationType = .none // 자동 대문자 끄기
      textField.spellCheckingType = .no        // 맞춤법 검사 끄기
    }
  }
  
  // TODO: 아래 2개의 레이아웃에 중복된 헤더 부분은 공용 메서드로 분류하자
  // MARK: - 최근 본 책의 Layout
  private func createRecentBookSectionLayout() -> NSCollectionLayoutSection {
    // Item: width는 그룹 너비의 30%, height는 콘텐츠에 따라 유동적으로. 초기값 180 (늘어나기 가능)
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.3),
      heightDimension: .estimated(180)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // 딱 붙지 않게끔 여백줌
//    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
    
    // Group: width는 그룹 너비에 딱 맞게 100%, height는 유동적으로, 초기값 200
    // 하나의 그룹에 들어갈 item의 개수는, 디바이스 크기와 item과 group의 width값과 여백에 따라 달라짐 유동적?
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(200)
    )
    let group = NSCollectionLayoutGroup.horizontal( // horizontal(가로 방향 배치)
      layoutSize: groupSize,
      subitems: [item]
    )
    
    // 섹션은 크기를 직접 지정하지 않고, 그 안에 포함된 group의 크기에 의해 결정됨
    let section = NSCollectionLayoutSection(group: group)
    // orthogonal은, CollectionView와 수직 방향으로 스크롤. 콜렉션뷰가 세로 스크롤이다? -> 이 section은 가로 스크롤
    // .continuous: 가로로 스르르~하는 자연스러운 스크롤. 뚝뚝 끊기지않는
    section.orthogonalScrollingBehavior = .continuous
    section.interGroupSpacing = 8
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16) // 여백줌. 그냥 오토레이아웃으로 제약줬다 생각?
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(60)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    section.boundarySupplementaryItems = [header] // boundarySupplementaryItems로 섹션 상단에 헤더 뷰 설정
  
    return section
  }
  
  // MARK: - 검색 결과 Layout
  private func createSearchResultSectionLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(100)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(110)
    )
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: groupSize,
      subitems: [item]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 8
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(60)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    section.boundarySupplementaryItems = [header]
    
    return section
  }
}

extension BookSearchViewController: UISearchBarDelegate {
  
}

extension BookSearchViewController: UICollectionViewDelegate {
  
}

extension BookSearchViewController: UICollectionViewDataSource {
  
  // 섹션의 개수
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  
  // 섹션 안에 있는 아이템 개수
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    4
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
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  
}
