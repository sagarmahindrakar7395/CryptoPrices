//
//  ContentView.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//

import SwiftUI
import Combine


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CryptoViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                CoinListView()
            }
            .tabItem {
                Label("All", systemImage: "list.bullet")
            }
            
            NavigationView {
                WatchlistView()
            }
            .tabItem {
                Label("Watchlist", systemImage: "star.fill")
            }
        }
        .environmentObject(viewModel)
    }
}

