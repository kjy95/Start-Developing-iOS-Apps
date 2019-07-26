//
//  CannonBallData.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit
/**
 대포알 발사를 위한 정보 저장
 */
class CannonBallData {
    let maximumXPoint : CGFloat?
    let initFrame : CGRect
    init(maximumXPoint: CGFloat, initFrame: CGRect) {
        self.maximumXPoint = maximumXPoint
        self.initFrame = initFrame
    }
}
