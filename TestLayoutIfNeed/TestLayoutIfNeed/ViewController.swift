//
//  ViewController.swift
//  TestLayoutIfNeed
//
//  Created by Vimosoft on 12/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueHeight: NSLayoutConstraint!
    
    @IBAction func heightPressed(_ sender: AnyObject) {
        view.layoutIfNeeded()
        if(self.blueHeight.constant == 25.0)
        {
            self.blueHeight.constant = self.view.bounds.height - 100.0
        }
        else
        {
            self.blueHeight.constant = 25.0
        }
        UIView.animate(withDuration: 2.0, animations: {
            self.view.setNeedsLayout()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
