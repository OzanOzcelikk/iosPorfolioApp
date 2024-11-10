//
//  DetailView.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 2.11.2024.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        VStack {
            if let issue = dataController.selectedIssue {
                IssueView(issue: issue)
            } else {
                NoIssueView()
            }
        }
        .navigationTitle("Issue Details")
        .navigationBarTitleDisplayMode(.inline)
                
    }
}

#Preview {
    DetailView()
}
