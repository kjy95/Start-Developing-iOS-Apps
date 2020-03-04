//
//  ButtonPicker.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit


/**
 대포 조작 창
 */

//MARK: - define protocol
protocol CannonControlViewDelegate : class {
    // 각 버튼 선택 했을 때 함수 (프로토콜)
    func changeType(type: String)
    func changeDegreeCannon(sliderValue: Float)
    func fireCannonBall()
}

//MARK: - define class
class CannonControlView: UIView {
    //-------------------------------------------------------------
    //MARK: - define value
    //
    
    //button
    @IBOutlet weak var rectButton: UIButton!
    @IBOutlet weak var triangleButton: UIButton!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var cannonSlider: UISlider!
    
    weak var delegate: CannonControlViewDelegate?
    
    //-------------------------------------------------------------
    //MARK: - define function
    //
    
    //MARK: action
    /**
     각 버튼을 눌렀을 때
     */
    @IBAction func tapCircle(_ sender: UIButton) {
        delegate?.changeType(type: "circle")
    }
    @IBAction func tapTriangle(_ sender: UIButton) {
        delegate?.changeType(type: "triangle")
    }
    @IBAction func tapRect(_ sender: UIButton) {
        delegate?.changeType(type: "rectangle")
    }
    
    //슬라이더 움직였을 때
    @IBAction func changeDegreeCannon(_ sender: UISlider) {
        delegate?.changeDegreeCannon(sliderValue: sender.value)
    }
    
    //fire 버튼 눌렀을 때
    @IBAction func tapFire(_ sender: Any) {
        delegate?.fireCannonBall()
    }
    
    //버튼 모두 disable
    func disableAllControl(){
        self.cannonSlider.isEnabled = false
        self.fireButton.isEnabled = false
        self.rectButton.isEnabled = false
        self.circleButton.isEnabled = false
        self.triangleButton.isEnabled = false
    }
    
    //버튼 모두 enable
    func enableAllControl(){
        self.cannonSlider.isEnabled = true
        self.fireButton.isEnabled = true
        self.rectButton.isEnabled = true
        self.circleButton.isEnabled = true
        self.triangleButton.isEnabled = true
    }
}
