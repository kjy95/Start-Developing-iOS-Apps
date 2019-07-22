//
//  LabelSuperView.swift
//  Hierarchy_code
//
//  Created by Vimosoft on 11/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class View: UIView {

    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        initProperty(color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initProperty(color: UIColor){
        //색입력 받아 배경 지정
        self.backgroundColor = color
        //오토리사이즈 설정
        /*self.autoresizesSubviews = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]*/
    }
    

}
