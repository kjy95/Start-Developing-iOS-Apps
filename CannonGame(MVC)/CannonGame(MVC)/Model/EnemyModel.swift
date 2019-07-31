//
//  GameModel.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 적 데이터
 */
class EnemyModel {
    //-------------------------------------------------------------
    //MARK: - define Value
    //

    //  위치
    var maxX : UInt32?
    var position : CGPoint?
    
    // 벡터
    var vector : CGVector?
    var radian : CGFloat
    
    // speed
    var maxSpeed : UInt32 = 0
    var minSpeed : UInt32 = 0
    var speed : UInt32?
    
    //체력
    var health : Int?
    //-------------------------------------------------------------
    //MARK: - define function
    //

    //MARK: 초기화
    
    init(vector: CGVector, maxX: UInt32, maxSpeed: UInt32, minSpeed: UInt32) {
        self.vector = vector
        self.maxX = maxX
        self.maxSpeed = maxSpeed
        self.minSpeed = minSpeed
        
        //make my speed 
        self.speed = arc4random_uniform(self.maxSpeed + self.minSpeed)
        
        //랜덤으로 position 설정
        //self.maxX 사이의 난수
        let x = arc4random_uniform(self.maxX ?? 0 + 1 )
        self.position = CGPoint(x: Int(x), y: 0)
        
        //default
        self.radian = 0
        
        
    }
     
}
