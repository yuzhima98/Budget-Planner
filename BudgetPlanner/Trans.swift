//
//  Trans.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import Foundation
struct Trans: Codable {
    var id: UUID
    var amount: Double
    var category: String
    var note: String
    var importance: Bool
    var latitude: Double
    var longitude: Double
    var isIncome: Bool
    var year: String
    var month: String
    var day: String
    var time: String
}

//{
//    "id": "C3669385-C69D-473B-A273-FEE011BDEF49",
//    "amount": 100.05,
//    "category": "Dining",
//    "note": "Hang out with friends",
//    "importance": false,
//    "latitude": 37.334398,
//    "longitude": -122.010837,
//    "isIncome": false,
//    "year": "2017",
//    "month": "11",
//    "day": "5",
//    "time": "11:45"
//},
