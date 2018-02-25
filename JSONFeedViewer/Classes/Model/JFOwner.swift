//
//  JFOwner.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 25.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

struct JFOwner: Decodable {
    let id: Int
    let name: String
    let phone: String
    enum CodingKeys: String, CodingKey {
        case id = "owner_id"
        case name = "owner_name"
        case phone = "owner_phone"
    }
}
