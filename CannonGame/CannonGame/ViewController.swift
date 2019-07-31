//
//  ViewController.swift
//  CannonGame
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ButtonPickerDelegate {
    
    //-------------------------------------------------------------
    //MARK: - VALUE
    //MARK: define UI
    //
    
    @IBOutlet weak var cannonBall: UIView!
    @IBOutlet weak var cannonBallGuideLine: UIView!
    @IBOutlet weak var cannon: UIView!
    @IBOutlet weak var degreeSlider: UISlider!
    @IBOutlet weak var buttonPickerView: ButtonPicker!
    var triangleCannon : UIView?
    
    //------------------------------------------------------------
    //MARK: handling data value
    //
    
    //포탄 model
    var cannonBallData : CannonBallData?
    
    //transform
    //초기 대포 transform
    var cannonIdentityTransfrom : CGAffineTransform?
    //초기 포탄 transform
    var cannonBallIdentityTransform : CGAffineTransform?
    
    //timer
    var timer : Timer?
    
    //-------------------------------------------------------------
    //MARK: - FUNCTION
    //MARK: VC lifeCycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---data handling value
        //timer 초기화
        timer = Timer()
        
        //화면 끝나는 포인트
        let maxX = self.view.frame.maxX
        let maxY = self.view.frame.maxY
        
        //button picker delegate 설정
        buttonPickerView.delegate = self
        
        //---대포
        //초기 대포 각도 변수 정의
        cannonIdentityTransfrom = cannon.transform
        //대포각도 90도 회전
        cannon.transform = cannonIdentityTransfrom!.rotated(by: CGFloat.pi/2)
        
        //---포탄 가이드라인
        //90도 회전
        cannonBallGuideLine.frame = CGRect(x: cannonBallGuideLine.frame.minX, y: cannonBallGuideLine.frame.minY, width: maxY * 2, height: 1);
        cannonBallGuideLine.center = cannon.center
        cannonBallGuideLine.transform = cannonIdentityTransfrom!.rotated(by: CGFloat.pi/2)
        
        //---포탄
        //포탄 위치 초기화
        cannonBall.center = cannonBallGuideLine.center
        
        //cannonBallData 데이터 저장
        cannonBallData = CannonBallData(maximumXPoint: maxX, initFrame: cannonBall.frame)
        
        //triangle 포탄 생성
        triangleCannon = Triangle(frame: cannonBallData!.initFrame)
        triangleCannon?.isHidden = true
        triangleCannon?.backgroundColor = UIColor.black
        cannonBallIdentityTransform = triangleCannon?.transform.rotated(by: -(CGFloat.pi/2))
        
        //포탄 뷰에 추가
        if let triangleCannon = self.triangleCannon{
            buttonPickerView.addSubview(triangleCannon)
        }
        
    }
    //-------------------------------------------------------------
    // MARK: Action - 1. degree slider 2. shootbutton,
    //
    
    /*
     1. degree slider
        슬라이더 조작시 포탄틀, 포탄 가이드라인 각도 변환.
        해당 라디안을 cannonBallData에 저장.
     */
    @IBAction func degreeValueChangedAction(_ sender: Any) {
        //움직인 슬라이더 값을 라디안으로 받음.
        let radian = sliderValueToRadian(sliderValue: degreeSlider.value)
        //초기 대포 transform 옵셔널 바인딩
        if let cannonTransfrom = cannonIdentityTransfrom{
            //cannon rotate
            cannon.transform = cannonTransfrom.rotated(by: radian)
            //guide line rotate
            cannonBallGuideLine.transform = cannonTransfrom.rotated(by: radian)
            //포탄 rotate
            cannonBall.transform = cannonBallIdentityTransform!.rotated(by: radian)
            //포탄(삼각형) rotate
            if let triangleCannon = triangleCannon{
                triangleCannon.transform = cannonBallIdentityTransform!.rotated(by: radian)
            }
            //포탄 라디안 업데이트
            cannonBallData?.radian = radian
        }
    }
    
    /*
     2. shootbutton
        포탄 발사버튼 클릭시 액션
        포탄 모양에 맞춰 포탄을 발사.
     */
    @IBAction func tapShoot(_ sender: Any) {
        //선택 모양에 맞게 포탄 생성
        let willShootCannonBall = getWillShootCannonShape()
        
        //포탄 transform (회전)
        willShootCannonBall.transform = cannonBallIdentityTransform!.rotated(by: cannonBallData?.radian ?? CGFloat.pi / 2)
        
        //설명한 포탄을 뷰에 add
        buttonPickerView.addSubview(willShootCannonBall)
        
        //create guideLine view
        let tempGuideLine = UIView.init(frame: cannonBallGuideLine.frame)
        tempGuideLine.transform = cannonBallGuideLine.transform
        tempGuideLine.isHidden = true
        
        //add the view
        buttonPickerView.addSubview(tempGuideLine)
        
        //make timer paramater
        var timerParamater = [UIView]()
        timerParamater.append(willShootCannonBall)
        timerParamater.append(tempGuideLine)
        
        //타이머 시작
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(shottingCannonBall(_:)), userInfo: timerParamater, repeats: true)
        //타이머를 포탄에 붙임.
        (willShootCannonBall as! CannonBall).timer = timer
    }
    
    //-------------------------------------------------------------
    //MARK: 계산 값 반환 함수들
    //
    
    /*
     라디안 값 반환
     슬라이더 값을 라디안 값으로 전환 후 리턴
    */
    private func sliderValueToRadian(sliderValue: Float) -> CGFloat{
        let radian = CGFloat.pi/4 + (CGFloat.pi/2) * CGFloat(sliderValue)
        return radian
    }
    
    /*
     쓸 포탄 뷰 리턴
     포탄 생성후 모양설정
     */
    func getWillShootCannonShape() -> UIView{
        //사각형, 원 포탄을 쏠 거라면
        if triangleCannon?.isHidden ?? true {
            //쏠 탄환 생성
            let tempCannonBall = CannonBall(frame: cannonBall.frame)
            //모양 설정
            tempCannonBall.layer.cornerRadius = cannonBall.layer.cornerRadius
            return tempCannonBall
        }else{ //삼각형 포탄을 쏠 거라면
            //쏠 탄환 생성
            let tempCannonBall = Triangle(frame: cannonBall.frame)
            tempCannonBall.backgroundColor =  UIColor(white: 0, alpha: 0)
            return tempCannonBall
        }
    }
    
    //-------------------------------------------------------------
    //MARK: timer selector
    //
    
    //timer func새로운 뷰를 만들어서 -초 간격으로 포탄가이드라인을 따라 -포인트 이동.
    @objc func shottingCannonBall(_ timerParamater: Timer){
        //paramater 변환
        let timerList = timerParamater.userInfo as! [UIView]
        let cannonBall = timerList[0]
        let cannonBallGuideLine = timerList[1]
        
        //지금 포탄 위치
        let currentBallLoc = buttonPickerView.convert(cannonBall.center, to: cannonBallGuideLine)
        //포탄위치 변환
        cannonBall.center = cannonBallGuideLine.convert(CGPoint(x: currentBallLoc.x - 5, y: currentBallLoc.y), to: buttonPickerView)
        //포탄 변환 후 그 포탄의 위치
        let currentBallLocOfRootView = buttonPickerView.convert(cannonBall.center, to: nil)
        //print log
        print(currentBallLocOfRootView)
        
        //변환한 포탄 위치가 루트 뷰 프레임 밖으로 나갔을 때 remove view.
        if currentBallLocOfRootView.x < -15 || currentBallLocOfRootView.x > ((cannonBallData?.maximumXPoint)! + CGFloat(15))  || currentBallLocOfRootView.y < -15 {
            //타이머 멈춤
            (cannonBall as! CannonBall).timer?.invalidate()
            
            //뷰 없앰
            cannonBall.removeFromSuperview()
            cannonBallGuideLine.removeFromSuperview()
            print("remove")
        }
    }
    
    //-------------------------------------------------------------
    // MARK: - Implementation of ButtonPicker's protocol method
    //
    
    //포탄 모양 틀 바꾸기
    func changeShape(shape: String) {
        
        //버튼에 해당하는 모양으로 포탄 바꿈
        switch shape {
            
            case "triangle":
                //삼각형 포탄 나타냄.
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
