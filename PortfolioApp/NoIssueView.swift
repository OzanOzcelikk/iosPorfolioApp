//
//  NoIssueView.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 4.11.2024.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    
    var body: some View {
    Text("No issues Selected")
            .font(.title)
            .foregroundColor(.secondary)
        
        Button("New Issue") {
            //make a new issue
        }
            
    }
}

#Preview {
    NoIssueView()
}
