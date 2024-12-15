//
//  HighScores.swift
//  a2048
//
//  Created by Warner Kuo on 2024/12/14.
//


import SwiftUI

struct HighScores: View {
    @ObservedObject var UserData: MainData = MainData()
//    @State private var sortOrder = [KeyPathComparator(\HighScore.score)]
    
    var body: some View {

        Text("Ranking")
            .font(.system(size: 30))
            .fontWeight(.bold)
            .padding()
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    Text("Rank").bold()
                        .frame(maxWidth: .infinity)
                    Text("Score").bold()
                        .frame(maxWidth: .infinity)
                    Text("Name").bold()
                        .frame(maxWidth: .infinity)
                }
                ForEach(UserData.HighScores.indices, id:\.self) { index in
                    HStack{
                        Text("\(index+1)")
                            .frame(maxWidth: .infinity)
                        Text("\(UserData.HighScores[index].score)")
                            .frame(maxWidth: .infinity)
                        
                        Text("\(UserData.HighScores[index].name)")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .foregroundStyle(index % 2 == 0 ? Color.white : Color.black)
                    .background(index % 2 == 0 ? Color(red:0.6, green:0.6, blue:0.8) : Color.clear)
                }
                
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        Spacer()
//
//        Table(UserData.HighScores, sortOrder: $sortOrder) {
//            TableColumn("Name", value: \.name)
//            TableColumn("Score", value: \.score) { data in
//                Text("\(data.score)")
//            }
//        }
    }
}

#Preview {
    HighScores()
}
