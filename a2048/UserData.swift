//
//  UserData.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/7.
//

import Foundation


class MainData: ObservableObject{
    @Published var Cards: [SingleCard]
    @Published var Score: Int = 0
    let emptyUUID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")
    init() {
        self.Cards = []
        addNew()
    }
    func addNew(){
        if self.Cards.count < 16{
            var rndX = Int.random(in: 0...3)
            var rndY = Int.random(in: 0...3)
            var coordinates = Coordinates(x: CGFloat(rndX), y: CGFloat(rndY))
            
            while self.Cards.contains(where: { $0.coordinates.x == coordinates.x && $0.coordinates.y == coordinates.y }) {
                // 匹配到XY完全相同的，重新随机
                rndX = Int.random(in: 0...3)
                rndY = Int.random(in: 0...3)
                coordinates = Coordinates(x: CGFloat(rndX), y: CGFloat(rndY))
            }
            
            let card = SingleCard(id:UUID(), num: 2,coordinates: coordinates)
            self.Cards.append(card)
            
        }
    }
}
