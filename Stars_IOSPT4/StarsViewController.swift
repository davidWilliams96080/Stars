//
//  ViewController.swift
//  Stars_IOSPT4
//
//  Created by David Williams on 12/5/19.
//  Copyright © 2019 david williams. All rights reserved.
//

import UIKit

class StarsViewController: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var distanceTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let starController = StarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: IBActions
    @IBAction func printStars(_ sender: UIButton) {
        
    }
    
    @IBAction func createStar(_ sender: UIButton) {
        guard let name = nameTextfield.text,
            let distanceString = distanceTextfield.text,
            !name.isEmpty,
            !distanceString.isEmpty,
            let distance = Double(distanceString) else { return }
        
        starController.createStar(named: name, withDistance: distance)
        nameTextfield.text = ""
        distanceTextfield.text = ""
        nameTextfield.becomeFirstResponder()
        tableView.reloadData()
    }
    
}

extension StarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starController.stars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath) as? StarTableViewCell else { return UITableViewCell() }
        
        let star = starController.stars[indexPath.row]
        
        cell.star = star
        return cell
        
    }
}
