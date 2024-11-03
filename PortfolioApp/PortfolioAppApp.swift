//
//  PortfolioAppApp.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 31.10.2024.
//

import SwiftUI

@main
struct PortfolioAppApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView{
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
