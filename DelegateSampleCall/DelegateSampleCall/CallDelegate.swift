//
//  CallDelegate.swift
//  DelegateSampleCall
//
//  Created by Vimosoft on 24/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

protocol ViewDelegate: class {
    func didFinishTask()
}

class CallDelegate: NSObject {
    
    weak var delegate : ViewDelegate?
    
    /**
     * ViewDelegate call
     */
    func call() {
        delegate?.didFinishTask()
    }
    
} 
