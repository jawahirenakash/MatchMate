//
//  MatchUser.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Foundation

struct MatchUser: Codable, Identifiable, Sendable {
    let id: Int
    let name: String
    let email: String
    let address: Address
    let company: Company

    struct Address: Codable, Sendable {
        let city: String
        let street: String
    }

    struct Company: Codable, Sendable {
        let name: String
    }
}