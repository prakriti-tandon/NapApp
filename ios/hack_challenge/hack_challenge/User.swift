//
//  User.swift
//  hack_challenge
//
//  Created by David Vizueth on 5/7/23.
//

import Foundation

struct User : Codable {
    
    var id: Int
    var name: String
    var bank_balance: Int
    var dark: Bool
    var quiet: Bool
    var region: String
    var email: String
    var password: String

    
    init(id: Int, name: String, bank_balance: Int, dark: Bool, quiet: Bool, region: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.bank_balance = bank_balance
        self.dark = dark
        self.quiet = quiet
        self.region = region
        self.email = email
        self.password = password

    }
}
