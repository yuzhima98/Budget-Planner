//
//  TipCalculator.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/9/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct TipCalculator: View {
    @State private var amount = ""
    @State private var sliderValue = 15.0
    @State private var tipAmount = 0.0
    @State private var split = 1.0
    var body: some View {
        Form {
            Section(header: Text("Amount of Bill")) {
                TextField("Enter the total bill", text: $amount)
            }
            Section(header: Text("Tip%")) {
                VStack{
                    Text("\(String(sliderValue))%")
                    HStack {
                        Text("0%")
                        // Slider: Part 2 of 2
                        Slider(value: $sliderValue, in: 0.0...30.0, step: 1.0)
                            .frame(width: UIScreen.main.bounds.width - 130)
                        Text("30%")
                    }
                }
            }
            Section(header: Text("Number of people to split")) {
                VStack{
                    Text("\(String(split))")
                    HStack {
                        Text("0")
                        // Slider: Part 2 of 2
                        Slider(value: $split, in: 1.0...20.0, step: 1.0)
                            .frame(width: UIScreen.main.bounds.width - 100)
                        Text("20")
                    }
                }
            }
            Section(header: Text("Tip Amount")) {
                calculateTip
            }
            Section(header: Text("Total Amount")) {
                calculateTotal
            }
            Section(header: Text("The Splited Amount")) {
                calculateSplited
            }
        }   // End of Form
        .navigationBarTitle(Text("Tip Calculator"), displayMode: .automatic)
    }
    
    var calculateTip : Text {
        let x = Double(amount)
        let res = (x ?? 0.0) * (sliderValue / 100)
        let doubleStr = String(format: "%.2f", res)
        return Text("The Tip amount is: $\(doubleStr)")
    }
    var calculateTotal : Text {
        let x = Double(amount)
        let res = (x ?? 0.0) * (sliderValue / 100)
        let total = res + (x ?? 0.0)
        let doubleStr = String(format: "%.2f", total)
        return Text("The Total amount is: $\(doubleStr)")
    }
    
    var calculateSplited : Text {
        let x = Double(amount)
        let res = (x ?? 0.0) * (sliderValue / 100)
        let total = res + (x ?? 0.0)
        let splitedAmount = total / split
        let doubleStr = String(format: "%.2f", splitedAmount)
        return Text("The Splited amount is: $\(doubleStr)")
    }
}

struct TipCalculator_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculator()
    }
}
