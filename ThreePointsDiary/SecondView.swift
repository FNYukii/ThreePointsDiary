//
//  SecondView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/12.
//

import SwiftUI
import RealmSwift

struct SecondView: View, MyProtocol {
    
    //検索文字列
    @State var queryStr = ""
    
    //表示する日記
    @State var diaries = Diary.noRecord()
    //日記編集シートのオンオフ
    @State var isShowSheet = false
    //編集対象の日記
    @State var selectedDiaryId = 0
    
    var body: some View {
        NavigationView {
            
            Form {
                
                //検索バー
                TextField("テキストを入力", text: $queryStr, onCommit: {searchDiary()})
                
                //検索結果表示エリア
                ForEach(diaries.freeze()) { diary in
                    Section(header: Text("\(ymdText(inputDate: diary.createdDate)) \(weekdayText(inputDate: diary.createdDate))")) {
                        Button("\(diary.content01)"){editDiary(diaryId: diary.id)}
                            .foregroundColor(.primary)
                        Button("\(diary.content02)"){editDiary(diaryId: diary.id)}
                            .foregroundColor(.primary)
                        Button("\(diary.content03)"){editDiary(diaryId: diary.id)}
                            .foregroundColor(.primary)
                    }
                }
                .onAppear {
                    reloadDiaries()
                }
            }
            
            
            //日記を書くためのシート
            .sheet(isPresented: $isShowSheet) {
                EditView(myProtocol: self)
            }
            
            .navigationBarTitle("検索")
            
        }
    }
    
    func reloadDiaries() {
        searchDiary()
    }
    
    func getSelectedDiaryId() -> Int {
        return selectedDiaryId
    }
    
    //タップした日記を編集
    func editDiary(diaryId: Int) {
        selectedDiaryId = diaryId
        isShowSheet.toggle()
    }
        
    //選択された日に作成された日記を検索する
    func searchDiary() {
        let realm = try! Realm()
        diaries = realm.objects(Diary.self).filter("content01 CONTAINS '\(queryStr)' OR content02 CONTAINS '\(queryStr)' OR content03 CONTAINS '\(queryStr)'")
    }
    
    //Date型変数を年月日のみの文字列に変換する
    func ymdText(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy年 M月 d日"
        return dateFormatter.string(from: inputDate)
    }
    
    //Date型変数を曜日のみの文字列に変換する
    func weekdayText(inputDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let weekdayNumber = calendar.component(.weekday, from: inputDate)
        let weekdaySymbolIndex: Int = weekdayNumber - 1
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja") as Locale
        return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
    }
    
}
