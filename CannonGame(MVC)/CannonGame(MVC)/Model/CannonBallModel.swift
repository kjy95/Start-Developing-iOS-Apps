//
//  GameModel.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 포탄 데이터
 */
class CannonBallModel : Hashable{
    //프로토콜 사용
    //dictionary key로 만들기 위한 함수.
    func hash(into hasher: inout Hasher) {}
    static func == (lhs: CannonBallModel, rhs: CannonBallModel) -> Bool {
        return lhs === rhs
    }
    
    //-------------------------------------------------------------
    //MARK: - define value
    //
    
    //포탄 현재 센터 위치
    var position : CGPoint
    
    //var key : Int
    var type : String
    
    //포탄 벡터
    var vector = CGVector()
    var radian : CGFloat
    
    //-------------------------------------------------------------
    //MARK: - define function
    //
    
    //MARK: 초기화
    init(currentLoc: CGPoint, vector: CGVector, radian: CGFloat, type: String) {
        self.vector = vector
        self.position = currentLoc
        self.radian = radian
        self.type = type
    }
    
    //MARK: change value
    
    //포탄 위치를 벡터값을 이용해서 바꿈
    func moveCannonBall(){
        position.x += vector.dx
        position.y += vector.dy
    } 
}
