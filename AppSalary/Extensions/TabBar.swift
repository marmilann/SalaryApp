//
//  TabBar.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 15.04.2023.
//

import Foundation
import SwiftUI

struct TabbarButton: View {
    public var image: String
    public var selectedTabBar: String
    public var reader: GeometryProxy
    public var xOffSet: CGFloat = 0
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("cash")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(selectedTabBar == image ? Color.prestigeBlack : Color.lynxWhite)
                .padding(selectedTabBar == image ? 15 : 0)
                .background(Color.riseAndShine.opacity(selectedTabBar == image ? 1 : 0)
                .clipShape(Circle()))
                .shadow(color: Color.darkShadow, radius: 2, x: 2, y: 2)
                .shadow(color: Color.darkShadow, radius: 2, x: -2, y: -2)
                .offset(x: selectedTabBar == image ? (reader.frame(in: .global).minX-reader.frame(in: .global).midX) : 0, y: selectedTabBar == image ? -50 : 0)
        }
    }
}

struct CustomShape : Shape {
    
    var xOffSet : CGFloat
    
    func path(in rect: CGRect) -> Path {
       
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        let center = xOffSet - 3
        path.move(to: CGPoint(x: center-50, y: 0))
        
        let value1: CGFloat = 25
        let value2: CGFloat = 35
      
        let pt1_1 = CGPoint(x: center - value1, y: 0.0)
        let pt2_1 = CGPoint(x: center - value1, y: value2)
        path.addCurve(to:  CGPoint(x: center, y: value2), controlPoint1: pt1_1, controlPoint2: pt2_1)
        
        let pt1_2 = CGPoint(x: center + value1, y: value2)
        let pt2_2 = CGPoint(x: center + value1, y: 0)
        path.addCurve(to: CGPoint(x: center + 50, y: 0), controlPoint1: pt1_2, controlPoint2: pt2_2)
        
        return Path(path.cgPath)

    }
}
