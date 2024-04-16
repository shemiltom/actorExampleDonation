//
//  ContentView.swift
//  Bank
//
//  Created by Shemil Tom on 11/04/24.
//

import SwiftUI

struct DonationView: View {
    
    /// viewmodel as onbervedobject
    @ObservedObject var viewModel = DonationViewModel()
    var body: some View {
        VStack {
            Text("Total balance")
                .bold()
                .padding()
            Text(viewModel.balance)
                .font(.title)
                .bold()
                .padding()
            //Button to receive  deposit
            Button {
                Task {
                    await viewModel.receiveDeposits()
                }
            } label: {
                Text("donate")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 40)
                    .background(.blue)
                    .cornerRadius(9.0)
                
            }
        }
        .padding()
    }
}

#Preview {
    DonationView()
}
