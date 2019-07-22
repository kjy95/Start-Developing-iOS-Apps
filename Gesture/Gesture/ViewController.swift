//
//  ViewController.swift
//  Gesture
//
//  Created by Vimosoft on 18/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var tempPoint :CGPoint!
    @IBOutlet weak var targetView: UIView!
    var isButtonClicked = false
    var panRecogniezer : UIPanGestureRecognizer!
    var rotateRecogniezer : UIRotationGestureRecognizer!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        panRecogniezer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        rotateRecogniezer = UIRotationGestureRecognizer(target: self, action: #selector( rotateAction(_ :)))
        panRecogniezer.delegate = self
        targetView.addGestureRecognizer(panRecogniezer)
        targetView.addGestureRecognizer(rotateRecogniezer)
        
        
      
        // Do any additional setup after loading the view.
    }
    @IBAction func scaleAndRotate(_ sender: Any) {
        isButtonClicked = false
    }
    
    @IBAction func touchdown(_ sender: Any) {
        isButtonClicked = true
    }
    
    @objc func panAction(_ sender : UIPanGestureRecognizer){
        if isButtonClicked{
            let translation = sender.translation(in: targetView)
            targetView.transform = targetView.transform.scaledBy(x: 1 + translation.x/100, y: 1 + translation.y/100)
            panRecogniezer.setTranslation(CGPoint.zero, in: targetView)
        }
    }
    
    @objc func rotateAction(_ sender : UIRotationGestureRecognizer){
        print("print\(isButtonClicked)")
        targetView.transform = targetView.transform.rotated(by: sender.rotation)
        
        sender.rotation = 0.0
        print("rotate")
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        return true
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        tempPoint = touches.previousLocation(in: targetView)
        let touch = touches.first
        print(touch!.location(in: targetView))
        if isButtonClicked{
            let position = touch!.location(in: targetView)
            let target = targetView.center
            let angle = atan2(target.y-position.y, target.x-position.x)
            targetView.transform = CGAffineTransform(rotationAngle: angle)
            
        }
    }
    
    /*@IBAction func roate(_ gesture: UIPanGestureRecognizer) {
        print("roate")
        switch gesture.state {
        case .began:
        print("began")// Code
        case .changed:
        print("changed")// Code
        case .ended:
       print("ended") // Code
        case .cancelled :
        print("cancelled")// Code
        default:
            // Code
            break
        }*/
    }

