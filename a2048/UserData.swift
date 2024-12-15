//
//  UserData.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/7.
//

import Foundation

struct HighScore: Identifiable, Codable{
    var id = UUID()
    var score:Int
    var name:String
}

class MainData: ObservableObject{
    @Published var Cards: [SingleCard]
    @Published var Score: Int = 0
    @Published var HighScores: [HighScore] = []
//    @Published var HighScores: [HighScore] = [HighScore(score: 34340, name: "warner") , HighScore(score: 14340, name: "warner")]
    private let highScoreKey = "HighScore1"
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
    func saveHighScores(name:String = "Warner"){
        let historyScore:HighScore = HighScore(score: self.Score, name: name)
        self.HighScores.append(historyScore)
        self.HighScores.sort(by: {$0.score > $1.score})
        self.HighScores = Array(self.HighScores.prefix(10))
        
        if let encoded = try? JSONEncoder().encode(self.HighScores){
            UserDefaults.standard.set(encoded, forKey: highScoreKey)
        }
    }
    func loadHighScores(){
        if let historyScore = UserDefaults.standard.data(forKey: highScoreKey){
            if let decodedScores = try? JSONDecoder().decode([HighScore].self, from: historyScore){
                self.HighScores = decodedScores
            }
        }
    }
}
