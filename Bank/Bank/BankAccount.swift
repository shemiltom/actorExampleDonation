//
//  BankAccount.swift
//  Bank
//
//  Created by Shemil Tom on 15/04/24.
//

import Foundation

/// Actor bankaccount to avoid multiple thread access at the same time
actor BankAccount {
    private(set) var balance = 0
    
    /// Deposit 100 amount at each time
    /// - Returns: The Balance of the acount
    func deposit() -> Int {
        balance = balance + 100
        return balance
    }
}
