//
//  ButtonPicker.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

/**
 모양 버튼 선택 프로토콜
 델리게이트 파라메터로 어떤 모양인지 보내줌
 */
protocol ButtonPickerDelegate : class {
    func changeShape(shape: String)
}

/**
 모양 버튼 선택 창
 */
class ButtonPicker: UIView {
    weak var delegate: ButtonPickerDelegate?
    
    //각 버튼을 눌렀을 때
    @IBAction func tapCircle(_ sender: Any) {
        delegate?.changeShape(shape: "circle")
    }
    @IBAction func tapTriangle(_ sender: Any) {
        delegate?.changeShape(shape: "triangle")
    }
    @IBAction func tapRect(_ sender: Any) {
        delegate?.changeShape(shape: "rectangle")
    }

}
