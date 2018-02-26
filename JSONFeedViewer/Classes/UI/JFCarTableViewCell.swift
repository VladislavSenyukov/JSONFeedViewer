//
//  JFCarTableViewCell.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 26.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import UIKit

class JFCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carColor: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerPhone: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var model: JFCarCellModel? {
        didSet {
            guard   let aModel = model,
                    let owner = aModel.owner
            else {
                carType.text = nil
                carModel.text = nil
                carColor.text = nil
                ownerName.text = nil
                ownerPhone.text = nil
                return
            }
            
            carType.text = aModel.type
            carModel.text = aModel.model
            carColor.text = aModel.color
            ownerName.text = owner.name
            ownerPhone.text = owner.phone
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
