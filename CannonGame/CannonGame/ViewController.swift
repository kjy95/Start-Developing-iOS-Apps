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
    var triangleCannon : UIView?
    
    //MARK: handling data value
    //포탄 model
    var cannonBallData : CannonBallData?
    
    //초기 대포 transform
    var cannonIdentityTransfrom : CGAffineTransform?
    var cannonBallIdentityTransfrom : CGAffineTransform?
    //초기 삼각형포탄 transform
    var triCannonBallIdentityTransform : CGAffineTransform?
    
    //timer
    var timer : Timer?
    
    //MARK: VC lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---data handling value
        //timer 초기화
        timer = Timer()
        
        //화면 끝
        let maxXframe = self.view.frame.maxX
        let maxYframe = self.view.frame.maxY
        
        //button picker delegate 설정
        buttonPickerView.delegate = self
        
        //---대포
        //초기 대포 각도 변수 정의
        cannonIdentityTransfrom = cannon.transform
        //대포각도 초기화 (90도)
        cannon.transform = cannonIdentityTransfrom!.rotated(by: CGFloat.pi/2)
        
        //---포탄 가이드라인
        //초기화 (90도)
        cannonBallGuideLine.frame = CGRect(x: cannonBallGuideLine.frame.minX, y: cannonBallGuideLine.frame.minY, width: maxYframe * 2, height: 1);
        cannonBallGuideLine.center = cannon.center
        cannonBallGuideLine.transform = cannonIdentityTransfrom!.rotated(by: CGFloat.pi/2)
        
        
        //---포탄
        //포탄 위치 초기화
        cannonBall.center = cannonBallGuideLine.center
        
        //cannonBallData 데이터 저장
        cannonBallData = CannonBallData(maximumXPoint: maxXframe, initFrame: cannonBall.frame)
        
        //triangle 포탄 생성
        triangleCannon  = Triangle(frame: cannonBallData!.initFrame)
        triangleCannon?.isHidden = true
        triangleCannon?.backgroundColor =  UIColor.black
        triCannonBallIdentityTransform = triangleCannon?.transform.rotated(by: -(CGFloat.pi/2))
        cannonBallData?.radian =  CGFloat.pi / 2
        
        //포탄 뷰에 추가
        if let triangleCannon = self.triangleCannon{
            buttonPickerView.addSubview(triangleCannon)
        }
        
    }

    // MARK: Action
    //슬라이더 변환시 포탄 각도 변환.
    @IBAction func degreeValueChangedAction(_ sender: Any) {
        //움직인 슬라이더 값을 라디안으로 변환.
        //슬라이더 값: 왼쪽 - 가운데 - 오른쪽 == 0 - 0.5 - 1
        let radian = sliderValueToRadian(sliderValue: degreeSlider.value)
        //초기 대포 transform 옵셔널 바인딩
        if let cannonTransfrom = cannonIdentityTransfrom{
            //cannon rotate
            cannon.transform = cannonTransfrom.rotated(by: radian)
            //guide line rotate
            cannonBallGuideLine.transform = cannonTransfrom.rotated(by: radian)
            //포탄 rotate (사각형, 원)
            cannonBall.transform = cannonTransfrom.rotated(by: radian)
            //쏠 포탄(삼각형) rotate
            if let triangleCannon = triangleCannon{
                triangleCannon.transform = triCannonBallIdentityTransform!.rotated(by: radian)
            }
            //포탄 라디안 업데이트
            cannonBallData?.radian = radian
        }
    }
    
    //shoot버튼을 눌렀을 때
    @IBAction func tapShoot(_ sender: Any) {
        //포탄 모양
        let willShootCannonBall = getWillShootCannonShape()
        
        //포탄 transform
        if triangleCannon?.isHidden ?? true {
            willShootCannonBall.transform = willShootCannonBall.transform.rotated(by: cannonBallData?.radian ?? 0)
        }else{
            willShootCannonBall.transform = triCannonBallIdentityTransform!.rotated(by: cannonBallData?.radian ?? 0)
        }
        
        //add the view
        buttonPickerView.addSubview(willShootCannonBall)
        
        //create goal point view
        let tempGuideLine = UIView.init(frame: cannonBallGuideLine.frame)
        tempGuideLine.transform = cannonBallGuideLine.transform
        tempGuideLine.isHidden = true
        
        //add the view
        buttonPickerView.addSubview(tempGuideLine)
        
        //make timer paramater
        var timerParamater = [NSObject]()
        timerParamater.append(willShootCannonBall)
        timerParamater.append(tempGuideLine)
        
        //타이머 시작
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(shottingCannonBall(_:)), userInfo: timerParamater, repeats: true)
        (willShootCannonBall as! CannonBall).timer = timer
        
    }
    
    //MARK: 계산 값
    //슬라이더 값을 라디안 값으로 전환 후 리턴
    //슬라이더 값 -> 라디안 값 (-45 - 45도 처럼 보임)
    private func sliderValueToRadian(sliderValue: Float) -> CGFloat{
        let radian = CGFloat.pi/4 + (3*CGFloat.pi/4 - CGFloat.pi/4) * CGFloat(sliderValue)
        return radian
    }
    
    //쓸 포탄 리턴
    func getWillShootCannonShape() -> UIView{
        if triangleCannon?.isHidden ?? false {
            let tempCannonBall = CannonBall(frame: cannonBall.frame)
            tempCannonBall.layer.cornerRadius = cannonBall.layer.cornerRadius
            return tempCannonBall
        }else{
            let tempCannonBall = Triangle(frame: triangleCannon?.frame ?? cannonBall.frame)
            tempCannonBall.backgroundColor =  UIColor(white: 0, alpha: 0)
            return tempCannonBall
        }
    }
    
    //MARK: timer selector
    //timer func새로운 뷰를 만들어서 -초 간격으로 포탄가이드라인을 따라 -포인트 이동.
    @objc func shottingCannonBall(_ timerParamater: Timer){
        //paramater 변환
        let timerList = timerParamater.userInfo as! [UIView]
        let cannonBall = timerList[0]
        let cannonBallGuideLine = timerList[1]
        
        //지금 포탄 위치
        let currentBallLoc = buttonPickerView.convert(cannonBall.center, to: cannonBallGuideLine)
        //포탄위치 변환
        cannonBall.center = cannonBallGuideLine.convert(CGPoint(x: currentBallLoc.x-10, y: currentBallLoc.y), to: buttonPickerView)
        //포탄 변환 후 그 포탄의 위치
        let currentBallLocOfRootView = buttonPickerView.convert(cannonBall.center, to: nil)
        //print log
        print(currentBallLocOfRootView)
        
        //변환한 포탄 위치가 루트 뷰 프레임 밖으로 나갔을 때 remove view.
        if currentBallLocOfRootView.x < -15 || currentBallLocOfRootView.x > ((cannonBallData?.maximumXPoint)! + CGFloat(15))  || currentBallLocOfRootView.y < -15 {
            //타이머 멈춤
            (cannonBall as! CannonBall).timer?.invalidate()
            //(cannonBall as! Triangle).timer?.invalidate()
            //timer?[0].invalidate()
            //timer?.removeFirst()
            
            //뷰 없앰
            cannonBall.removeFromSuperview()
            cannonBallGuideLine.removeFromSuperview()
            print("remove")
        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Implementation of ButtonPicker's protocol method
    //
    
    //포탄 모양 바꾸기
    func changeShape(shape: String) {
        
        //버튼에 해당하는 모양으로 포탄 바꿈
        switch shape {
            
            case "triangle":
                triangleCannon?.isHidden = false
            
            case "circle":
                //원
                cannonBall.layer.cornerRadius = cannonBall.frame.size.width/2
                //삼각형 포탄 숨김
                triangleCannon?.isHidden = true
            
            case "rectangle":
                //사각형
                cannonBall.layer.cornerRadius = 0.0
                //삼각형 포탄 숨김
                triangleCannon?.isHidden = true
            
            default:
                print("default")
            
        }
    }
    
}

