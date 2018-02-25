//
//  Data+Additions.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 25.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

extension Data {
    init?(contentsOfFileInBundleOfName name:String) {
        let filenameComponents = name.components(separatedBy: ".")
        if filenameComponents.count == 2 {
            if let fileURL = Bundle.main.url(forResource: filenameComponents.first, withExtension: filenameComponents.last) {
                try? self.init(contentsOf: fileURL)
                return
            }
        }
        return nil
    }
}
