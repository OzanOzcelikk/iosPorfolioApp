//
//  TagsMenuView.swift
//  PortfolioApp
//
//  Created by Ozan Özçelik on 5.12.2024.
//

import SwiftUI

struct TagsMenuView: View {
    
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var body: some View {
        Menu{
            // show selected tags first
            ForEach(issue.issueTags) { tag in
                Button {
                    issue.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }
            
            // now show unselected tags
            let otherTags = dataController.missingTags(from: issue)
            
            if otherTags.isEmpty == false {
                Divider()
                
                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button(tag.tagName) {
                            issue.addToTags(tag)
                        }
                    }
                }
            }
        } label:{
            Text(issue.issueTagList)
                .multilineTextAlignment(.leading)
                .frame(minWidth: .infinity, alignment: .leading)
                .animation(nil, value: issue.issueTagList)
        }
    }
}
