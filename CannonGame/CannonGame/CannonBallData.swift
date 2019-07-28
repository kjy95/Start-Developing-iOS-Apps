//
//  CannonBallData.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit
/**
 대포알 데이터
 생성, 제거 정보
 */
class CannonBallData {
    
    //화면 경계. 포탄을 제거할 때 필요한 정보.
    let maximumXPoint : CGFloat?
    
    //포탄 프레임
    let initFrame : CGRect
    
    //포탄 각도
    var radian : CGFloat?
    
    //초기화
    init(maximumXPoint: CGFloat, initFrame: CGRect) {
        self.maximumXPoint = maximumXPoint
        self.initFrame = initFrame
    }
    
}
