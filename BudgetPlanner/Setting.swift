//
//  Setting.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/9/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI
//Setting view
struct Setting: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        Form {
            Group {
                //Toggle for turning on darkmode
                Section(header: Text("DarkMode")) {
                    Toggle(isOn: $userData.darkMode){
                        Image(systemName: "moon.circle.fill")
                            .imageScale(.medium)
                    }
                }
            }
        }   // End of Form
        .navigationBarTitle(Text("Setting"), displayMode: .inline)
        .font(.system(size: 14))
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
