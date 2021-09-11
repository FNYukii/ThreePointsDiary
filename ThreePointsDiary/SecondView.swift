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
                    .onChange(of: selectedDate, perform: { value in
                        searchDiary()
                    })
            }
            Text("\(selectedDate)")
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
        let realm = try! Realm()
        
        //検索対象のDate変数を取得
        let searchDate = selectedDate
        
        //開始日時
        let calendar = Calendar(identifier: .gregorian)
        let startDate = calendar.startOfDay(for: searchDate)
        
        //終了日時
        var compornets = DateComponents()
        compornets.year = calendar.component(.year, from: searchDate)
        compornets.month = calendar.component(.month, from: searchDate)
        compornets.day = calendar.component(.year, from: searchDate)
        compornets.hour = 23
        compornets.minute = 59
        compornets.second = 59
        let endDate = calendar.date(from: compornets)
        
        print("start: \(startDate), end: \(endDate)")

//        diaries = realm.objects(Diary.self).filter("createdDate >= \(startDate) && createdDate < \(endDate)")
    }
    
}
