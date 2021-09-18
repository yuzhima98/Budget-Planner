//
//  Transaction.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/7/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct Transactions: View {
      
       // ❎ CoreData managedObjectContext reference
       @Environment(\.managedObjectContext) var managedObjectContext
      
       // ❎ CoreData FetchRequest returning all Trip entities in the database
       @FetchRequest(fetchRequest: Transaction.allTransFetchRequest()) var allTrans: FetchedResults<Transaction>
       @State private var pickerSelectedIndex = 0
       let pickerSelectionList = ["Daily", "Monthly/Yearly"]
       let monthList = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
       var body: some View {
           NavigationView {
            if self.allTrans.count == 0 {
                // If the database is empty, ask the user to populate it.
                Button(action: {
                    self.addInitialContentToDatabase()
                }) {
                    HStack {
                        Image(systemName: "gear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Populate Database")
                    }
                }
            }
            ZStack (alignment: .bottomTrailing){
                VStack {
                   HStack(spacing: 20){
                       Picker("Sort transaction", selection: $pickerSelectedIndex) {
                           ForEach(0 ..< pickerSelectionList.count) {
                               index in
                               Text(self.pickerSelectionList[index])
                               .tag(index)
                                   .foregroundColor(.blue)
                           }
                       }.pickerStyle(SegmentedPickerStyle())
                   }
                   Divider()
                   totalAmount
                       .font(.system(size: 20.0))
                       .fontWeight(.bold)
                    .foregroundColor(.black)
                   totalExpense
                    .font(.system(size: 12.0))
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    totalIncome
                    .font(.system(size: 12.0))
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                   Divider()
                    if (pickerSelectionList[pickerSelectedIndex] == "Daily"){
                       List {
                        ForEach(self.allTrans) { aTrans in
                               NavigationLink(destination: TransactionDetail(trans: aTrans)) {
                                   TransactionItem(trans: aTrans)
                               }
                           }
                           .onDelete(perform: delete)
                          
                       }   // End of List
                    }
                    else if (pickerSelectionList[pickerSelectedIndex] == "Monthly/Yearly"){
                        List {
                            ForEach(yearList, id: \.self) { aYear in
                                NavigationLink(destination: TransactionByYearDetail(trans: self.allTrans.filter{$0.year == aYear}, year: aYear)) {
                                    TransactionByYearItem(trans: self.allTrans.filter{$0.year == aYear}, year: aYear)
                                }
                            }
                        }   // End of List
                    }
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                FloatingMenu()
                    .padding(.all, 50.0)
                .navigationBarTitle(Text("Transactions"), displayMode: .automatic)
                   // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton())
                }
           }   // End of NavigationView
       }
      
       /*
        ----------------------------
        MARK: - Delete Selected Trip
        ----------------------------
        */
       func delete(at offsets: IndexSet) {
           let transToDelete = self.allTrans[offsets.first!]
          
           // ❎ CoreData Delete operation
           self.managedObjectContext.delete(transToDelete)
    
           // ❎ CoreData Save operation
           do {
             try self.managedObjectContext.save()
           } catch {
             print("Unable to delete selected transaction!")
           }
       }
      
       /*
        ---------------------------------------
        MARK: - Add Initial Content to Database
        ---------------------------------------
        */
       func addInitialContentToDatabase() {
           // This public function is given in LoadInitialContentData.swift
           loadInitialDatabaseContent()
           for aTranss in listOfTrans {
               // ❎ Create a Trip entity in CoreData managedObjectContext
               let aTran = Transaction(context: self.managedObjectContext)
//                struct Trans: Codable {
//                    var id: UUID
//                    var amount: Double
//                    var category: String
//                    var note: String
//                    var importance: Bool
//                    var latitude: Double
//                    var longitude: Double
//                    var isIncome: Bool
//                    var year: String
//                    var month: String
//                    var day: String
//                    var time: String
//                }
               // ❎ Dress up the Trip entity
               aTran.id = aTranss.id
               aTran.amount = aTranss.amount as NSNumber
                aTran.category = aTranss.category
                aTran.note = aTranss.note
                aTran.importance = aTranss.importance as NSNumber as NSNumber
                aTran.latitude = aTranss.latitude as NSNumber
                aTran.longitude = aTranss.longitude as NSNumber
                aTran.isIncome = aTranss.isIncome as NSNumber as NSNumber
                aTran.year = aTranss.year
                aTran.month = aTranss.month
                aTran.day = aTranss.day
                aTran.time = aTranss.time
              
               // ❎ CoreData Save operation
               do {
                   try self.managedObjectContext.save()
               } catch {
                   return
               }
           }   // End of for loop
       }
    
    var totalExpense: Text {
        var total = 0.0
         for item in self.allTrans {
            if (!(item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        let doubleStr = String(format: "%.2f", total)
        return Text("Total Expense: -$\(doubleStr)")
    }
    var totalIncome: Text {
        var total = 0.0
         for item in self.allTrans {
            if ((item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        let doubleStr = String(format: "%.2f", total)
        return Text("Total Income: +$\(doubleStr)")
    }
       var totalAmount: Text {
           var total = 0.0
            for item in self.allTrans {
               if (item.isIncome as! Bool){
                total += item.amount as! Double
               }
               else {
                total -= item.amount as! Double
               }
           }
           let doubleStr = String(format: "%.2f", total)
           if (total > 0.0) {
               return Text("Total Amount: +$\(doubleStr)")
           }
           else{
               return Text("Total Amount: $\(doubleStr)")
           }
       }
    
    var yearList: Array<String> {
        var years : [String] = []
        for aTrans in allTrans {
            if (!years.contains(aTrans.year!)){
                years.append(aTrans.year!)
            }
        }
        print(years)
        return years
    }
    
}

struct Transactions_Previews: PreviewProvider {
    static var previews: some View {
        Transactions()
    }
}
