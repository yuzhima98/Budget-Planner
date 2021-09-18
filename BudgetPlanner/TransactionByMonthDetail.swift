//
//  TransactionByMonthDetail.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct TransactionByMonthDetail: View {
    let trans: [Transaction]
    let month: String
    var body: some View {
            VStack {
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
                List {
                 ForEach(self.trans) { aTrans in
                        NavigationLink(destination: TransactionDetail(trans: aTrans)) {
                            TransactionItem(trans: aTrans)
                        }
                    }
                }   // End of List
            }
            .navigationBarTitle(monthFormatted)
    }
    var totalAmount: Text {
        var total = 0.0
         for item in self.trans {
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
    var monthFormatted: Text {
        if (month == "01"){
            return Text("January")
        }
        else if (month == "02"){
            return Text("Febuary")
        }
        else if (month == "03"){
            return Text("March")
        }
        else if (month == "04"){
            return Text("April")
        }
        else if (month == "05"){
            return Text("May")
        }
        else if (month == "06"){
            return Text("June")
        }
        else if (month == "07"){
            return Text("July")
        }
        else if (month == "08"){
            return Text("August")
        }
        else if (month == "09"){
            return Text("September")
        }
        else if (month == "10"){
            return Text("October")
        }
        else if (month == "11"){
            return Text("November")
        }
        else {
            return Text("December")
        }
    }
    
    var totalExpense: Text {
        var total = 0.0
         for item in self.trans {
            if (!(item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        let doubleStr = String(format: "%.2f", total)
        return Text("Total Expense: -$\(doubleStr)")
    }
    var totalIncome: Text {
        var total = 0.0
         for item in self.trans {
            if ((item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        let doubleStr = String(format: "%.2f", total)
        return Text("Total Income: +$\(doubleStr)")
    }
}
