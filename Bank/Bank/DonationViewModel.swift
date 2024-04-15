//
//  Bank1.swift
//  Bank
//
//  Created by Shemil Tom on 11/04/24.
//

import Foundation

/// ViewModel for the Donation
@MainActor class DonationViewModel: ObservableObject {
    /// To show the balance of the account
    @Published var balance: String = "0"
    /// Instance of the bank account
    private var bankAccount = BankAccount()
    
    /// Function to recevice deposit which iterate over 1000 times
    public func receiveDeposits() async {
        balance = await bankAccount.balance.description

        for _ in 1...1000 {
            /// 1. Global queue
            DispatchQueue.global().async {
                Task{
                   await self.depositAndDisplay()
                }
            }
            /// 2. Main Queue
                await  depositAndDisplay()
        }
    }
    
    ///To deposit and display the amount in the bank account
    public func depositAndDisplay() async {
        let result = await bankAccount.deposit()
        DispatchQueue.main.async {
            self.balance = result.description
        }
    }
}
