//
//  AwardsView.swift
//  PortfolioApp
//
//  Created by Ozan Özçelik on 30.11.2024.
//

import SwiftUI

struct AwardsView: View {

    @EnvironmentObject var dataController: DataController

    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(Award.allAwards) { award in
                            Button {
                                selectedAward = award
                                showingAwardDetails = true
                            } label: {
                                Image(systemName: award.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(color(for: award))
                            }
                            .accessibilityLabel(label(for: award))
                            .accessibilityHint(award.description)
                        }
                    }
                }
                .navigationTitle("Awards")
            }
            .alert(awardTitle, isPresented: $showingAwardDetails) {
            } message: {
                Text(selectedAward.description)
            }
    }

    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5)
    }

    func label(for award: Award) -> LocalizedStringKey {
        dataController.hasEarned(award: award) ? "Unlocked: \(award.name)" : "Locked"
    }

    var awardTitle: String {
        if dataController.hasEarned(award: selectedAward) {
            return "Unlocked: \(selectedAward.name)"
        } else {
            return "Locked"
        }
    }
}

#Preview {
    AwardsView()
}
