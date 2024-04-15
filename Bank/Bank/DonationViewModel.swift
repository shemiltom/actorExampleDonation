//
//  Bank1.swift
//  Bank
//
//  Created by Shemil Tom on 11/04/24.
//

import Foundation

actor BankAccount {
    private(set) var balance = 0
    
    func deposit() -> Int {
        balance = balance + 100
        return balance
    }
}

@MainActor class DonationViewModel: ObservableObject {
    @Published var balance: String = "0"
    private var bankAccount = BankAccount()
    
    public func receiveDeposits() async {
        bankAccount = BankAccount()
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
    
    public func depositAndDisplay() async {
        let result = await bankAccount.deposit()
        DispatchQueue.main.async {
            self.balance = result.description
        }
    }
}
