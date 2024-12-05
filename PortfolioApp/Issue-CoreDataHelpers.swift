//
//  Issue-CoreDataHelpers.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 3.11.2024.
//

import Foundation

extension Issue {
    var issueTitle: String {
        get { title ?? "" }
        set { title = newValue }
    }

    var issueContent: String {
        get { content ?? "" }
        set { content = newValue }
    }

    var issueCreationDate: Date {
        creationDate ?? Date()
    }

    var issueModificationDate: Date {
        modificationDate ?? Date()
    }

    var issueTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }

    var issueTagList: String {
        guard issueTags.count > 0 else { return "No Tags" }

        return issueTags.map(\.tagName).joined(separator: ", ")
    }

    var issueStatus: String {
        completed ? "Closed" : "Open"
    }

    var issueFormattedCreationDate: String {
        issueCreationDate.formatted(date: .numeric, time: .omitted)
    }

    static var example: Issue {
        let controller = DataController(inMemory: false)
        let viewContext = controller.container.viewContext

        let issue = Issue(context: viewContext)

        issue.title = "Example Issue"
        issue.content = "This is an example issue."
        issue.priority = 2
        issue.creationDate = Date.now
        return issue
    }
}

extension Issue: Comparable {
    public static func < (lhs: Issue, rhs: Issue) -> Bool {
        let left = lhs.issueTitle.localizedLowercase
        let right = rhs.issueTitle.localizedLowercase

        if left == right {
            return lhs.issueCreationDate < rhs.issueCreationDate
        } else {
            return left < right
        }

    }

}
