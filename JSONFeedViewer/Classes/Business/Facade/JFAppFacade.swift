//
//  JFAppFacade.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 25.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import UIKit

protocol JFFacadeRetainable {
    var appFacade: JFAppFacade {get}
}

class JFAppFacade {
    static var shared: JFAppFacade {
        return (UIApplication.shared.delegate as! JFFacadeRetainable).appFacade
    }
    
    func obtainCarsDatasource(fromBundleResourceOfName name: String,
                              completion: @escaping (_ cars: [JFCar]) -> ()) {
        JFFileDecoder<JFCar>().decodeFileInBundle(withName: name, completion: completion)
    }
}
