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
        
    //日記作成日
    @State var createdDate = Date()
    
    //その日のできごと
    @State var content01 = ""
    @State var content02 = ""
    @State var content03 = ""
    
    //ナビゲーションバーのタイトル
    @State var navBarTitle = "新しい日記"
    
    //削除アラートのオンオフ
    @State var isShowAlert = false
        
    var body: some View {
        NavigationView {
            
            //日記入力フォーム
            Form {
                DatePicker("作成日", selection: $createdDate, displayedComponents: .date)
                Section {
                    TextField("記録その1", text: $content01)
                    TextField("記録その2", text: $content02)
                    TextField("記録その3", text: $content03)
                }
                if diaryId != 0 {
                    Button("日記を削除"){
                        isShowAlert.toggle()
                    }
                    .foregroundColor(.red)
                }
            }
            .onAppear {
                //B. diaryが0以外なら、既存レコードを取得
                if diaryId != 0 {
                    let realm = try! Realm()
                    let diary = realm.objects(Diary.self).filter("id == \(diaryId)").first
                    createdDate = diary!.createdDate
                    content01 = diary!.content01
                    content02 = diary!.content02
                    content03 = diary!.content03
                    navBarTitle = "日記を編集"
                }
            }
            
            //削除確認用アラート
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("確認"),
                      message: Text("この日記を削除してもよろしいですか？"),
                      primaryButton: .cancel(Text("キャンセル")),
                      secondaryButton: .destructive(Text("削除"), action: {
                            deleteDiary()
                            myProtocol.reloadDiarys()
                            presentation.wrappedValue.dismiss()
                      })
                )
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
            diary.createdDate = createdDate
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
                diary.createdDate = createdDate
                diary.content01 = content01
                diary.content02 = content02
                diary.content03 = content03
            }
        }
        
    }
    
    //全ての日記を削除する
    func deleteDiary() {
        let realm = try! Realm()
        let results = realm.objects(Diary.self).filter("id == \(diaryId)").first!
        try! realm.write {
            realm.delete(results)
        }
    }
    
}
