//
//  Label.swift
//  Hierarchy_code
//
//  Created by Vimosoft on 11/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class Label: UILabel {
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) 
    }
    
    init(frame: CGRect, text: String){
        super.init(frame: frame)
        initializeLabel(text: text)
        
    }
    //초기화시 넣을 초기화 함수
    func initializeLabel(text: String) {
        //텍스트 입력받아 라벨 변환
        self.textColor = UIColor.white
        self.text = text
        //오토리사이즈 설정
        self.autoresizesSubviews = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //레이어 틀 및 색 지정
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        
    }
}
