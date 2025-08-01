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
  
  // MARK: saveBook
  func saveBook(document: Document) {
    guard let context else { return } // context = context
    
    convertToBookList(document, context: context)
    
    do {
      try context.save()
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }
  
  // MARK: fetchBooks
  func fetchBooks() -> [Document] {
    guard let context else { return [] }
    
    // CoreData에서 BookList에 저장된 모든 객체들을 가져옴
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    
    do {
      let result = try context.fetch(fetchRequest)
      return result.map { convertToDocument($0) }
    } catch {
      print("error: \(error.localizedDescription)")
      return []
    }
  }
  
  // MARK: deleteAllBooks
  func deleteAllBooks() {
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    
    do {
      let books = try context?.fetch(fetchRequest)
      
      books?.forEach { context?.delete($0) }
      try context?.save()
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }
  
  // MARK: deleteBook
  func deleteBook(book: BookList) {
    guard let context else {return }
    
    context.delete(book)
    
    do {
      try context.save()
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
  }

  // CoreData 정보 변환 (BookList -> Document)
  func convertToDocument(_ bookList: BookList) -> Document {
    return Document(
      authors: bookList.authors?.components(separatedBy: ", ") ?? [],
      contents: "", // CoreData에 저장하지 않아서 비워둠
      price: Int(bookList.price),
      thumbnail: bookList.thumbnail ?? "",
      title: bookList.title ?? "",
      translators: [] // 안쓰지만..
    )
  }
}
