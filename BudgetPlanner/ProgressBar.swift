//
//  ProgressBar.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/10/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    @Binding var circleProgress: CGFloat
    var widthAndHeight: CGFloat
    var labelSize: CGFloat?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                Circle()
                    .trim(from: 0.0, to: self.circleProgress)
                    .stroke(Color.blue, lineWidth: 15)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .animation(.linear)
                    .rotationEffect(Angle(degrees: -90))
                Text("\(Int(self.circleProgress*100))%")
                        .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .frame(width: widthAndHeight, height: widthAndHeight)
    }
}
