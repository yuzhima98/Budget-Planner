//
//  UserData.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/7/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import Combine
import SwiftUI
 
final class UserData: ObservableObject {
 
    /*
     -------------------------------------------
     MARK: - Publisher-Subscriber Design Pattern
     -------------------------------------------
     ===============================================================================
     |                   Publisher-Subscriber Design Pattern                       |
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
    
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
    
     When a change occurs in userData (e.g., deleting a survey from the list, reordering countries list,
     adding a new survey to the list), every View subscribed to it is notified to re-render its View.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     NOTE:  Only Views can subscribe to it. You cannot subscribe to it within
            a non-View Swift file such as our SurveyLoadData.swift file.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    //initial value of darkmode should be false
    @Published var darkMode = false
}
