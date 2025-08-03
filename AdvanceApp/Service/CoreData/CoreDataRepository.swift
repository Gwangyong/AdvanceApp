//
//  CoreDataRepository.swift
//  AdvanceApp
//
//  Created by 서광용 on 8/1/25.
//

import UIKit
import CoreData

class CoreDataRepository {
  static let shared = CoreDataRepository()
  
  private init() {}
  
  // AppDelegate 내부에 있는 viewContext를 호출하는 코드
  // CRUD하기 위한 context가 작업 공간 (데이터 만들고 수정 등 하는 임시 저장소)
  private var context: NSManagedObjectContext? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    return appDelegate.persistentContainer.viewContext
  }
  
  // MARK: save
  func save(document: Document, isRecent: Bool = false, isSaved: Bool = false) {
    guard let context else { return }
    
    // 중복 제거
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isbn == %@", document.isbn) // 저장하려는 isbn과 Coredata에 중복 있나 확인
    
    do {
      let matchedBook = try context.fetch(fetchRequest).first
      var updateDocument = document
      updateDocument.isRecent = isRecent || matchedBook?.isRecent ?? false
      updateDocument.isSaved = isSaved || matchedBook?.isSaved ?? false

      // 기존 데이터 삭제
      if let matchedBook {
        context.delete(matchedBook)
      }

      // 변환 후 저장
      convertToBookList(updateDocument, context: context)
      
      try context.save()
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }

  // MARK: fetchBooks
  func fetchBooks(_ status: String) -> [Document] {
    guard let context else { return [] }
    
    // CoreData에서 BookList에 저장된 모든 객체들을 가져옴
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "%K == true", status) // status가 true인 책만
    
    do {
      let result = try context.fetch(fetchRequest)
      return result.map { convertToDocument($0) }
    } catch {
      print("error: \(error.localizedDescription)")
      return []
    }
  }
  
//  // MARK: fetchRecentBooks
//  func fetchRecentBooks() -> [Document] {
//    guard let context else { return [] }
//
//    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
//    fetchRequest.predicate = NSPredicate(format: "isRecent == true")
//
//    do {
//      let result = try context.fetch(fetchRequest)
//      return result.map { convertToDocument($0) } // 변환은 필수!
//    } catch {
//      print("error: \(error.localizedDescription)")
//      return []
//    }
//  }
  
  // MARK: deleteAllBooks
  func deleteAllBooks() {
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isSaved == true")
    
    do {
      let books = try context?.fetch(fetchRequest)
      
      books?.forEach { context?.delete($0) }
      try context?.save()
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }
  
  // MARK: deleteBook
  func deleteBook(_ document: Document) {
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isbn == %@", document.isbn)
    
    do {
      // .first가 nil을 반환하니 if let 사용
      if let book = try context?.fetch(fetchRequest).first { // 조건에 맞는 것 중 하나만 (중복 있을 수 있으니)
        context?.delete(book)
        try context?.save()
      }
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }
}


private extension CoreDataRepository {
  // API 받은 정보 CoreData에 맞도록 변환 (Document -> BookList)
  func convertToBookList(_ document: Document, context: NSManagedObjectContext) {
    let book = BookList(context: context)
    book.title = document.title
    book.thumbnail = document.thumbnail
    book.authors = document.authors.joined(separator: ", ")
    book.price = Int64(document.price)
    book.isbn = document.isbn
    book.isRecent = document.isRecent ?? false
    book.isSaved = document.isSaved ?? false
  }

  // CoreData 정보 변환 (BookList -> Document)
  func convertToDocument(_ bookList: BookList) -> Document {
    return Document(
      isbn: bookList.isbn ?? "",
      authors: bookList.authors?.components(separatedBy: ", ") ?? [],
      contents: "", // CoreData에 저장하지 않아서 비워둠
      price: Int(bookList.price),
      thumbnail: bookList.thumbnail ?? "",
      title: bookList.title ?? "",
      translators: [], // 안쓰지만..
      isRecent: bookList.isRecent,
      isSaved: bookList.isSaved
    )
  }
}
