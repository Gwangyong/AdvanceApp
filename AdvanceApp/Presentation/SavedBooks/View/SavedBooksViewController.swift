//
//  SavedBooksViewController.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SavedBooksViewController: UIViewController {
  private let viewModel = SavedBooksViewModel()
  
  private let disposeBag = DisposeBag()
  private let topBarView = SavedBooksTopBarView()
  private lazy var tableView = UITableView().then {
    $0.separatorStyle = .none // 셀 사이 경계선 삭제
    $0.register(SavedBookCell.self, forCellReuseIdentifier: SavedBookCell.id)
  }
  
  private enum Section {
    case main
  }
  
  // MARK: dataSource
  private lazy var dataSource = UITableViewDiffableDataSource<Section, Document>(
    // 이 데이터 소스를 어디다가 연결할건지: tableView
    // itemIdentifier가 데이터. snapshot으로 보내준?
    tableView: tableView, cellProvider: { tableView, indexPath, document in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedBookCell.id, for: indexPath) as? SavedBookCell else { return UITableViewCell() }
      cell.configure(document)
      return cell
    }
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTabBarTopBorder() // ViewController+UI
    setupUI()
    setupLayout()
    bind()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.loadSavedBooks()
  }
  
  // MARK: setupUI
  private func setupUI() {
    navigationController?.setNavigationBarHidden(true, animated: false)
    view.backgroundColor = .white
    [topBarView, tableView].forEach { view.addSubview($0) }
  }
  
  // MARK: setupLayout
  private func setupLayout() {
    topBarView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(44)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(topBarView.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: bind
  private func bind() {
    self.viewModel.savedBooks
      .observe(on: MainScheduler.instance)
      .bind(onNext: { [weak self] books in
        var snapshot = NSDiffableDataSourceSnapshot<Section, Document>()
        snapshot.appendSections([.main])
        snapshot.appendItems(books)
        self?.dataSource.apply(snapshot, animatingDifferences: true)
      })
      .disposed(by: disposeBag)
  }
  
}
