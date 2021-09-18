//
//  TransactionItem.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct TransactionItem: View {
    let trans: Transaction
    var body: some View {
        HStack {
            Image(trans.category!)
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: 40.0, height: 40.0)
            //Other details
                Text("\(trans.month!)/\(trans.day!)/\(trans.year!)")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .frame(width: 120.0, alignment: .leading)
                    .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                roundedAmount
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .frame(width: 120.0, alignment: .leading)
                    .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                // Set font and size for the whole VStack content
            important
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25.0)
                .foregroundColor(.yellow)
                .padding(.leading, 10)
        }   // End of HStack
    }
    
    var important: Image {
        if (trans.importance as! Bool){
            return Image(systemName: "star.fill")
        }else{
            return Image(systemName: "xxx")
        }
    }
    
    var roundedAmount: Text {
        let doubleStr = String(format: "%.2f", trans.amount as! Double)
        if (trans.isIncome as! Bool) {
            return Text("+$\(doubleStr)")
        }
        else{
            return Text("-$\(doubleStr)")
        }
    }
    
}
