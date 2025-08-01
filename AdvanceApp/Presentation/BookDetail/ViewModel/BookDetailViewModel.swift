//
//  BookDetailViewModel.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/29/25.
//

class BookDetailViewModel {
  
  func save(document: Document) {
    CoreDataRepository.shared.saveBook(document: document)
  }
}
