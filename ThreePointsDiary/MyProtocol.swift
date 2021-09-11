//
//  MyProtocol.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/11.
//

import Foundation

//View呼び出し先から呼び出し元の関数を実行するためのProtocol
protocol MyProtocol {
    func reloadDiaries()
    func getSelectedDiaryId() -> Int
}
