//
//  ContentView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/09.
//

import SwiftUI

struct ContentView: View {
    
    //日記編集シートのオンオフ
    @State var isShowSheet = false
    
    //全てのDiaryを取得
    @State var diarys = Diary.all()
    
    var body: some View {
        NavigationView {
            
            //日記一覧
            Form {
                ForEach(diarys.freeze()) { diary in
                    Section(header: Text("\(diary.createdDate)")) {
                        Text(diary.content01)
                        Text(diary.content02)
                        Text(diary.content03)
                    }
                }
            }
            
            //日記を書くためのシート
            .sheet(isPresented: $isShowSheet) {
                EditView()
            }
                
            //ナビゲーションバーの設定
            .navigationBarTitle("3 Points Diary", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {isShowSheet.toggle()}) {
                    Image(systemName: "square.and.pencil")
                }
            )
                
        }
    }
}


