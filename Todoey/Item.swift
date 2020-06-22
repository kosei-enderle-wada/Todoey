//
//  Model.swift
//  Todoey
//
//  Created by 和田エンデルレ晃世 on 2020/06/21.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct Item: Encodable{
    var title: String = ""
    var done: Bool = false
}
