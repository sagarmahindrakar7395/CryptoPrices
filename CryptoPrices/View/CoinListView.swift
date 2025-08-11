//
//  CoinListView.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//


import SwiftUI

struct CoinListView: View {
    @EnvironmentObject var viewModel: CryptoViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.filteredCoins) { coin in
                CoinRowView(
                    coin: coin,
                    isInWatchlist: viewModel.isInWatchlist(coin),
                    toggleWatchlist: { viewModel.toggleWatchlist(for: coin) }
                )
            }
            .listRowSeparator(.hidden)
        }
        .navigationTitle("All Coins")
        .searchable(text: $viewModel.searchText)
        .refreshable {
            viewModel.fetchCoins()
        }
    }
}


