//
//  SavedBooksViewModel.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
//

import RxSwift
import RxCocoa

class SavedBooksViewModel {
  private let disposeBag = DisposeBag()
  private let bookService = BookAPIService()
  
  let savedBooks = BehaviorSubject<[Document]>(value: [])
  
  init() {
    loadSavedBooks()
  }
  
  func loadSavedBooks() {
    let books = CoreDataRepository.shared.fetchBooks()
    savedBooks.onNext(books)
  }
  
  func deleteAllBooks() {
    CoreDataRepository.shared.deleteAllBooks()
    loadSavedBooks()
  }
}
