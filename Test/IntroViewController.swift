//
//  IntroViewController.swift
//  Test
//
//  Created by i Daliri on 5/2/17.
//  Copyright © 2017 i Daliri. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func mapTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "showMap", sender: self)
    }
    
    
}
