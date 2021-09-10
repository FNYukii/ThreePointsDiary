//
//  EditView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import RealmSwift

struct EditView: View {
    
    //編集対象の日記のID 0なら新規日記作成
    let diaryId: Int
    
    //ContentViewの関数を使うためのprotocol
    var myProtocol: MyProtocol
    
    //この画面の環境変数
    @Environment(\.presentationMode) var presentation
    
    //Date型変数から詳細な情報を取り出すためのCalendarクラス
    let calendar = Calendar(identifier: .gregorian)
    
    //年月日を表す文字列 (yyyy年mm月dd日)
    @State var ymdText = ""
    
    //曜日を表す文字列
    @State var weekdayText = ""
    
    //その日のできごと
    @State var content01 = ""
    @State var content02 = ""
    @State var content03 = ""
    
    //ナビゲーションバーのタイトル
    @State var navBarTitle = "新しい日記"
    
    var body: some View {
        NavigationView {
            
            //日記入力フォーム
            Form {
                Section(header: Text("\(ymdText) \(weekdayText)")){
                    TextField("できごとその1", text: $content01)
                    TextField("できごとその2", text: $content02)
                    TextField("できごとその3", text: $content03)
                }
            }
            .onAppear {
                //編集対象日
                var currentDay = Date()
                //B. diaryが0以外なら、既存レコードを取得
                if diaryId != 0 {
                    let realm = try! Realm()
                    let diary = realm.objects(Diary.self).filter("id == \(diaryId)").first
                    currentDay = diary!.createdDate
                    content01 = diary!.content01
                    content02 = diary!.content02
                    content03 = diary!.content03
                    navBarTitle = "日記を編集"
                }
                //ymdTextを生成
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ja_JP")
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "yyyy年 MM月 dd日"
                ymdText = dateFormatter.string(from: currentDay)
                //weekdayTextを生成
                let weekdayNumber = calendar.component(.weekday, from: currentDay)
                let weekdaySymbolIndex: Int = weekdayNumber - 1
                let formatter: DateFormatter = DateFormatter()
                formatter.locale = NSLocale(localeIdentifier: "ja") as Locale
                weekdayText = formatter.shortWeekdaySymbols[weekdaySymbolIndex]
            }
            
            //ナビゲーションバーの設定
            .navigationBarTitle(navBarTitle,displayMode: .inline)
            .navigationBarItems(
                leading:Button("キャンセル"){
                    presentation.wrappedValue.dismiss()
                },
                trailing:Button("完了"){
                    saveDiary()
                    myProtocol.reloadDiarys()
                    presentation.wrappedValue.dismiss()
                }
            )

        }
    }
    
    //日記の内容をデータベースに保存する
    func saveDiary() {
        
        //A. 新規レコード追加
        if diaryId == 0 {
            //新たなIDを生成して新規レコード作成
            let realm = try! Realm()
            let maxId = realm.objects(Diary.self).sorted(byKeyPath: "id").last?.id ?? 0
            let newId = maxId + 1
            //新規レコード作成
            let diary = Diary()
            diary.id = newId
            diary.createdDate = Date()
            diary.content01 = content01
            diary.content02 = content02
            diary.content03 = content03
            //新規レコード追加
            try! realm.write {
                realm.add(diary)
            }
        }
        
        //B. 既存レコード更新
        if diaryId != 0 {
            let realm = try! Realm()
            let diary = realm.objects(Diary.self).filter("id == \(diaryId)").first!
            try! realm.write {
                diary.content01 = content01
                diary.content02 = content02
                diary.content03 = content03
            }
        }
        
    }
    
    //全ての日記を削除する
    func deleteDiary() {
        let realm = try! Realm()
        let results = realm.objects(Diary.self)
        try! realm.write {
            realm.delete(results)
        }
    }
    
}
