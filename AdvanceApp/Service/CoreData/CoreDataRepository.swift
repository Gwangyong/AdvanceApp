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
  func saveBook(title: String, thumbnail: String, authors: String, price: Int) {
    guard let context else { return } // context = context
    
    let book = BookList(context: context)
    book.title = title
    book.thumbnail = thumbnail
    book.authors = authors
    book.price = Int64(price)
    
    do {
      try context.save()
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }
  
  // MARK: fetchBooks
  func fetchBooks() -> [BookList] {
    guard let context else { return [] }
    
    // CoreData에서 BookList에 저장된 모든 객체들을 가져옴
    let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
    
    do {
      return try context.fetch(fetchRequest)
    } catch {
      print("error: \(error.localizedDescription)")
      return []
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


