//
//  AddTransaction.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct AddTransaction: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var pickerSelectedIndex = 0
    @State private var pickerSelectedIndex1 = 0
    @State private var date = Date()
    @State private var amount = ""
    @State private var notes = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    let pickerSelectionList = ["Income", "Expense"]
    let pickerSelectionList1 = ["Dining", "Auto&Transport", "Education", "Home", "Bills", "Others","Shopping", "Travel", "Entertainment","Salary", "Gift"]
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 20 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
       
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }
    
    var body: some View {
        Form {
            Section(header: Text("Type of Transaction")) {
                Picker("Sort transaction", selection: $pickerSelectedIndex) {
                    ForEach(0 ..< pickerSelectionList.count) {
                        index in
                        Text(self.pickerSelectionList[index])
                        .tag(index)
                            .foregroundColor(.blue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Amount")) {
                TextField("Enter the amount", text: $amount)
            }
            Section(header: Text("Category")) {
                Picker("Category", selection: $pickerSelectedIndex1) {
                    ForEach(0 ..< pickerSelectionList1.count) {
                        index in
                        HStack{
                        Text(self.pickerSelectionList1[index])
                        .tag(index)
                        }
                    }
                }
            }
            Section(header: Text("Notes")) {
                TextField("Enter the notes", text: $notes)
            }
            Section(header: Text("Date")) {
                DatePicker(
                    selection: $date,
                    in: dateClosedRange,
                    displayedComponents: .date,
                    label: { Text("Date") }
                )
            }
        }   // End of Form
            .alert(isPresented: $showAlert, content: { self.alert })
               .navigationBarTitle(Text("Add Transaction"), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.saveNewTransaction()
                }) {
                    Text("Save")
                })
        }   // End of body
    
    var alert: Alert {
        if self.amount.isEmpty {
            return Alert(title: Text("Amount is missing"),
            message: Text("You need to enter the amount for the transaction"),
            dismissButton: .default(Text("Okay")) )
        }else{
            return Alert(title: Text("Success"),
            message: Text("You have saved the transaction!"),
            dismissButton: .default(Text("Okay")) )
        }
    }
    func saveNewTransaction() {

        // Input Data Validation
        if self.amount.isEmpty {
            showAlert = true
            return
        }

        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()

        // Set the date format to yyyy-MM-dd
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        // ❎ Create a new Trip entity in CoreData managedObjectContext
        let newTrans = Transaction(context: self.managedObjectContext)

        // ❎ Dress up the new Trip entity
        newTrans.amount = Double(self.amount)! as NSNumber
        newTrans.category = self.pickerSelectionList1[pickerSelectedIndex1]
        newTrans.day = day
        newTrans.id = UUID()
        newTrans.importance = false
        var income = false
        if (self.pickerSelectionList[pickerSelectedIndex] == "Income"){
            income = true
        }else{
            income = false
        }
        newTrans.isIncome = income as NSNumber
        let transLocation = currentLocation()
        newTrans.latitude = transLocation.latitude as NSNumber
        print(newTrans.latitude as! Double)
        newTrans.longitude = transLocation.longitude as NSNumber
        print(newTrans.longitude as! Double)
        newTrans.month = month
        newTrans.note = self.notes
        newTrans.time = time
        newTrans.year = year

        // ❎ CoreData Save operation
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
        self.showAlert = true
        self.presentationMode.wrappedValue.dismiss()
    }
}
