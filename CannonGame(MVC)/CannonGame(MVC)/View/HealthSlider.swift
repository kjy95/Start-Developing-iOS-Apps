//
//  HealthSlider.swift
//  CannonGame(MVC)
//
//  Created by Vimosoft on 01/08/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 체력바
 */
class HealthSlider: UISlider {
    //체력 데이터
    var maxHealth : Int = 0
    var myHealth: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initHealthSlider()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initHealthSlider()
    }
    
    //color, isEnabled 초기화
    func initHealthSlider(){
        self.setThumbImage(UIImage(), for: .normal)
        self.minimumTrackTintColor = .red
        self.maximumTrackTintColor = .white
        self.isEnabled = false
    }
    
    //최대 체력 설정
    func getMaxHealth(maxHealth: Int) {
        self.value = 1
        self.myHealth = maxHealth
        self.maxHealth = maxHealth
    }
    
    //체력을 잃음.
    func loseHealth(losePoint: Int){
        self.myHealth -= losePoint
        self.value = Float(myHealth)/Float(maxHealth) 
    }
}
