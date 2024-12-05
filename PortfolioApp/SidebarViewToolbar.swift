//
//  SidebarViewToolbar.swift
//  PortfolioApp
//
//  Created by Ozan Özçelik on 5.12.2024.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @State var showingAwards: Bool = false

    var body: some View {
        Button {
            dataController.deleteAll()
        } label: {
            Label("Delete All", systemImage: "trash")
        }

        Button {
            showingAwards.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)

        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("Add Sample Data", systemImage: "plus")
        }
        #endif

        Button(action: dataController.newTag) {
            Label("New Tag", systemImage: "plus")
        }
    }
}

#Preview {
    SidebarViewToolbar()
}
