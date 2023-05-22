//
//  BudgetDisplayView.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 13.04.2023.
//

import Foundation
import SwiftUI

struct BudgetDisplayView: View {
    @ObservedObject var budget: BudgetModel
    @State private var showingSheet = false
    @State private var expenseAmount = ""
    
    var body: some View {
        ScrollView {
            Color.prestigeBlack
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Financial worries")
                    .font(Font(UIFont(name: "Volkswagen-Medium", size: 45)!))
                    .foregroundColor(.chainGangGrey)
                    .padding(.bottom, 20)
                HStack {
                    Text("Spare cash: ")
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 25)!))
                        .foregroundColor(.riseAndShine)
                    Spacer()
                    Text(String(format: "%.2f ₽", budget.currentMoney))
                        .foregroundColor(.chainGangGrey)
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 25)!))
                }
                .padding(.bottom, 70)
                HStack {
                    Text("Daily salary: ")
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 25)!))
                        .foregroundColor(.riseAndShine)
                    Spacer()
                    Text(String(format: "%.2f ₽", budget.daily))
                        .foregroundColor(.chainGangGrey)
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                }
                .padding(.bottom, 70)
                HStack {
                    Text("Hour salary: ")
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 25)!))
                        .foregroundColor(.riseAndShine)
                    Spacer()
                    Text(String(format: "%.2f ₽", budget.hours))
                        .foregroundColor(.chainGangGrey)
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                }
            }
            .padding()
        }
        .scrollDisabled(true)
        .background(Color.prestigeBlack.edgesIgnoringSafeArea(.all))
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    showingSheet = true
                }) {
                    Text("Expenses ₽")
                        .foregroundColor(Color.prestigeBlack)
                        .font(Font(UIFont(name: "Volkswagen-Medium", size: 35)!))
                        .frame(width: 250, height: 60)
                        .background(Color.riseAndShine)
                        .cornerRadius(20)
                }
                .buttonStyle(ShadowButtonStyle(color: Color.background))
                .padding(.bottom, 160)
                .sheet(isPresented: $showingSheet) {
                    Color.chainGangGrey
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        TextField("Expense amount", text: $expenseAmount)
                            .foregroundColor(.riseAndShine)
                            .font(.system(size: 30))
                            .keyboardType(.numberPad)
                            .padding()
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                        Button("Submit") {
                            if let amount = Double(expenseAmount) {
                                budget.subtractMoney(amount: amount)
                            }
                            showingSheet = false
                        }
                        .frame(width: 150, height: 40)
                        .background(Color.riseAndShine)
                        .cornerRadius(20)
                        .foregroundColor(Color.prestigeBlack)
                        .font(.headline)
                    }
                    .presentationDetents([.fraction(0.2)])
                    .padding()
                    .background(Color.chainGangGrey)
                    .edgesIgnoringSafeArea(.all)
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        budget.updateCurrentMoney()
                        budget.dailySalary()
                        budget.hoursSalary()
                    }
                }
            }
        )
        .ignoresSafeArea(.keyboard)
    }
}



struct BudgetDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDisplayView(budget: BudgetModel())
    }
}
