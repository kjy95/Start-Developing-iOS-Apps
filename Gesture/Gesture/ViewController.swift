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
    @IBOutlet weak var rotateScale: UIButton!
    var panRecogniezer : UIPanGestureRecognizer!
    var panRotateRecogniezer : UIPanGestureRecognizer!
    var rotateRecogniezer : UIRotationGestureRecognizer!
    var pinchRecogniezer : UIPinchGestureRecognizer!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        panRecogniezer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        panRotateRecogniezer = UIPanGestureRecognizer(target: self, action: #selector(panRotateAction(_ :)))
        
        rotateRecogniezer = UIRotationGestureRecognizer(target: self, action: #selector( rotateAction(_ :)))
        pinchRecogniezer = UIPinchGestureRecognizer(target: self, action: #selector( pinchAction(_ :)))
        panRotateRecogniezer.delegate = self
        panRecogniezer.delegate = self
        pinchRecogniezer.delegate = self
        
        
        targetView.addGestureRecognizer(panRecogniezer)
        //targetView.addGestureRecognizer(panRotateRecogniezer)
        
        //완료
        targetView.addGestureRecognizer(rotateRecogniezer)
        targetView.addGestureRecognizer(pinchRecogniezer)
        
      
        // Do any additional setup after loading the view.
    }
   
    @IBAction func touchdown(_ sender: Any) {
        isButtonClicked = true
    }
    @IBAction func touchupInside(_ sender: Any) {
        isButtonClicked = false
    }
    var preLoc = CGPoint(x: 0, y: 0)
    @objc func panAction(_ sender : UIPanGestureRecognizer){
        if isButtonClicked{
            print("y")
            switch(sender.state){
            case .began:
                preLoc = sender.location(in: view)
                print("began")
            case .changed:
               
                //반 너비
                let halfWidth =  sender.location(in: view).x - targetView.center.x
                //반 높이
                let halfHight =  sender.location(in: view).y - targetView.center.y
                let x = targetView.center.x - halfWidth
                let y = targetView.center.y - halfHight
                //뒤집히지 않게
                if halfHight < 0 || halfWidth<0{break}
                let frame = CGRect(x: x, y: y, width: halfWidth*2, height: halfHight*2)
                targetView.frame = frame
                
            case .ended:
                print("end")
            case .cancelled:
                print("cancelled")
            case .failed:
                print("cancelled")
            default:
                break
            }
        }
        
    }
    
    var previoutLoc = CGPoint(x: 0, y: 0)
    
    @objc func panRotateAction(_ sender : UIPanGestureRecognizer){
        //var previoutLoc = CGPoint(x: 0, y: 0)
        if isButtonClicked{
            
            switch(sender.state){
            case .began:
                previoutLoc = sender.location(in: view)
                print("began")
            case .changed:
                print("changed")
                let currentLoc = sender.location(in: view)
                print(previoutLoc)
                print(currentLoc)
                let v1 = CGVector(dx: previoutLoc.x - targetView.center.x, dy: previoutLoc.y - targetView.center.y)
                let v2 = CGVector(dx: currentLoc.x - targetView.center.x, dy: currentLoc.y - targetView.center.y)
                previoutLoc = currentLoc
                let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
                targetView.transform = targetView.transform.rotated(by: angle)
            case .ended:
                print("end")
            case .cancelled:
                print("cancelled")
            case .failed:
                print("cancelled")
            default:
                break
            }
            
            
        }

    }
    
    @objc func rotateAction(_ sender : UIRotationGestureRecognizer){
        print("print\(isButtonClicked)")
        targetView.transform = targetView.transform.rotated(by: sender.rotation)
        sender.rotation = 0.0
    }
    
    @objc func pinchAction(_ sender : UIPinchGestureRecognizer){
        print("pinchpinchAction")
        targetView.transform = targetView.transform.scaledBy(x:  sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
