//
//  ReminderApp.swift
//  Reminder
//
//  Created by Alex Honcharuk on 10.09.2021.
//

import SwiftUI

@main
struct ReminderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CategoryListView()
                .environmentObject(ReminderManager(context: persistenceController.container.viewContext))
        }
    }
}
