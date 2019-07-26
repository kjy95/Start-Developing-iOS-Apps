//
//  ButtonPicker.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

/**
 버튼 선택 프로토콜
 */
protocol ButtonPickerDelegate : class {
    func changeShape(shape: String)
}

/**
 버튼 선택 창
 */

class ButtonPicker: UIView {
    weak var delegate: ButtonPickerDelegate?

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
