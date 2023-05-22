//
//  ButtonStyle.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 26.04.2023.
//

import Foundation
import SwiftUI

struct AnimatedButtonStyle: ButtonStyle {
    let imageName: String
    let title: String
    let warning: Bool
    func makeBody(configuration: Self.Configuration) -> some View {
        if warning == false {
            HStack {
                Image(systemName: imageName)
                Text(title)
                    .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
            }
            .frame(width: 300, height: 60)
            .background(!configuration.isPressed ?
                        Color.riseAndShine:
                            Color.chainGangGrey)
            .foregroundColor(!configuration.isPressed ? .prestigeBlack : .white)
            .cornerRadius(20)
        } else {
            HStack {
                Image(systemName: imageName)
                Text(title)
                    .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
            }
            .frame(width: 300, height: 60)
            .background(!configuration.isPressed ?
                        Color.riseAndShine:
                            Color.chainGangGrey)
            .foregroundColor(!configuration.isPressed ? .red : .white)
            .cornerRadius(20)
        }
    }
}

struct ShadowButtonStyle: ButtonStyle {
    var color: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color.background)
            .cornerRadius(20)
            .shadow(color: Color.darkShadow, radius: 2, x: 2, y: 2)
            .shadow(color: Color.darkShadow, radius: 2, x: -2, y: -2)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
