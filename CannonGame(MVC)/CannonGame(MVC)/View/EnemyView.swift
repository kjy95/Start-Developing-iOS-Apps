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
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        enemyInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        enemyInit()
    }
    
    //MARK: change view property function
    
    func enemyInit(){
        self.backgroundColor = UIColor.black
    }
    
    //원 모양으로 변환
    func circleView(){
        self.layer.cornerRadius = self.frame.size.width/2
    }
}
