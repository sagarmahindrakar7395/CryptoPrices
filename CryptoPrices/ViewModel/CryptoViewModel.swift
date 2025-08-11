//
//  CryptoViewModel.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//

import SwiftUI
import Combine

final class CryptoViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var watchlist: Set<String> = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let watchlistKey = "watchlist"
    
    var filteredCoins: [Coin] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return coins
        } else {
            return coins.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.symbol.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var watchlistCoins: [Coin] {
        coins.filter { watchlist.contains($0.id) }
    }
    
    init() {
        loadWatchlist()
        fetchCoins()
        startAutoRefresh()
    }
    
    func fetchCoins() {
        NetworkManager.shared.fetchCoins()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error fetching coins:", error)
                }
            } receiveValue: { [weak self] coins in
                self?.coins = coins
            }
            .store(in: &cancellables)
    }
    
    func toggleWatchlist(for coin: Coin) {
        if watchlist.contains(coin.id) {
            watchlist.remove(coin.id)
        } else {
            watchlist.insert(coin.id)
        }
        saveWatchlist()
    }
    
    func isInWatchlist(_ coin: Coin) -> Bool {
        watchlist.contains(coin.id)
    }
    
    private func loadWatchlist() {
        if let saved = UserDefaults.standard.array(forKey: watchlistKey) as? [String] {
            watchlist = Set(saved)
        }
    }
    
    private func saveWatchlist() {
        UserDefaults.standard.set(Array(watchlist), forKey: watchlistKey)
    }
    
    private func startAutoRefresh() {
        Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchCoins()
            }
            .store(in: &cancellables)
    }
}




