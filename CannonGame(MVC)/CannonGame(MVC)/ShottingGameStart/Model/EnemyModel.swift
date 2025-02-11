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
class EnemyModel: Hashable{
    //프로토콜 사용
    //dictionary key로 만들기 위한 함수.
    func hash(into hasher: inout Hasher) {}
    static func == (lhs: EnemyModel, rhs: EnemyModel) -> Bool {
        return lhs === rhs
    }
    
    //-------------------------------------------------------------
    //MARK: - define Value
    //

    //  위치
    var maxX : UInt32?
    var position : CGPoint
    
    // 벡터
    var vector : CGVector
    var radian : CGFloat
    
    // speed
    var maxSpeed : CGFloat = 0
    var minSpeed : CGFloat = 0
    var speed : CGFloat
    
    //체력
    var maxHealth : Int?
    var myHealth : Int = 0
    //-------------------------------------------------------------
    //MARK: - define function
    //

    //MARK: 초기화
    
    init(vector: CGVector, maxX: UInt32, maxSpeed: CGFloat, minSpeed: CGFloat, maxHealth: Int) {
        self.vector = vector
        self.maxX = maxX
        self.maxSpeed = maxSpeed
        self.minSpeed = minSpeed
        self.maxHealth = maxHealth
        self.myHealth = maxHealth
        
        //make my speed 
        self.speed = CGFloat(UInt(arc4random_uniform(UInt32(UInt(self.maxSpeed - self.minSpeed + 1))))) + minSpeed
        self.vector.dx *= speed
        self.vector.dy *= speed
        
        //랜덤으로 position 설정
        //self.maxX 사이의 난수
        let x = arc4random_uniform(self.maxX ?? 0 + 1 )
        self.position = CGPoint(x: Int(x), y: 0)
        
        //default
        self.radian = 0
        
    }
    
    //움직이기
    func moveEnemy(){
        position.x += vector.dx
        position.y += vector.dy
    }
    
    //체력 깎임
    func loseHealth(losePoint: Int) {
        self.myHealth -= losePoint
    }
    
    //자신의 체력이 0인지 확인
    func IsMyHealthZero()->Bool{
        if self.myHealth == 0{
            return true
        }
        return false
    }
}
