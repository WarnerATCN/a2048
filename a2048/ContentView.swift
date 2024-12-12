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
    
    @ObservedObject var UserData: MainData = MainData()
    
    @State var pos: (x: Int, y: Int) = (0, 0)
    
    var body: some View {
        VStack{

            ZStack {
                BackgroundGrid()
//                SingleCard(index: self.$pos, original: (x: 0, y: 0))
                ForEach(UserData.Cards) { item in
                    SingleCard(card: item)
                        .environmentObject(self.UserData)
                }
                Image(systemName: "")
                    .resizable()
                    .onTapGesture {
                        self.UserData.move(in: .left)
                    }
                    .gesture(
                        DragGesture()
                            .onEnded({ val in
                                let translation = val.translation
                                var direction: Move = .down
                                if abs(translation.width) > abs(translation.height){
                                    if translation.width>0{
                                        direction = .right
                                    }
                                    else{
                                        direction = .left
                                    }
                                }
                                else if abs(translation.height) > abs(translation.width){
                                    if translation.height>0{
                                        direction = .down
                                    }
                                    else{
                                        direction = .up
                                    }
                                }
                                self.UserData.move(in: direction)
                            })
                    )
            }
            .frame(width: min(maxWidth, maxHeight)*0.8, height: min(maxWidth, maxHeight)*0.8)
        }
    }
}

#Preview {
    ContentView()
}
