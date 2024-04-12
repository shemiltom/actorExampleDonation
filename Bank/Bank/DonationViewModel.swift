//
//  Bank1.swift
//  Bank
//
//  Created by Shemil Tom on 11/04/24.
//

import Foundation

actor BankAccount {
    private let iban = "wefwafgwarfgwrf"
    private(set) var balance = 0
    
    func deposit() -> Int {
        balance = balance + 100
        return balance
    }
    
   nonisolated func bankDetails() -> String {
        iban
    }
}

@MainActor class DonationViewModel: ObservableObject {
    @Published var balance: String = "0"
    
    @Published var bankDetails: String = ""
    @Published var areBankDetailsShown = false
    
    @Published var alertTitle = ""
    @Published var isAlertShown = false
    
    private var bankAccount = BankAccount()
    
    init() {
        Task {
            bankDetails = bankAccount.bankDetails()
        }
    }
    
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

        try! await Task.sleep(nanoseconds: 1_000_000_000)
           await self.checkResults()
        
    }
    
    public func depositAndDisplay() async {
        let result = await bankAccount.deposit()
        DispatchQueue.main.async {
            self.balance = result.description
        }
    }
    
    public func checkResults() async {
        let actualBalance = await bankAccount.balance
        let expectedBalance = 2 * 1000 * 100
        let difference = expectedBalance - actualBalance
        
        if difference > 0 {
            alertTitle = "high"
        } else if difference < 0 {
            alertTitle = "loe"
        } else {
            alertTitle = "correct"
        }
        print(actualBalance)
    }
    
    func toggleDetails() {
        areBankDetailsShown = !areBankDetailsShown
    }
}
