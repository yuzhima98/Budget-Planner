//
//  Transaction.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import Foundation
import CoreData
 
/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Song, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Song, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Trip entity public class
public class Transaction: NSManagedObject, Identifiable {
 
    @NSManaged public var id: UUID?
    @NSManaged public var amount: NSNumber?
    @NSManaged public var day: String?
    @NSManaged public var category: String?
    @NSManaged public var importance: NSNumber?
    @NSManaged public var isIncome: NSNumber?
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var month: String?
    @NSManaged public var note: String?
    @NSManaged public var time: String?
    @NSManaged public var year: String?
}
 
extension Transaction {
    /*
     ❎ CoreData FetchRequest in ContentView calls this function
        to get all of the Trip entities in the database
     */
    static func allTransFetchRequest() -> NSFetchRequest<Transaction> {
       
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest() as! NSFetchRequest<Transaction>
       
        // We list the trans in alphabetical order with respect to title
        request.sortDescriptors = [NSSortDescriptor(key: "year", ascending: true), NSSortDescriptor(key: "month", ascending: true), NSSortDescriptor(key: "day", ascending: true)]
       
        return request
    }
}
