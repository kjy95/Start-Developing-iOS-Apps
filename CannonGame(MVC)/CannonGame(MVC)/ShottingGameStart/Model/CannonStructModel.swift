//
//  GameModel.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 게임 데이터
 대포, 포탄 데이터
 */
class CannonStructModel {
    //-------------------------------------------------------------
    //MARK: - Define Value
    //
    
    //대포 현재 센터 위치
    var currentLoc : CGPoint
    var radian : CGFloat
    var earlyTransform : CGAffineTransform
    //대포 벡터
    var vector = CGVector()
    //대포 알 타입
    var type : String?
    //frmae
    var frame : CGRect?
    //health
    var myHealth : Int
    
    //-------------------------------------------------------------
    //MARK: - Define function
    //
    
    //MARK: init
    //초기화
    init(currentLoc: CGPoint, frame: CGRect, health: Int) {
        self.currentLoc = currentLoc
        
        //default
        self.radian = CGFloat.pi/2
        self.earlyTransform = CGAffineTransform.identity
        self.type = "rectangle"
        self.frame = frame
        self.myHealth = health
    }
    
    //MARK: change value
    //방향
    func updateCannonVector(radian: CGFloat, speed: CGFloat){
        self.radian = radian
        self.vector.dx = -cos(radian) * speed
        self.vector.dy = -sin(radian) * speed
    }
    
    //체력
    func loseHealth(losePoint: Int){
        self.myHealth -= losePoint
    }
}
