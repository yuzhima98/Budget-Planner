//
//  FloatingMenu.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct FloatingMenu: View {
    //all menu items initialized as false so it doesn't show
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    var body: some View {
            VStack {
                Spacer()
                //First menu item
                if showMenuItem1 {
                    NavigationLink(destination: AddTransaction()) {
                        MenuItem(icon: "plus")
                    }
                }
                //Second menu item
                if showMenuItem2 {
                    NavigationLink(destination: Setting()) {
                        MenuItem(icon: "pencil.circle.fill")
                    }
                }
                //third menu item
                if showMenuItem3 {
                    NavigationLink(destination: Gadgets()) {
                        MenuItem(icon: "square.split.2x2")
                    }
                }
                //Button to show the menu
                Button(action: {
                    //Click to show the menu
                    self.showMenu()
                }) {
                    (showMenuItem1 ? Image(systemName: "chevron.down.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1) : Image(systemName: "chevron.up.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1))
                }
            }
    }
    
    func showMenu() {
        //Show the menu item with animation
        //MenuItem 3 will show immediately
        withAnimation {
            self.showMenuItem3.toggle()
        }
        //MenuItem 2 will show after menu item 3 with the DispatchQueue.main.asyncAfter
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        //MenuItem 1 will show after menu item 2 with the DispatchQueue.main.asyncAfter
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}

struct MenuItem: View {
    //UI of the menu item
    var icon: String
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                .frame(width: 55, height: 55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            //Animation transition
        .transition(.move(edge: .trailing))
    }
}
