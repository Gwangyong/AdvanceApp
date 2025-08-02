//
//  BookList+CoreDataProperties.swift
//  AdvanceApp
//
//  Created by 서광용 on 8/2/25.
//
//

import Foundation
import CoreData


extension BookList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookList> {
        return NSFetchRequest<BookList>(entityName: "BookList")
    }

    @NSManaged public var authors: String?
    @NSManaged public var isbn: String?
    @NSManaged public var price: Int64
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var isRecent: Bool

}

extension BookList : Identifiable {

}
