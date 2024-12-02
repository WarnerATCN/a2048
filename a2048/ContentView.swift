//
//  ContentView.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/2.
//

import SwiftUI

let maxWidth = UIScreen.main.bounds.width
let maxHeight = UIScreen.main.bounds.height


struct ContentView: View {
    @State var pos: (x: Int, y: Int) = (0, 0)
    
    var body: some View {
        VStack{
            
            Stepper(value: self.$pos.x, in: 0...3) {
                Text("X: \(self.pos.x)")
            }
            Stepper(value: self.$pos.y, in: 0...3) {
                Text("Y: \(self.pos.y)")
            }
            
            
            ZStack {
                BackgroundGrid()
                SingleCard(index: self.$pos)
                    
            }
            .frame(width: min(maxWidth, maxHeight)*0.8, height: min(maxWidth, maxHeight)*0.8)
        }
    }
}

#Preview {
    ContentView()
}
