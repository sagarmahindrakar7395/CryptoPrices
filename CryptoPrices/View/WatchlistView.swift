//
//  WatchlistView.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//



import SwiftUI

struct WatchlistView: View {
    @EnvironmentObject var viewModel: CryptoViewModel

    var body: some View {
        List {
            ForEach(viewModel.watchlistCoins) { coin in
                CoinRowView(
                    coin: coin,
                    isInWatchlist: true,
                    toggleWatchlist: { viewModel.toggleWatchlist(for: coin) }
                )
            }
        }
        .navigationTitle("Watchlist")
        .refreshable {
            viewModel.fetchCoins()
        }
    }
}