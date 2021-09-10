//
//  ContentView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/09.
//

import SwiftUI

struct ContentView: View {
    
    //Date型変数から詳細な情報を取り出すためのCalendarクラス
    let calendar = Calendar(identifier: .gregorian)
    
    //日記編集シートのオンオフ
    @State var isShowSheet = false
    
    //全てのDiaryを取得
    @State var diarys = Diary.all()
    
    var body: some View {
        NavigationView {
            
            //日記一覧
            Form {
                ForEach(diarys.freeze()) { diary in
                    Section(header: Text("\(ymdText(createdDate: diary.createdDate)) \(weekdayText(createdDate: diary.createdDate))")) {
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
    
    //Date型変数を年月日のみの文字列に変換する
    func ymdText(createdDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy年 MM月 dd日"
        return dateFormatter.string(from: Date())
    }
    
    //Date型変数を曜日のみの文字列に変換する
    func weekdayText(createdDate: Date) -> String {
        let weekdayNumber = calendar.component(.weekday, from: Date())
        let weekdaySymbolIndex: Int = weekdayNumber - 1
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja") as Locale
        return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
    }
    
}


