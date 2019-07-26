//
//  ViewController.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ButtonPickerDelegate {
    
    //MARK: define UI
    @IBOutlet weak var cannonBall: UIView!
    @IBOutlet weak var cannonBallGuideLine: UIView!
    @IBOutlet weak var cannon: UIView!
    @IBOutlet weak var degreeSlider: UISlider!
    @IBOutlet weak var buttonPickerView: ButtonPicker!
    
    //handling data value
    var cannonBallData : CannonBallData?
    var cannonIdentityTransfrom : CGAffineTransform?
    
    //timer
    var timer : Timer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //초기 데이터
        let maxXframe = self.view.frame.maxX
        let maxYframe = self.view.frame.maxY
        
        //delegate
        buttonPickerView.delegate = self
        //초기 대포 각도 변수 정의
        cannonIdentityTransfrom = cannon.transform
        //대포각도 초기화 (90도)
        cannon.transform = cannonIdentityTransfrom!.rotated(by: CGFloat.pi/2)
        //포탄 가이드라인 초기화 (90도)
        cannonBallGuideLine.frame = CGRect(x: cannonBallGuideLine.frame.minX, y: cannonBallGuideLine.frame.minY, width: maxYframe * 2, height: 1);
        cannonBallGuideLine.center = cannon.center
        cannonBallGuideLine.transform = cannonIdentityTransfrom!.rotated(by: CGFloat.pi/2)
        //포탄 초기화
        cannonBall.center = cannonBallGuideLine.center
        
        //cannonBallData 데이터 저장
        cannonBallData = CannonBallData(maximumXPoint: maxXframe, initFrame: cannonBall.frame)
    }

    //슬라이더를 움직였을 때 라디안으로 값변환. 그 후 라디안값 데이터 저장.
    @IBAction func degreeValueChangedAction(_ sender: Any) {
        //슬라이더 값: 왼쪽 - 가운데 - 오른쪽 == 0 - 0.5 - 1
        let radian = sliderValueToRadian(sliderValue: degreeSlider.value)
        if let cannonTransfrom = cannonIdentityTransfrom{
            //cannon rotate
            cannon.transform = cannonTransfrom.rotated(by: radian)
            //guide line rotate
            cannonBallGuideLine.transform = cannonTransfrom.rotated(by: radian)
            //포탄 rotate
            cannonBall.transform = cannonTransfrom.rotated(by: radian) 
        }
    }
    
    //슬라이더 값 -> 라디안 값 (-45 - 45도 처럼 보임)
    private func sliderValueToRadian(sliderValue: Float) -> CGFloat{
        let radian = CGFloat.pi/4 + (3*CGFloat.pi/4 - CGFloat.pi/4) * CGFloat(sliderValue)
        return radian
    }
    
    @IBAction func tapShoot(_ sender: Any) {
        //timer start
        if let frame = cannonBallData?.initFrame{
            let tempCannonBall = CannonBall(frame: frame)
            print(tempCannonBall.frame)
            buttonPickerView.addSubview(tempCannonBall)
            timer = Timer()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(shottingCannonBall(_:)), userInfo: tempCannonBall, repeats: true)
        }
    }
    
    //timer func
    @objc func shottingCannonBall(_ tempCannonBall: Timer){
        let cannonBall = tempCannonBall.userInfo as! UIView
        print(cannonBall.frame)
        /*//currentBall copy
        let currentBallLoc = buttonPickerView.convert(cannonBall.center, to: cannonBallGuideLine)
        cannonBall.center = cannonBallGuideLine.convert(CGPoint(x: currentBallLoc.x-1, y: currentBallLoc.y), to: buttonPickerView)
        //remove view. 프레임 밖으로 포탄이 나갔을 때
        let currentBallLocOfRootView = buttonPickerView.convert(cannonBall.center, to: nil)
        //print log
        print(currentBallLocOfRootView)
        if currentBallLocOfRootView.x < -15 || currentBallLocOfRootView.x > ((cannonBallData?.maximumXPoint)! + CGFloat(15))  || currentBallLocOfRootView.y < -15 {
            //타이머 멈춤
            timer?.invalidate()
            //뷰 없앰
            cannonBall.removeFromSuperview()
        }*/
        /*/real---------
        //shotting
        let currentBallLoc = buttonPickerView.convert(cannonBall.center, to: cannonBallGuideLine)
        cannonBall.center = cannonBallGuideLine.convert(CGPoint(x: currentBallLoc.x-1, y: currentBallLoc.y), to: buttonPickerView)
        //remove view. 프레임 밖으로 포탄이 나갔을 때
        let currentBallLocOfRootView = buttonPickerView.convert(cannonBall.center, to: nil)
        //print log
        print(currentBallLocOfRootView)
        if currentBallLocOfRootView.x < -15 || currentBallLocOfRootView.x > ((cannonBallData?.maximumXPoint)! + CGFloat(15))  || currentBallLocOfRootView.y < -15 {
            //타이머 멈춤
            timer?.invalidate()
            //뷰 없앰
            cannonBall.removeFromSuperview() 
        }*/
    }
    
    //-------------------------------------------------------------
    // MARK: - Implementation of ButtonPicker's protocol method
    //
    func changeShape(shape: String) {
        //타이머 동작시(포탄 날아갈때) 모양 못바꿈.
        if !(timer?.isValid ?? false){
            switch shape {
            case "triangle":
                let cannonBall  = Triangle(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                cannonBall.backgroundColor = .blue
                cannonBall.center = cannonBall.center
                buttonPickerView.addSubview(cannonBall)
            case "circle":
                cannonBall.layer.cornerRadius = cannonBall.frame.size.width/2
            case "rectangle":
                cannonBall.layer.cornerRadius = 0.0
            default:
                print("default")
            }
        }
    }
}

