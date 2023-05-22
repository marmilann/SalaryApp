//
//  BudgetSettingsView.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 13.04.2023.
//

import SwiftUI

struct BudgetSettingsView: View {
    @ObservedObject var budget: BudgetModel
    @State private var salaryString = ""
    @State private var text: String = "000.. ₽"
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Color.prestigeBlack
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Settings")
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 45)!))
                        .foregroundColor(.chainGangGrey)
                        .padding(.bottom, 30)
                    HStack {
                        Text("Enter you new salary:")
                            .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                            .foregroundColor(.riseAndShine)
                            .padding(.trailing, 75)
                    }
                    HStack {
                        TextField(text, text: $salaryString)
                            .foregroundColor(.riseAndShine)
                            .font(Font(UIFont(name: "Volkswagen-Medium", size: 75)!))
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 50)
                            .padding(.bottom, 310)
                    }
                    .overlay(
                        VStack {
                            Spacer()
                            Button(action: {
                                if let salary = Double(salaryString) {
                                    budget.salary = salary
                                    salaryString = ""
                                }
                            }) {
                                Text("Save")
                                    .foregroundColor(.prestigeBlack)
                                    .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                                    .padding()
                                    .frame(width: 250, height: 60)
                                    .background(Color.riseAndShine)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(ShadowButtonStyle(color: .riseAndShine))
                            .padding(.bottom, 25)
                            Button(action: {
                                budget.reset()
                            }) {
                                Text("Reset")
                                    .foregroundColor(.red)
                                    .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                                    .padding()
                                    .frame(width: 250, height: 60)
                                    .background(Color.riseAndShine)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(ShadowButtonStyle(color: .riseAndShine))
                        }
                            .padding(.top, 470 - keyboardHeight)
                    )
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
                        keyboardHeight = keyboardSize.height - geo.safeAreaInsets.bottom
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        keyboardHeight = 0
                    }
                }
                .padding()
            }
            .scrollDisabled(true)
            .background(Color.prestigeBlack.edgesIgnoringSafeArea(.all))
            .onTapGesture {
                self.dismissKeyboard()
            }
            
        }
    }
}

struct BudgetSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingsView(budget: BudgetModel())
    }
}
