//
//  ViewController.swift
//  DelegateSampleCall
//
//  Created by Vimosoft on 24/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
import UIKit

class ViewController: UIViewController , ViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData();
    }
    
    
    /**
     * 데이터 초기화
     */
    func initData() {
        
        let callDelegate = CallDelegate()
        callDelegate.delegate = self
        callDelegate.call()
    }
    
    
    /**
     * delegate call
     */
    func didFinishTask() {
        print(">>> didFinishTask")
    }
    
}

 
