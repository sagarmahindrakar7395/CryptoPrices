//
//  NetworkManager.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//


import Foundation
import Combine

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCoins() -> AnyPublisher<[Coin], Error> {
        guard let url = URL(string:
            "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false"
        ) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let http = response as? HTTPURLResponse,
                      (200...299).contains(http.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}