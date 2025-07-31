//
//  BookSearchViewController+Layout.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/31/25.
//

import UIKit

extension BookSearchViewController {
  // MARK: - 최근 본 책의 Layout
  func createRecentBookSectionLayout() -> NSCollectionLayoutSection {
    // Item: width는 그룹 너비의 30%, height는 콘텐츠에 따라 유동적으로. 초기값 180 (늘어나기 가능)
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    // Group: width는 그룹 너비에 딱 맞게 100%, height는 유동적으로, 초기값 200
    // 하나의 그룹에 들어갈 item의 개수는, 디바이스 크기와 item과 group의 width값과 여백에 따라 달라짐 유동적?
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.25),
      heightDimension: .estimated(180)
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
    section.interGroupSpacing = 8 // group끼리 붙지 않도록 spacing
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16) // 여백줌. 그냥 오토레이아웃으로 제약줬다 생각?
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(60) // 최초 60. Label 넣으면 그에 맞춰서 작으면 작아지고 커지면 커짐
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
  func createSearchResultSectionLayout() -> NSCollectionLayoutSection {
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
