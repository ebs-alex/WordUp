//
//  DataView.swift
//  WordUp
//
//  Created by Alex Moran on 10/30/23.
//

import SwiftUI

struct DataView: View {
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
                }
            }
            .navigationTitle("Data")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    DataView()
}
