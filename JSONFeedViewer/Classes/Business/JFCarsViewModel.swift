//
//  JFCarsViewModel.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 25.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import Foundation

class JFCarsViewModel {
    
    // MARK: Public
    let carsDecoder: JFCarsDecodable
    let filename: String
    init(_ carsDecoder: JFCarsDecodable, filename: String) {
        self.carsDecoder = carsDecoder
        self.filename = filename
    }
    func load() {
        startDecoding(carsDecoder, bundleFileWithName: filename)
    }
    
    // MARK: Binding
    var onDidLoadCars: (() -> ())?
    var onDidUpdateLoading: ((_ loading: Bool) -> ())?
    var onDidUpdateExpanded: ((_ indexPath: IndexPath, _ onDidFinishAnimation: @escaping () -> ()) -> ())?
    var numberOfCells: Int {
        return carCellModels.count
    }
    func carCellViewModel(at indexPath: IndexPath) -> JFCarCellModel {
        return carCellModels[indexPath.row]
    }
    func updateExpanded(forCellAt indexPath: IndexPath) {
        if animating { // do not proceed if already animating
            return
        }
        // update the expanded state
        let carCellModel = carCellModels[indexPath.row]
        carCellModel.expanded = !carCellModel.expanded
        animating = true
        // call a binding handler
        onDidUpdateExpanded?(indexPath) { [unowned self] in
            self.animating = false
        }
    }
    
    // MARK: Private Data
    private var cars: [JFCar]?
    private var carCellModels = [JFCarCellModel]() {
        didSet {
            onDidLoadCars?()
        }
    }
    private var loading: Bool = false {
        didSet {
            onDidUpdateLoading?(loading)
        }
    }
    // animating state prevets from running the next animation before the first one is finished
    private var animating: Bool = false

    // MARK: Private methods
    private func startDecoding(_ decoder: JFCarsDecodable, bundleFileWithName name: String) {
        loading = true
        decoder.decodeFileInBundle(withName: name) {[unowned self] (cars: [JFCar]) in
            self.cars = cars
            self.carCellModels = self.createCarCellModels(cars)
            self.loading = false
        }
    }
    
    private func createCarCellModels(_ cars: [JFCar]) -> [JFCarCellModel] {
        var carCellModels = [JFCarCellModel]()
        for car in cars {
            var ownerModel: JFOwnerViewModel?
            if let owner = car.owners.first {
                ownerModel = JFOwnerViewModel(id: owner.id, name: owner.name, phone: owner.phone)
            }
            let carModel = JFCarCellModel(id: car.id, type: car.type, model: car.model, color: car.color, owner: ownerModel)
            carCellModels.append(carModel)
        }
        return carCellModels
    }
}
