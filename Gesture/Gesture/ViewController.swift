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
    var isRotateScaleButtonClicked = false
    var isRotateButtonClicked = false
    @IBOutlet weak var rotateScale: UIButton!
    @IBOutlet weak var rotatebutton: UIButton!
    
    
    var panRecogniezer : UIPanGestureRecognizer!
    var panRotateRecogniezer : UIPanGestureRecognizer!
    var rotateRecogniezer : UIRotationGestureRecognizer!
    var pinchRecogniezer : UIPinchGestureRecognizer!
    //뷰 움직임
    var longPressRecognizer : UILongPressGestureRecognizer!
    var panLocRecognizer : UIPanGestureRecognizer!
    //root view tap
    var rootViewTapRecognizer : UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //long press
        panRecogniezer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        panRotateRecogniezer = UIPanGestureRecognizer(target: self, action: #selector(panRotateAction(_ :)))
        
        rotateRecogniezer = UIRotationGestureRecognizer(target: self, action: #selector( rotateAction(_ :)))
        pinchRecogniezer = UIPinchGestureRecognizer(target: self, action: #selector( pinchAction(_ :)))
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector( longPressAction(_ :)))
        panLocRecognizer = UIPanGestureRecognizer(target: self, action: #selector( panLocAction(_ :)))
        rootViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector( tapRootViewAction(_ :)))
        longPressRecognizer.minimumPressDuration = 0.001
        panRotateRecogniezer.delegate = self
        panRecogniezer.delegate = self
        pinchRecogniezer.delegate = self
        longPressRecognizer.delegate = self
        //tap root view
        self.view.addGestureRecognizer(rootViewTapRecognizer)
        
        //pan rotate, scale -> todo
        targetView.addGestureRecognizer(panRecogniezer)
        targetView.addGestureRecognizer(panRotateRecogniezer)
        
        //완료
        targetView.addGestureRecognizer(rotateRecogniezer)
        targetView.addGestureRecognizer(pinchRecogniezer)
        
        //view move
        targetView.addGestureRecognizer(longPressRecognizer)
        targetView.addGestureRecognizer(panLocRecognizer)
        
        //button hide
        rotatebutton.isHidden = true
        rotateScale.isHidden = true
        
        // Do any additional setup after loading the view.
    }
   
    //roate and scale button action
    @IBAction func touchdown(_ sender: Any) {
        isRotateScaleButtonClicked = true
    }
    //roate button action
    @IBAction func touchDown(_ sender: Any) {
        print("touchDown")
        isRotateButtonClicked = true
    }
    
    var preLoc = CGPoint(x: 0, y: 0)
    @objc func panAction(_ sender : UIPanGestureRecognizer){
        if isRotateScaleButtonClicked{
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
    @objc func longPressAction(_ sender : UILongPressGestureRecognizer){
        switch(sender.state){
            case .began:
                 print("began")
            case .changed:
                print("changed")
            case .ended:
                print("end")
                rotatebutton.isHidden = false
                rotateScale.isHidden = false
            case .cancelled:
                print("cancelled")
            case .failed:
                print("failed")
            default:
                break
        }
    }
    @objc func panLocAction(_ sender : UIPanGestureRecognizer){
        switch(sender.state){
        case .began:
            print("began")
            rotatebutton.isHidden = false
            rotateScale.isHidden = false
        case .changed:
            print(isRotateButtonClicked)
            print(isRotateScaleButtonClicked)
            if !isRotateButtonClicked && !isRotateScaleButtonClicked{
             
                let transition = sender.translation(in: targetView)
                let changedX = targetView.center.x + transition.x
                let changedY = targetView.center.y + transition.y
                targetView.center = CGPoint(x: changedX, y: changedY)
                sender.setTranslation(CGPoint.zero, in: targetView)
                
            }
        case .ended:
            print("end")
            isRotateButtonClicked = false
            isRotateScaleButtonClicked = false
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        default:
            break
        }
    }
    
    @objc func panRotateAction(_ sender : UIPanGestureRecognizer){
        //var previoutLoc = CGPoint(x: 0, y: 0)
        if isRotateScaleButtonClicked || isRotateButtonClicked{
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
                isRotateScaleButtonClicked = false
                isRotateButtonClicked = false
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
        print("print\(isRotateScaleButtonClicked)")
        targetView.transform = targetView.transform.rotated(by: sender.rotation)
        sender.rotation = 0.0
    }
    
    @objc func pinchAction(_ sender : UIPinchGestureRecognizer){
        print("pinchpinchAction")
        targetView.transform = targetView.transform.scaledBy(x:  sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    @objc func tapRootViewAction(_ sender : UITapGestureRecognizer){
        rotatebutton.isHidden = true
        rotateScale.isHidden = true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
