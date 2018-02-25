//
//  JFCar.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 25.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

struct JFCar : Decodable {
    let id: Int
    let type: String
    let model: String
    let color: String
    let owners: [JFOwner]
    enum CodingKeys: String, CodingKey {
        case id = "car_id"
        case type = "car_type"
        case model = "car_model"
        case color = "car_color"
        case owners
    }
}
