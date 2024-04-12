//
//  ContentView.swift
//  Bank
//
//  Created by Shemil Tom on 11/04/24.
//

import SwiftUI

struct DonationView: View {
    @ObservedObject var viewModel = DonationViewModel()
    var body: some View {
        VStack {
            Text("Total balance!")
            Text(viewModel.balance)
            
            Button {
                Task {
                   await viewModel.receiveDeposits()
                }
            } label: {
                Text("donate")
            }
        }
        .padding()
    }
}

#Preview {
    DonationView()
}
