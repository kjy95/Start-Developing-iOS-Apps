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
    var timer : [Timer]?
    //cannon goal point
    var goalPoint : [CGPoint]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //timer 초기화
        timer = [Timer]()
        goalPoint = [CGPoint]()
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
            //creat cannon ball
            let tempCannonBall = CannonBall(frame: frame)
            tempCannonBall.layer.cornerRadius = cannonBall.layer.cornerRadius
            //add the view
            buttonPickerView.addSubview(tempCannonBall)
            
            //create goal point view
            let tempGuideLine = UIView.init(frame: cannonBallGuideLine.frame)
            tempGuideLine.transform = cannonBallGuideLine.transform
            tempGuideLine.isHidden = true
            //add the view
            buttonPickerView.addSubview(tempGuideLine)
            
            //make timer paramater
            var timerParamater = [UIView]()
            timerParamater.append(tempCannonBall)
            timerParamater.append(tempGuideLine)
            
            //타이머 시작
            timer?.append(Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shottingCannonBall(_:)), userInfo: timerParamater, repeats: true))
        }
    }
    //timer func
    @objc func shottingCannonBall(_ timerParamater: Timer){
        //paramater 변환
        let timerList = timerParamater.userInfo as! [UIView]
        let cannonBall = timerList[0]
        let cannonBallGuideLine = timerList[1]
        
        let currentBallLoc = buttonPickerView.convert(cannonBall.center, to: cannonBallGuideLine)
        
        cannonBall.center = cannonBallGuideLine.convert(CGPoint(x: currentBallLoc.x-10, y: currentBallLoc.y), to: buttonPickerView)
        
        //remove view. 프레임 밖으로 포탄이 나갔을 때
        let currentBallLocOfRootView = buttonPickerView.convert(cannonBall.center, to: nil)
        //print log
        print(currentBallLocOfRootView)
        if currentBallLocOfRootView.x < -15 || currentBallLocOfRootView.x > ((cannonBallData?.maximumXPoint)! + CGFloat(15))  || currentBallLocOfRootView.y < -15 {
            //타이머 멈춤
            timer?[0].invalidate()
            timer?.removeFirst()
            print("remove")
            //뷰 없앰
            cannonBall.removeFromSuperview()
        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Implementation of ButtonPicker's protocol method
    //
    func changeShape(shape: String) {
        //타이머 동작시(포탄 날아갈때) 모양 못바꿈.
        /*if !(timer?.isValid ?? false){*/
            switch shape {
            case "triangle":
                let cannonBall  = Triangle(frame: cannonBallData!.initFrame)
                cannonBall.center = cannonBall.center
                buttonPickerView.addSubview(cannonBall)
            case "circle":
                cannonBall.layer.cornerRadius = cannonBall.frame.size.width/2
            case "rectangle":
                cannonBall.layer.cornerRadius = 0.0
            default:
                print("default")
            }
        /*}*/
    }
}

