//
//  JFFileDecoder.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 25.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

class JFFileDecoder<T: Decodable> {
    
    typealias JFDecodedObjectsCompletion = (_ objects: [T]) -> ()
    
    var runQueue = DispatchQueue(label: "JFFileDecoderQueue")
    var callbackQueue = DispatchQueue.main
    
    func decodeFileInBundle(withName name: String, completion: @escaping JFDecodedObjectsCompletion) {
        runQueue.async {
            if let jsonData = Data(contentsOfFileInBundleOfName: name) {
                self.decodeWithJSONData(jsonData, completion: completion)
            } else {
                self.runCompletionOnCallbackQueue(completion, withObjects: [])
            }
        }
    }
    
    private func decodeWithJSONData(_ jsonData: Data, completion: @escaping JFDecodedObjectsCompletion) {
        let decoder = JSONDecoder();
        do {
            let cars = try decoder.decode([T].self, from: jsonData)
            self.runCompletionOnCallbackQueue(completion, withObjects: cars)
        } catch {
            self.runCompletionOnCallbackQueue(completion, withObjects: [])
        }
    }
    
    private func runCompletionOnCallbackQueue(_ completion: @escaping JFDecodedObjectsCompletion, withObjects objects: [T]) {
        callbackQueue.async {
            completion(objects)
        }
    }
    
}
