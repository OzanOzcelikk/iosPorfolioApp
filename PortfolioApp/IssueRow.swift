//
//  IssueRow.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 4.11.2024.
//

import SwiftUI

struct IssueRow: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        NavigationLink(value: issue) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(issue.priority == 2 ? 1 : 0)

                VStack(alignment: .leading) {
                    Text(issue.issueTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(issue.issueTagList)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(issue.issueFormattedCreationDate)
                        .accessibilityLabel(issue.issueCreationDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)

                    if issue.completed {
                        Text("CLOSED")
                            .font(.body.smallCaps())
                    }
                }
                .foregroundStyle(.secondary)
            }
        }
        .accessibilityHint(issue.priority == 2 ? "High priority" : "")
    }
}

#Preview {
    IssueRow(issue: Issue.example)
}
