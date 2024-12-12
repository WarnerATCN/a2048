//
//  SingleCard.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/2.
//

import SwiftUI

struct Coordinates: Equatable{
    var x: CGFloat
    var y: CGFloat
}

struct SingleCard: View, Identifiable {
    var id: UUID
    var num: Int
    var coordinates: Coordinates
    
    let  lenth = 4
    let spacing: CGFloat = 10
    
    @EnvironmentObject var UserData: MainData
    @State private var scale: CGFloat = 0.1 // 初始缩放比例从 0.1 开始
    
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width / CGFloat( lenth)
            let cellHeight = geometry.size.height / CGFloat( lenth)
            ZStack{
                Rectangle()
                Text(String(self.num))
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
            }
            .frame(width: cellWidth, height: cellHeight)
            .cornerRadius(8)
            .foregroundStyle(.yellow)
            .scaleEffect(scale)
            .offset(
                x: self.coordinates.x * (cellWidth + self.spacing),
                y: self.coordinates.y * (cellHeight + self.spacing)
            )
            .onAppear {
                withAnimation(.easeIn(duration: 0.3)) {
                    //
                    self.scale = 1
                } completion: {
                    //
                }

            }
            .onDisappear {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.scale = 0.1
                }
            }
        }
    }
}
