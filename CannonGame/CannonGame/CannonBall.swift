//
//  CannonBall.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class CannonBall: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        cannonBallInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cannonBallInit()
    }
    
    func cannonBallInit(){
        self.backgroundColor = UIColor.yellow
    }

}
