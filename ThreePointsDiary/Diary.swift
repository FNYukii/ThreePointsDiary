//
//  Diary.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import Foundation
import RealmSwift

class Diary: Object {
    
    //列を定義
    @objc dynamic var id: Int = 0
    @objc dynamic var created_at: Date = Date()
    @objc dynamic var content01: String = ""
    @objc dynamic var content02: String = ""
    @objc dynamic var content03: String = ""

}

