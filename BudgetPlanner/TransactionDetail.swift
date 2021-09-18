//
//  TransactionDetail.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI
import MapKit

struct TransactionDetail: View {
    let trans: Transaction
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        VStack {
            roundedAmount
                .font(.system(size: 50.0))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
            Image(trans.category!)
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: 70.0, height: 70.0)
            Divider()
            formattedDate
                .font(.system(size: 20.0))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
            Divider()
            Text(trans.note!)
            markImportanc
            .padding(20)
            NavigationLink(destination: transLocationOnMap) {
                Text("Show Location of Transaction")
            }
            .padding(20)
        }
    }
    
    var markImportanc: Button<Text> {
        if (trans.importance as! Bool) {
            return Button(action: {
                self.trans.importance = false as NSNumber
                do {
                    try self.managedObjectContext.save()
                } catch {
                    return
                }
            }){
                Text("Unmark")
            }
        }else{
            return Button(action: {
                self.trans.importance = true as NSNumber
                do {
                    try self.managedObjectContext.save()
                } catch {
                    return
                }
            }){
                Text("Mark as Important")
            }
        }
    }
    
    var formattedDate: Text {
        let monthName = DateFormatter().monthSymbols?[(Int(trans.month!) ?? 1) - 1] ?? ""
        return Text("\(monthName) \(trans.day!), \(trans.year!)")
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
    var transLocationOnMap: some View {
        return AnyView(MapView(mapType: MKMapType.standard, latitude: Double(truncating: trans.latitude!),
                               longitude: Double(truncating: trans.longitude!), delta: 15.0, deltaUnit: "degrees",
                               annotationTitle: "Location", annotationSubtitle: "\(trans.month!)/\(trans.day!)/\(trans.year!)")
            .navigationBarTitle(Text(verbatim: "Location"), displayMode: .inline)
                .edgesIgnoringSafeArea(.all) )
    }
}
