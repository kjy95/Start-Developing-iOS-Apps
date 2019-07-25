//
//  CannonBallData.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import Foundation
/**
 대포알 정보
 */
class CannonBallData {
    let maximumXPoint : Float?
    let maximumYPoint : Float?
    var cannonRadian : Float?
    init(maximumXPoint: Float, maximumYPoint: Float, cannonRadian:Float) {
        self.maximumXPoint = maximumXPoint
        self.maximumYPoint = maximumYPoint
        self.cannonRadian = cannonRadian
        
    }
}
