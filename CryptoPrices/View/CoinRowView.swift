//
//  CoinRowView.swift
//  CryptoPrices
//
//  Created by Sagar Dinkar Mahindrakar on 11/08/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let isInWatchlist: Bool
    let toggleWatchlist: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("$\(coin.current_price, specifier: "%.2f")")
                .font(.subheadline)
                .monospacedDigit()
                .foregroundColor(.primary)
            Button(action: toggleWatchlist) {
                Image(systemName: isInWatchlist ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            .buttonStyle(.borderless)
            .padding(.leading, 8)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.15),
                    Color.purple.opacity(0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(12)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.vertical, 4)
    }
}


