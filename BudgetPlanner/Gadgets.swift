//
//  Gadgets.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/9/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct Gadgets: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: TipCalculator()){
                    Text("Tip")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .background(Color.orange)
                        .cornerRadius(40)
                }
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle("Gadgets")
    }
}

struct Gadgets_Previews: PreviewProvider {
    static var previews: some View {
        Gadgets()
    }
}
