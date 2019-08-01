//
//  EnemyView.swift
//  CannonGame(MVC)
//
//  Created by Vimosoft on 31/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class EnemyView: UIView {

    //-------------------------------------------------------------
    //MARK: - Define Funtion
    //
    var enemyHealthSlider = HealthSlider()
    var health: Int?
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: change view property function
    func enemyInit(maxHealth: Int){
        //ADD HEALTH slider in my view
        let sliderFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 30, height: 30))
        enemyHealthSlider = HealthSlider(frame: sliderFrame)
        self.addSubview(enemyHealthSlider)
        self.health = maxHealth
        enemyHealthSlider.getMaxHealth(maxHealth: health ?? 0)
        //MY COLOR
        self.backgroundColor = UIColor.black
    }
      
    func loseHealth(losePoint: Int){
        enemyHealthSlider.loseHealth(losePoint: losePoint)
    }
}
