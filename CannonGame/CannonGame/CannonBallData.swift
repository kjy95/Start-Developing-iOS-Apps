//
//  CannonBallData.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit
/**
 대포알 정보
 */
class CannonBallData {
    let maximumXPoint : CGFloat?
    let maximumYPoint : CGFloat?
    var cannonRadian : CGFloat?
    init(maximumXPoint: CGFloat, maximumYPoint: CGFloat, cannonRadian: CGFloat) {
        self.maximumXPoint = maximumXPoint
        self.maximumYPoint = maximumYPoint
        self.cannonRadian = cannonRadian
    }
}
