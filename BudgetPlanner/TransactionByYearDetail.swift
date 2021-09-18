//
//  TransactionByYearDetail.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct TransactionByYearDetail: View {
    let trans: [Transaction]
    let year: String
    let monthList = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    
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
                ForEach(self.monthList, id: \.self) { aMonth in
                        NavigationLink(destination: TransactionByMonthDetail(trans: self.trans.filter{$0.month == aMonth}, month: aMonth)) {
                                    TransactionByMonth(trans: self.trans.filter{$0.month == aMonth}, month: aMonth)
                        }
                }
            }
        }
        .navigationBarTitle(year)
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
