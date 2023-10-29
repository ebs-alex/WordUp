//
//  SettingsView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Text("Settings")
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.large)
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    SettingsView()
}
