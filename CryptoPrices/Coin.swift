//
//  Coin.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//


struct Coin: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let current_price: Double
}