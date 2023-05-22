//
//  BudgetInputView.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 13.04.2023.
//

import SwiftUI

struct BudgetInputView: View {
    @ObservedObject var viewModel: BudgetModel
    @State private var salaryString: String = ""
    @State private var showError: Bool = false
    @State private var text: String = "000.. ₽"
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Color.prestigeBlack
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Your monthly salary")
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 45)!))
                        .foregroundColor(.chainGangGrey)
                        .padding(.bottom, 200)
                    HStack {
                        TextField(text, text: $salaryString)
                            .foregroundColor(.riseAndShine)
                            .font(Font(UIFont(name: "Volkswagen-Medium", size: 75)!))
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 345, height: 50)
                            .padding(.bottom, 110)
                    }
                    .overlay(
                        VStack {
                            Spacer()
                            Button(action: {
                                if let salary = Double(salaryString) {
                                    viewModel.salary = salary
                                    salaryString = ""
                                } else {
                                    showError = true
                                }
                            }) {
                                Text("Confirm")
                                    .foregroundColor(.prestigeBlack)
                                    .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                                    .frame(width: 250, height: 60)
                                    .background(Color.riseAndShine)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(ShadowButtonStyle(color: .riseAndShine))
                            .padding(.top, 450 - keyboardHeight)
                        }
                    )
                    
                    if showError {
                        Text("Please, enter your salary correctly!")
                            .foregroundColor(.red)
                            .padding(.top, 30)
                    }
                }
                .padding()
            }
            .scrollDisabled(true)
            .background(Color.prestigeBlack.edgesIgnoringSafeArea(.all))
            .onTapGesture {
                self.dismissKeyboard()
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
        }
    }
}


struct BudgetInputView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetInputView(viewModel: BudgetModel())
    }
}
