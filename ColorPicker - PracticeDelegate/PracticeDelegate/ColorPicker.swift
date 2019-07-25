//
//  MessageBox.swift
//  PracticeDelegate
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//
 
import UIKit

/**
    컬러 변환 프로토콜
    이 클래스에 속한 색깔 버튼을 눌렀을 때 호출되는 메서드.
 */
protocol ColorPickerDelegate: class {
    func changedColor(newColor: UIColor)
    func changingColor(newColor: UIColor)
}

/**
    색상선택기
    뷰 컨트롤러에 있는 텍스트 라벨의 배경색, 텍스트 색을 바꾸기 위한 버튼을 가짐.
    각 버튼을 눌렀을 때 프로토콜에 선언된 메서드 호출.
 */
class ColorPicker: UIView {
    
    weak var delegate: ColorPickerDelegate?
   
    //init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureBorder()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureBorder()
    }
    
    //set border
    func configureBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    //action when each button touch inside
    //delegate
    @IBAction func touchUpInsideBlackButton(_ sender: UIButton) {
        delegate?.changedColor(newColor: sender.titleLabel?.textColor ?? .white)
    }
    @IBAction func touchUpInsideWhiteButton(_ sender: UIButton) {
        delegate?.changedColor(newColor: sender.titleLabel?.textColor ?? .white)
    } 
    @IBAction func touchUpInsideBlueButton(_ sender: UIButton) {
        delegate?.changedColor(newColor: sender.titleLabel?.textColor ?? .white)
    }
    @IBAction func touchUpInsideYellowButton(_ sender: UIButton) {
        delegate?.changedColor(newColor: sender.titleLabel?.textColor ?? .white)
    } 
}
