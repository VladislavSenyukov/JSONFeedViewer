//
//  JFCarCellModel.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 26.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

struct JFCarCellModel {
    let id: Int
    let type: String
    let model: String
    let color: String
    let owner: JFOwnerViewModel?
}
