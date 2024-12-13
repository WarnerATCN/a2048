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
    
    @State var isFull: Bool = false
    @State var showHighSocres: Bool = false
    
    var body: some View {
            
            VStack{
                Button("High Scores") {
                    self.showHighSocres.toggle()
                }
                Text("Score:\(self.UserData.Score)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                ZStack {
                    
                    BackgroundGrid()
                    ForEach(UserData.Cards) { item in
                        item
                            .environmentObject(self.UserData)
                    }
                    
                    Image(systemName: "")
                        .resizable()
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
                                    if self.UserData.move(in: direction){
                                        self.UserData.addNew()
                                    }
                                    else{
                                        if UserData.Cards.count == 16 && !UserData.canMove() {
                                            UserData.saveHighScores()
                                            self.isFull = true
                                        }
                                    }
                                })
                        )
                }
                .frame(width: min(maxWidth, maxHeight)*0.9, height: min(maxWidth, maxHeight)*0.9)
                .alert("You Lost!", isPresented: self.$isFull) {
                    Button("Replay") {
                        self.UserData.Cards.removeAll()
                        self.UserData.Score = 0
                        self.UserData.addNew()
                        self.isFull = false
                    }
                    Button("Cancel"){
                        //
                    }
                }
                .padding(.bottom)
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.UserData.Cards.removeAll()
                        self.UserData.Score = 0
                        self.UserData.addNew()
                        self.isFull = false
                    }
            }
            .sheet(isPresented: self.$showHighSocres) {
                HighScores(UserData: self.UserData)
            }
    }
}

#Preview {
    ContentView()
}
