//
//  SingleCard.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/2.
//

import SwiftUI

struct SingleCard: View {
    let  lenth = 4
    let spacing: CGFloat = 10
    @Binding var index: (x: Int, y: Int)
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width / CGFloat( lenth), height: geometry.size.height / CGFloat( lenth))
                .cornerRadius(8)
                .foregroundStyle(.yellow)
                .offset(x: CGFloat(index.x) * (geometry.size.width / CGFloat(lenth)) + self.spacing * CGFloat(index.x), y: CGFloat(index.y) * (geometry.size.height / CGFloat( lenth)) + self.spacing * CGFloat(index.y))
                .animation(.spring(), value: index.x)
                .animation(.spring(), value: index.y)
        }
    }
}

#Preview {
    SingleCard(index: .constant(( 0, 0)))
}
