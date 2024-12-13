//
//  Move.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/10.
//

import SwiftUI


enum Move{
    case up;
    case down;
    case left;
    case right;
}

func travel(in direction:Move) -> (x: Int, y:Int){
    switch direction{
    case .up: return (0, -1)
    case .down: return (0,1)
    case .left: return(-1,0)
    case .right: return(1,0)
    }
}

extension MainData{
    func haveSpace(id:UUID, direction: Move) -> (Bool,UUID?){
        let currentCard = self.Cards.first(where: {$0.id == id})!
        var position = currentCard.coordinates
        position.x += CGFloat(travel(in: direction).x)
        position.y += CGFloat(travel(in: direction).y)
        
        if position.x >= 0 && position.x<=3 && position.y >= 0 && position.y <= 3{
            if let card = self.Cards.first(where: { card in
                card.coordinates.x == position.x && card.coordinates.y == position.y
            }){
                if card.num == currentCard.num{
                    return (true, card.id)
                }
            }
            else{
                return (true, emptyUUID)
            }
        }
        
        return (false,emptyUUID)
    }
    
    func sort(in direction: Move){
        self.Cards.sort { data1, data2 in
            switch direction{
            case .up:
                return data1.coordinates.y < data2.coordinates.y  // 上：y 越小越优先
            case .down:
                return data1.coordinates.y > data2.coordinates.y  // 下：y 越大越优先
            case .left:
                return data1.coordinates.x < data2.coordinates.x  // 左：x 越小越优先
            case .right:
                return data1.coordinates.x > data2.coordinates.x  // 右：x
            }
        }
    }
    
    func canMove() -> Bool{
        // 使用真实卡的副本测试
        var cards = self.Cards
        
        var directions:[Move] = [.up, .down, .left, .right]
        for direction in directions{
            // 按方向进行排序
            cards.sort { data1, data2 in
                switch direction{
                case .up:
                    return data1.coordinates.y < data2.coordinates.y  // 上：y 越小越优先
                case .down:
                    return data1.coordinates.y > data2.coordinates.y  // 下：y 越大越优先
                case .left:
                    return data1.coordinates.x < data2.coordinates.x  // 左：x 越小越优先
                case .right:
                    return data1.coordinates.x > data2.coordinates.x  // 右：x
                }
            }
            // 遍历卡片，查看有没有位可以合并的
            for card in cards {
                var (hasSpace,newId) = self.haveSpace(id: card.id, direction: direction)
                while hasSpace{
                    // 可合并，则可继续移动，返回true
                    if newId != emptyUUID{
                        return true
                    }
                    (hasSpace,newId) = self.haveSpace(id: card.id, direction: direction)
                }
            }
        }
        return false
    }
    
    func move(in direction: Move) -> Bool{
        self.sort(in: direction)
        //是否移动过
        var isMoved = false
        for card in self.Cards {
//            print("trying: \(card.id)")
            var (hasSpave,newId) = self.haveSpace(id: card.id, direction: direction)
            while hasSpave {
//                print(card.id)
                guard let idx = self.Cards.firstIndex(where: {$0.id == card.id}) else {return isMoved}
                
                // 移动卡片
                self.Cards[idx].coordinates.x += CGFloat(travel(in: direction).x)
                self.Cards[idx].coordinates.y += CGFloat(travel(in: direction).y)
                isMoved = true
                
                if newId != emptyUUID{
                    //合并卡片
                    print(idx)
//                    DispatchQueue.main.async {
                    self.Cards.remove(at: idx)
//                    }
                    var oldCard = self.Cards.first(where: {$0.id == newId})!
                    oldCard.num *= 2
                    self.Score += oldCard.num
                    if let i = self.Cards.firstIndex(where: {$0.id == newId}){
                        self.Cards[i] = oldCard
                    }
                    hasSpave = false
                    
                }else{
                    (hasSpave,newId) = self.haveSpace(id: card.id, direction: direction)
                }
            }
        }
        return isMoved
//        addNew()
    }
}
