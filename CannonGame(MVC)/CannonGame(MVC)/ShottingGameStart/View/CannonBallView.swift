//
//  CannonBall.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

/**
 일반 포탄 뷰
 */
class CannonBallView: UIView {
    
    //-------------------------------------------------------------
    //MARK: - Define Funtion
    //
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.blue
    }
     
    //MARK: change view property function
    
    //원 모양으로 변환
    func circleView(){
        self.layer.cornerRadius = self.frame.size.width/2
    }
}
