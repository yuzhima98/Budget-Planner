//
//  ContentView.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/7/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        //Tabview of the required views
        ZStack(alignment: .bottomTrailing) {
            VStack {
                TabView {
                    Home()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    Transactions()
                        .tabItem {
                            Image(systemName: "doc.plaintext")
                            Text("Transactions")
                        }
                    Category()
                        .tabItem {
                            Image(systemName: "rectangle.stack.fill")
                            Text("Category")
                    }
                    Analytics()
                        .tabItem {
                            Image(systemName: "chart.bar")
                            Text("Analytics")
                    }
                }   // End of TabView
                .font(.headline)
                .imageScale(.medium)
                .font(Font.title.weight(.regular))
            }
        }.environment(\.colorScheme, (userData.darkMode ? .dark : .light))
            .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
