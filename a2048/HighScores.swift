//
//  HighScores.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/14.
//


import SwiftUI

struct HighScores: View {
    @ObservedObject var UserData: MainData = MainData()
    
    var body: some View {
        List {
            ForEach(UserData.HighScores, id: \.self) { item in
                Text(String(item))
            }
        }
        .navigationTitle("High Scores")
    }
}

#Preview {
    HighScores()
}
