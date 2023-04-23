//
//  ViewController.swift
//  Add Users intf
//
//  Created by user238064 on 4/3/23.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func nameField(_ sender: UITextField) {
        self.performSegue(withIdentifier: "resultPath", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultPath"{
            let resultVC = segue.destination
        }
    }


}

