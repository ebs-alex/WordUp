//
//  DataView.swift
//  WordUp
//
//  Created by Alex Moran on 10/30/23.
//

import SwiftUI

struct DataView: View {
    @EnvironmentObject var dm: DataModel;
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink {
                        Text("Hello, Data!")
                            .navigationTitle("Hello Data")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text("Hello, Data!")
                    }
                    Button {
                        showingResetAlert = true
                    } label: {
                        Text("Reset Data")
                    }
                }
//
//                .padding(10)
//                Spacer()
            }
            .navigationTitle("Data")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
        .alert("This will delete all your data!", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("RESET", role: .destructive) { resetData() }
        }
    }
    func resetData() {
        dm.resetProperties()
    }
}

#Preview {
    DataView()
        .environmentObject(DataModel())
}
