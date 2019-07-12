//
//  Button.swift
//  Hierarchy_code
//
//  Created by Vimosoft on 11/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class Button: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, text: String){
        super.init(frame: frame)
        initializeButton(text: text)
        
    }
    //초기화시 넣을 초기화 함수
    func initializeButton(text: String) {
        //배경색, 텍스트색 지정
        self.backgroundColor = .black
        self.tintColor = .blue
        //타이틀 지정
        self.setTitle(text, for: .normal)
        //오토리사이즈 설정
        self.autoresizesSubviews = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //레이어 틀 및 색 지정
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
    }
}
