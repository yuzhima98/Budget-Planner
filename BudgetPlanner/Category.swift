//
//  Category.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/9/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI
//list of all category for a transaction
let category = ["Dining", "Auto&Transport", "Education", "Home", "Bills", "Others","Shopping", "Travel", "Entertainment","Salary", "Gift"]
struct Category: View {
    //current category
    @State private var currCategory = category.first
    //Fetch request from core data
    @FetchRequest(fetchRequest: Transaction.allTransFetchRequest()) var allTrans: FetchedResults<Transaction>
    //progress value for the progressbar
    @State var circleProgress: CGFloat = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                //Scroll view of all the categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(category, id: \.self) { aCategory in
                            Button(action: {
                                //Change the current category
                                self.currCategory = aCategory
                                //Adjust the progress value
                                self.circleProgress = CGFloat(self.totalExpense)/CGFloat(self.totalOverallExpense)
                            }){
                            VStack{
                                Image(aCategory)                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            if (self.currCategory == aCategory){
                                Text(aCategory)
                                    .foregroundColor(Color.red)
                            }else{
                                Text(aCategory)
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
                    }
                                                    .font(.system(size: 14))
                    }   // End of HStack
                }
                .frame(width: UIScreen.main.bounds.width - 20)
                .fixedSize()
               Divider()
                totalAmountText
                .font(.system(size: 20.0))
                   .fontWeight(.bold)
                .foregroundColor(.black)
                formattedCircleProgress
                    .font(.system(size: 12.0))
                    .fontWeight(.medium)
                //Progress Bar
                ProgressBar(circleProgress: $circleProgress, widthAndHeight: CGFloat(150.0))
                    .onAppear {
                        //Make sure to set the circleProgress when it appear
                        //So it does not show the initial value of circleProgress
                        self.circleProgress = CGFloat(self.totalExpense)/CGFloat(self.totalOverallExpense)
                }
                //List of all transactions with designated category
                List {
                    ForEach(self.allTrans.filter{$0.category == currCategory}) { aTrans in
                        NavigationLink(destination: TransactionDetail(trans: aTrans)) {
                            TransactionItem(trans: aTrans)
                        }
                    }
                }   // End of List
            }
            .navigationBarTitle("Category")
        }
    }
    //formatting the circleProgress so that it shows with 2 decimal places
    var formattedCircleProgress : Text {
        let x = circleProgress * 100
        let doubleStr = String(format: "%.2f", x)
        return Text("\(doubleStr)% of total expense")
    }
    //returns the total income as Text
    var totalIncome: Text {
        var total = 0.0
         for item in self.allTrans.filter({$0.category == currCategory}) {
            if ((item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        let doubleStr = String(format: "%.2f", total)
        return Text("Total Income: +$\(doubleStr)")
    }
    //returns the total expense of a category
    var totalExpense: Double {
        var total = 0.0
         for item in self.allTrans.filter({$0.category == currCategory}) {
            if (!(item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        return total
    }
    //returns the overall expense
    var totalOverallExpense: Double {
        var total = 0.0
         for item in self.allTrans {
            if (!(item.isIncome as! Bool)){
             total += item.amount as! Double
            }
        }
        return total
    }
    //returns a text of the total amount
    var totalAmountText: Text {
        var total = 0.0
        for item in self.allTrans.filter({$0.category == currCategory}){
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
}
