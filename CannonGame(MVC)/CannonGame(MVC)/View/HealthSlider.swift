//
//  HealthSlider.swift
//  CannonGame(MVC)
//
//  Created by Vimosoft on 01/08/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 남은 체력을 시각적으로 보여줌
 */
class HealthSlider: UISlider {
    var maxHealth : Int = 0
    var myHealth: Int = 0
    var myPosition : CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setThumbImage(UIImage(), for: .normal)
        self.minimumTrackTintColor = .red
        self.maximumTrackTintColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setThumbImage(UIImage(), for: .normal)
        self.minimumTrackTintColor = .red
        self.maximumTrackTintColor = .white
    }

    func getMaxHealth(maxHealth: Int) {
        self.value = 1
        self.myHealth = maxHealth
        self.maxHealth = maxHealth
    }
    
    func loseHealth(losePoint: Int){
        self.myHealth -= losePoint
        self.value = Float(myHealth)/Float(maxHealth) 
    }
}
