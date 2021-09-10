//
//  SecondView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import RealmSwift

struct SecondView: View{
    
    //カレンダー上で選択された日付
    @State var selectedDate = Date() {
        willSet(newValue) {
            print(newValue)
            searchDiary()
        }
    }
    
    //検索条件に一致する日記
    @State var diaries = Diary.all()
    
    //日記編集シートのオンオフ
    @State var isShowSheet = false
    
    //編集対象の日記
    @State var selectedDiaryId = 0
    
    var body: some View {
        
        Form {
            Section {
                CalendarView(selectedDate: $selectedDate)
                    .frame(height: 400)
            }
            Text("\(selectedDate)")
        }
        
    }
    
    //タップした日記を編集
    func editDiary(diaryId: Int) {
        selectedDiaryId = diaryId
        isShowSheet.toggle()
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
    
    //選択された日に作成された日記を検索する
    func searchDiary() {
        print(selectedDate)
//        let realm = try! Realm()
//        diaries = realm.objects(Diary.self).filter("createdDate == \(selectedDate)")
    }
    
}
