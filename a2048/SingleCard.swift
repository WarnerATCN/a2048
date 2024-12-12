//
//  SingleCard.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/2.
//

import SwiftUI


func appr(_ ip: CGFloat) -> Int {
    let remain = ip - CGFloat(Int(ip))
    return remain > 0.5 ? Int(ip)+1 : Int(ip)
}

struct SingleCard: View {
    let  lenth = 4
    let spacing: CGFloat = 10
    
    @EnvironmentObject var UserData: MainData
    var card: Card
    
//    var getIndex: Int{
//        return self.UserData.Cards.firstIndex(where: { $0.id == self.card.id }) ?? -1
//    }
    
//    @Binding var index: (x: Int, y: Int)
//    @State var original: (x: Int, y: Int)
//    @State var magnet: (x: CGFloat, y: CGFloat) = (0,0)
//    @State var floatScale:CGFloat = 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle()
                Text(String(self.card.num))
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
            }
            
                .frame(width: geometry.size.width / CGFloat( lenth), height: geometry.size.height / CGFloat( lenth))
                .cornerRadius(8)
                .foregroundStyle(.yellow)
//                .scaleEffect(floatScale)
//                .shadow(radius: self.floatScale > 1 ? 5 :0, x: 0, y: self.floatScale > 1 ? 10 : 0)
                .offset(
                    x: CGFloat(self.card.coordinates.x) * (geometry.size.width / CGFloat(lenth)) + self.spacing * CGFloat(self.card.coordinates.x),
                    y: CGFloat(self.card.coordinates.y) * (geometry.size.height / CGFloat( lenth)) + self.spacing * CGFloat(self.card.coordinates.y))
//                .offset(x: self.magnet.x / 5, y: self.magnet.y / 5)
//                .animation(.spring(), value: index.x)
//                .animation(.spring(), value: index.y)
                .gesture(
                    DragGesture()
//                        .onChanged({ val in
//                            self.floatScale = 1.1
//                            let movement = val.translation
//                            let xCoor = appr(movement.width / ((geometry.size.width / CGFloat(lenth)) + self.spacing * CGFloat(index.x)))
//                            let yCoor = appr(movement.height / ((geometry.size.height / CGFloat(lenth)) + self.spacing * CGFloat(index.y)))
//                            
//                            self.magnet.x = movement.width - CGFloat(xCoor)*(geometry.size.width / CGFloat(lenth) + self.spacing * CGFloat(index.x))
//                            self.magnet.y = movement.height - CGFloat(yCoor)*(geometry.size.height / CGFloat(lenth) + self.spacing * CGFloat(index.y))
//                            
//                            self.index.x = max(0,min((original.x + xCoor), lenth-1))
//                            self.index.y  = max(min((original.y + yCoor), lenth-1),0)
//                            
//                        })
//                        .onEnded({ val in
//                            self.floatScale = 1
//                            self.original = self.index
//                            self.magnet = (0,0)
//                        })
                )
        }
    }
}

//#Preview {
//    SingleCard(index: .constant(( 0, 0)), original: (x: 0, y: 0))
//}
