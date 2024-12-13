//
//  BackgroundGrid.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/2.
//

import SwiftUI

struct BackgroundGrid: View {
    let lenth = 4
    let spacing: CGFloat = 10
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: spacing) {
                ForEach(0 ..< 4) { _ in
                    HStack(spacing: spacing) {
                        ForEach(0 ..< 4) { _ in
                            Rectangle()
                                .frame(width: (geometry.size.width - spacing * CGFloat(lenth-1)) / CGFloat( lenth), height: (geometry.size.height - spacing * CGFloat(lenth-1)) / CGFloat( lenth))
                                .cornerRadius(8)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    BackgroundGrid()
}
