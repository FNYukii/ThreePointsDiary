//
//  ContentView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/09.
//

import SwiftUI

struct ContentView: View, MyProtocol {
    
    //Date型変数から詳細な情報を取り出すためのCalendarクラス
    let calendar = Calendar(identifier: .gregorian)
    
    //日記編集シートのオンオフ
    @State var isShowSheet = false
    
    //編集対象の日記
    @State var selectedDiaryId = 0
    
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
                    .onTapGesture {
                        selectedDiaryId = diary.id
                        isShowSheet.toggle()
                    }
                }
            }
            
            //日記を書くためのシート
            .sheet(isPresented: $isShowSheet) {
                EditView(myProtocol: self)
            }
                
            //ナビゲーションバーの設定
            .navigationBarTitle("3 Points Diary", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    selectedDiaryId = 0
                    isShowSheet.toggle()
                }) {
                    Image(systemName: "square.and.pencil")
                }
            )
                
        }
    }
    
    //リストを再描画
    func reloadDiarys() {
        diarys = Diary.all()
    }
    
    //Date型変数を年月日のみの文字列に変換する
    func ymdText(createdDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy年 M月 d日"
        return dateFormatter.string(from: createdDate)
    }
    
    //Date型変数を曜日のみの文字列に変換する
    func weekdayText(createdDate: Date) -> String {
        let weekdayNumber = calendar.component(.weekday, from: createdDate)
        let weekdaySymbolIndex: Int = weekdayNumber - 1
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja") as Locale
        return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
    }
    
    //EditViewにselectedDiaryIdを渡す
    func getSelectedDiaryId() -> Int {
        return selectedDiaryId
    }
    
}

//EditViewからContentViewの関数を実行するためのProtocol
protocol MyProtocol {
    func reloadDiarys()
    func getSelectedDiaryId() -> Int
}
