//
//  BookList+CoreDataProperties.swift
//  AdvanceApp
//
//  Created by 서광용 on 8/1/25.
//
//

import Foundation
import CoreData


extension BookList {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<BookList> {
    return NSFetchRequest<BookList>(entityName: "BookList")
  }
  
  @NSManaged public var isbn: String?
  @NSManaged public var thumbnail: String?
  @NSManaged public var title: String?
  @NSManaged public var authors: String?
  @NSManaged public var price: Int64
}

extension BookList : Identifiable {
  
}
