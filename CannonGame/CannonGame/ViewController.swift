//
//  ViewController.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cannonBall: UIView!
    var cannonBallData : CannonBallData?
    override func viewDidLoad() {
        super.viewDidLoad()
        if CannonBallData == CannonBallData(maximumXPoint: self.view.frame.maxX, maximumYPoint: self.view.frame.maxY, cannonRadian: 0){
            
        }
        // Do any additional setup after loading the view.
    }


}

