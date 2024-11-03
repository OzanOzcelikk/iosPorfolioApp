//
//  Filter.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 3.11.2024.
//

import Foundation

struct Filter: Identifiable, Hashable {
    
    var id = UUID()
    var name: String
    var icon: String
    var minModificationDate: Date = Date.distantPast
    var tag: Tag?
    
    static var all = Filter(id: UUID(), name: "All", icon: "tray")
    static var recent = Filter( id: UUID(), name: "Recent issues", icon: "clock", minModificationDate: .now.addingTimeInterval(-7*24*60*60))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
