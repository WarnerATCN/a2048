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
    @State var showYourName: Bool = false
    @State var YourName = "anonymous"
    
    func replay(){
        self.UserData.Cards.removeAll()
        self.UserData.Score = 0
        self.UserData.addNew()
        self.isFull = false
    }
    
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
//                            .environmentObject(self.UserData)
                    }
                    Image(systemName: "")
                        .resizable()
//                        .border(Color.gray, width: 1)
                        .gesture(
                            DragGesture()
                                .onEnded({ val in
                                    print(self.isFull)
                                    if self.isFull{
                                        return
                                    }
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
                                            if UserData.HighScores.isEmpty || UserData.HighScores.last!.score < UserData.Score{
                                                self.showYourName = true
                                            }
                                            else{
                                                self.isFull = true
                                            }
                                        }
                                    }
                                })
                        )
                }
                .frame(width: min(maxWidth, maxHeight)*0.9, height: min(maxWidth, maxHeight)*0.9)
                .alert("You Lost!", isPresented: self.$isFull) {
                    Button("Replay") {
                        replay()
                    }
                    Button("Cancel"){
                        //
                    }
                    
                }
                .alert("You got HighSocre, please leave your name: ", isPresented: self.$showYourName){
                    VStack {
                        TextField("Enter your name:", text: self.$YourName)
                                .frame(width: 200, height: 40)  // 增加高度和宽度
                                .border(Color.gray, width: 1)
                                .padding()
                        Button("OK"){
                            let name = self.YourName.isEmpty ? "anonymous" : self.YourName
                            UserData.saveHighScores(name: name)
                            self.YourName = ""
                            self.showYourName.toggle()
                            replay()
                        }
                        .padding(.top, 10)
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
