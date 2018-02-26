//
//  JFCarsViewController.swift
//  JSONFeedViewer
//
//  Created by Vladislav Senyukov on 26.02.2018.
//  Copyright © 2018 Vladislav Senyukov. All rights reserved.
//

import UIKit

class JFCarsViewController: UIViewController {
    
    @IBOutlet weak var carsTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var carsViewModel: JFCarsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCarsViewModel()
    }
    
    func setupCarsViewModel() {
        // create a new view model passing a bundle filename
        let carsViewModel = JFAppFacade.shared.createCarsViewModel(decodedFromBundleResourceOfName: "cars.json")
        // set up binding handlers
        carsViewModel.onDidUpdateLoading = {[unowned self] loading in
            self.carsTableView.isHidden = loading
            loading ? self.spinner.startAnimating() : self.spinner.stopAnimating()
        }
        carsViewModel.onDidLoadCars = { [unowned self] in
            self.carsTableView.reloadData()
        }
        carsViewModel.onDidUpdateExpanded = { [unowned self] indexPath, onDidFinishAnimation in
            self.carsTableView.performBatchUpdates({ [unowned self] in
                self.carsTableView.reloadRows(at: [indexPath], with: .none)
            }, completion: { (finished) in
                onDidFinishAnimation()
            })
        } 
        // load the model
        carsViewModel.load()
        self.carsViewModel = carsViewModel
    }
}

extension JFCarsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsViewModel?.numberOfCells ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JFCarTableViewCell.identifier)!
        if let carCell = cell as? JFCarTableViewCell {
            carCell.model = carsViewModel?.carCellViewModel(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = carsViewModel?.carCellViewModel(at: indexPath) {
            return model.expanded ? 130 : 80
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carsViewModel?.updateExpanded(forCellAt: indexPath)
    }
}
