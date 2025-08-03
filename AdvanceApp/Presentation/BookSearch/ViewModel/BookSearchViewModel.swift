//
//  SearchViewModel.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
//

import RxSwift
import RxCocoa

class BookSearchViewModel {
  private let disposeBag = DisposeBag()
  private let bookService = BookAPIService() // API 호출 인스턴스
  
  // input: 사용자가 입력한 명령어 ViewModel에서 감지해서 동작
  let searchKeyword = PublishSubject<String>()
  
  // output: 결과값 담는 Observable View에서 구독해서 화면을 업데이트. 초기값은 []
  let searchResults = BehaviorRelay<[Document]>(value: [])
  let recentBooks = BehaviorRelay<[Document]>(value: [])
  
  init() {
    bind()
  }
  
  // 검색어 오면 -> API 호출 -> 결과 저장하는 메서드!
  private func bind() {
    // searchKeyword: Observable<String> -> Observable<[Document]>로 변경
    // flatMapLatest: 가장 마지막 요청 결과만 유지하고, 이전은 취소
    searchKeyword.flatMapLatest { [weak self] keyword -> Observable<[Document]> in
      guard let self else { return .just([]) } // self 없다면 빈 배열만 반환
      return self.bookService.searchBooks(keyword: keyword) // keyword 넘겨서 API 호출
    }
    // 변환된 검색 결과를 .bind(of:)를 통해 searchResults에 저장 (VC에서 이 값을 구독중. 자동 UI 업데이트!)
    // BehaviorRelay는 Observable이 아니지만, 내부적으로 Observable처럼 작동할 수 있도록 bind(to:)가 자동으로 변환해줌
    // 즉, .asObservable()을 직접 호출하지 않아도 bind(to:)에서 자동으로 처리가 가능하다 으아!!!!
    .bind(to: searchResults)
    .disposed(by: disposeBag) // 구독 끊기(돈 아끼자..)
  }
  
  // MARK: 최근 본 책 불러오기
  func loadRecentBooks() {
    let books = CoreDataRepository.shared.fetchBooks(BookStatusKey.isRecent.rawValue)
    recentBooks.accept(books) // accept: 새로운 값을 강제로 덮어쓰고, 구독중인 곳에 즉시 반영해줌
  }
  
  // MARK: 최근 본 책 저장
  func saveRecentBook(_ book: Document) {
    CoreDataRepository.shared.save(document: book, isRecent: true)
    loadRecentBooks()
  }

}
