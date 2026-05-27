//
//  MatchUser.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation

struct MatchUser: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let company: Company

    struct Address: Codable {
        let city: String
        let street: String
    }

    struct Company: Codable {
        let name: String
    }
}