//
//  AppSalaryApp.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 13.04.2023.
//

import SwiftUI

@main
struct AppSalaryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
