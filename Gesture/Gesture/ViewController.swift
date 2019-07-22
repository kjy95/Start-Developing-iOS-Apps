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
                
                let v1 = sender.location(in: view)
                let v2 = preLoc
                let x = v1.x - v2.x
                let y = v1.y - v2.y
                print("\(v1.x)--\(v2.x)--\(x)")
                preLoc = v1
                targetView.frame.size.width = 100
                //
                //targetView.transform = targetView.transform.scaledBy(x:  1 + x/10 , y:   1 + y/10)
                //panRecogniezer.setTranslation(CGPoint.zero, in: targetView)
                
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
            /*//대각선
            let distance : CGFloat = sqrt(sender.location(in: view).x * targetView.center.x + sender.location(in: view).y * targetView.center.y);
            let frame = CGRect(x: sender.location(in: view).x, y: sender.location(in: view).y, width: <#T##CGFloat#>, height: targetView.center.y)
            targetView.frame =
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
            
            */
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
