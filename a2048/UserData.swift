//
//  UserData.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/7.
//

import Foundation

struct Card: Identifiable{
    var id: Int
    var num: Int
    var coordinates: (x: CGFloat, y: CGFloat)
}

class MainData: ObservableObject{
    @Published var Cards: [Card]
    
    init() {
        self.Cards = []
        self.Cards.append(Card(id: self.Cards.count, num: 2, coordinates: (x: 1, y: 1)))
        self.Cards.append(Card(id: self.Cards.count, num: 2, coordinates: (x: 1, y: 2)))
        self.Cards.append(Card(id: self.Cards.count, num: 2, coordinates: (x: 2, y: 2)))
    }
    func add(card: Card){
        self.Cards.append(card)
    }
}
