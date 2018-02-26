//
//  JFCarCellModel.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 26.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

class JFCarCellModel {
    let id: Int
    let type: String
    let model: String
    let color: String
    let owner: JFOwnerViewModel?
    var expanded = false
    
    init(id: Int, type: String, model: String, color: String, owner: JFOwnerViewModel?) {
        self.id = id
        self.type = type
        self.model = model
        self.color = color
        self.owner = owner
    }
}
