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

protocol JFCarsDecodable {
    func decodeFileInBundle(withName name: String, completion: @escaping (_ objects: [JFCar]) -> ())
}
class JFCarsDecoder: JFFileDecoder<JFCar>, JFCarsDecodable {}

class JFAppFacade {
    static var shared: JFAppFacade {
        return (UIApplication.shared.delegate as! JFFacadeRetainable).appFacade
    }
    
    func createCarsViewModel(decodedFromBundleResourceOfName name: String) -> JFCarsViewModel {
        // inject dependency and create a new model
        return JFCarsViewModel(JFCarsDecoder(), filename: name)
    }
}
