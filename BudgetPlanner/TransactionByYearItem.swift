//
//  TransactionByYearItem.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct TransactionByYearItem: View {
    let trans: [Transaction]
    let year: String
    var body: some View {
        HStack {
            Text(year)
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
