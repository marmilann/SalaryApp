//
//  BudgetModel.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 13.04.2023.
//

import Foundation
import SwiftUI
import CoreData

class BudgetModel: ObservableObject {
    
    @Published var salary: Double = 0
    @Published var currentMoney: Double = 0
    @Published var daily: Double = 0
    @Published var hours: Double = 0
    let startTime = Date()
    var timer: Timer?
    
    private let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "BudgetModel")
        self.persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }
        save()
        load()
    }
    
    private func save() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    private func load() {
        let request: NSFetchRequest<Budget> = Budget.fetchRequest()
        let context = persistentContainer.viewContext
        do {
            let budgets = try context.fetch(request)
            if let budget = budgets.first {
                salary = budget.salary
                currentMoney = budget.currentMoney
                daily = budget.daily
                hours = budget.hours
            }
        } catch {
            print("Failed to load context: \(error)")
        }
    }
    
    func updateCurrentMoney() {
        let moneyPerSecond = salary / 30 / 24 / 60 / 60
        currentMoney += moneyPerSecond
        save()
    }
    
    func dailySalary() {
        let moneyPerDay = salary / 30
        daily = moneyPerDay
        save()
    }
    
    func hoursSalary() {
        let moneyPerHour = salary / 30 / 24
        hours = moneyPerHour
        save()
    }
    
    func subtractMoney(amount: Double) {
        currentMoney -= amount
        save()
    }
    
    func reset() {
        currentMoney = 0
        daily = 0
        hours = 0
        salary = 0
        save()
    }
    
}
