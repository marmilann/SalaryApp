//
//  TextFieldStyles.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 14.04.2023.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    @State var icon: Image?
    private let height: CGFloat = 25
    private let width: CGFloat = 300
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(UIColor.black))
            }
            configuration
        }
        .frame(width: width, height: height)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(UIColor.darkGray), lineWidth: 2)
        }
    }
}
