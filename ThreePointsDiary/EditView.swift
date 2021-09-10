//
//  EditView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import RealmSwift

struct EditView: View {
    
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
                //ymdTextを生成
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ja_JP")
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "yyyy年 MM月 dd日"
                ymdText = dateFormatter.string(from: Date())
                //weekdayTextを生成
                let weekdayNumber = calendar.component(.weekday, from: Date())
                let weekdaySymbolIndex: Int = weekdayNumber - 1
                let formatter: DateFormatter = DateFormatter()
                formatter.locale = NSLocale(localeIdentifier: "ja") as Locale
                weekdayText = formatter.shortWeekdaySymbols[weekdaySymbolIndex]
            }
            
            //ナビゲーションバーの設定
            .navigationBarTitle("今日の日記", displayMode: .inline)
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
        //Realmをインスタンス化
        let realm = try! Realm()
        //新規レコードのidを生成
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
    
    //全ての日記を削除する
    func deleteDiary() {
        let realm = try! Realm()
        let results = realm.objects(Diary.self)
        try! realm.write {
            realm.delete(results)
        }
    }
    
}
