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
        let maxXframe = self.view.frame.maxX
        let maxYframe = self.view.frame.maxY
        cannonBallData = CannonBallData(maximumXPoint: maxXframe, maximumYPoint: maxYframe, cannonRadian: 0)
        if  let ballData = cannonBallData{
            print("asf")
            
        }
        // Do any additional setup after loading the view.
    }


}

