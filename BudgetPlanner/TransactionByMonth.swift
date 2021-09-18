//
//  TransactionByMonth.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct TransactionByMonth: View {
    let trans: [Transaction]
    let month: String
    var body: some View {
        HStack {
            monthFormatted
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .frame(width: 120.0, alignment: .leading)
                .foregroundColor(.black)
            totalAmount
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .frame(width: 200, alignment: .leading)
                    .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                // Set font and size for the whole VStack content
        }   // End of HStack
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
    var totalAmount: Text {
        var total = 0.0
         for item in trans {
            if (item.isIncome as! Bool){
             total += item.amount as! Double
            }
            else {
             total -= item.amount as! Double
            }
        }
        let doubleStr = String(format: "%.2f", total)
        if (total > 0.0) {
            return Text("Total: +$\(doubleStr)")
        }
        else{
            return Text("Total: $\(doubleStr)")
        }
    }
    
}
