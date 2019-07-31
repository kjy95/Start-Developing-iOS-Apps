//
//  ViewController.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CannonControlViewDelegate {
    
    let potentialCannonSpeed : CGFloat = 10
    
    //-------------------------------------------------------------
    //MARK: - Define Value
    //
    
    //MARK: View
    @IBOutlet weak var cannonControlView: CannonControlView!
    @IBOutlet weak var cannonFieldView: CannonFieldView!
    
    //MARK: Model
    //대포 모델
    var cannonStructModel : CannonStructModel?
    
    //MARK: value
    var timer : Timer = Timer()

    //mapping two object
    var cannonBallViewMap = [CannonBallModel:UIView]()
    
    //-------------------------------------------------------------
    //MARK: - Define FUNCTION
    //
    
    //MARK: VC lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        cannonControlView.delegate = self
        
        //init cannonModel
        cannonStructModel = CannonStructModel.init(currentLoc: cannonFieldView.cannon.center, frame: cannonFieldView.commonBall.frame)
        cannonStructModel?.updateCannonVector(radian: CGFloat.pi/2, speed: potentialCannonSpeed)
        
        //cannonModel 데이터를 사용하는 cannonFieldView init
        cannonFieldView.cannonFieldInit(radian: cannonStructModel?.radian ?? CGFloat.pi/2)
        
        //timer setting
        //cannonball timer
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(changeCannonBallPosition), userInfo: nil, repeats: true)
        //enemy timer
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(changeEnemyPosition), userInfo: nil, repeats: true)
    }
    
    //-------------------------------------------------------------
    // MARK: - Implementation of CannonContorlView's protocol method
    //
    
    /*
     포탄 type 바꾸기
     버튼에 해당하는 type으로 포탄model의 type 바꿈
     그 후 뷰도 해당 타입으로 변환.
     */
    func changeType(type: String) {
        //MODEL UPDATE
        cannonStructModel?.type = type
        
        //VIEW UPDATE
        cannonFieldView.showChangeCannonBallType(type: type)
    }
    
    //change slider value
    func changeDegreeCannon(sliderValue: Float) {
        //움직인 슬라이더 값을 라디안으로 변환.
        let radian = sliderValueToRadian(sliderValue: sliderValue)
        
        //Model update : 대포, 포탄 라디안 업데이트
        cannonStructModel?.updateCannonVector(radian: radian, speed: potentialCannonSpeed)
        
        //View update : cannonStructView rotate
        cannonFieldView.roateCannonStruct(radian: radian)
    }
    
    //tap fire
    func fireCannonBall(){
        
        //CREATE MODEL
        
        /**
         define value
         cannonBallModel생성시 필요한 값들을 cannonStructModel에서 가져옴.
         */
        let currentCannonLoc = cannonStructModel?.currentLoc ?? CGPoint(x: 0, y: 0)
        let cannonVector = cannonStructModel?.vector ?? CGVector(dx: 0, dy: 0)
        let radian = cannonStructModel?.radian ?? 0
        let type = cannonStructModel?.type ?? "rectangle"
        
        //위에서 정의한 값으로 cannonBallModel 생성
        let cannonBallModel = CannonBallModel(currentLoc: currentCannonLoc, vector: cannonVector, radian: radian, type: type)
        
        //CREATE VIEW

        var cannonBallView = CannonBallView()
        //cannonballview's frame
        let cannonballviewFrame = cannonStructModel?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        //type에 맞게 view 모양 변환
        switch type {
            case "rectangle":
                cannonBallView = CannonBallView(frame: cannonballviewFrame)
            
            case "circle":
                cannonBallView = CannonBallView(frame: cannonballviewFrame)
                cannonBallView.circleView()
            
            case "triangle":
                cannonBallView = TriangleView(frame: cannonballviewFrame)
            
            default:
                cannonBallView = CannonBallView(frame: cannonballviewFrame)
        }
        //현재 대포 각도에 맞게 회전
        cannonBallView.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
        //뷰 추가
        self.cannonFieldView.addSubview(cannonBallView)
        
        //RECORD IN DICTIONARY
        cannonBallViewMap[cannonBallModel] = cannonBallView
    }
    
    //-------------------------------------------------------------
    //MARK: - timer selector
    //
    
    @objc func changeCannonBallPosition(){
        for (cannonBallModel,view) in cannonBallViewMap{
            moveOrRemove(cannonBallModel: cannonBallModel, cannonBallView: view)
        }
    }
    
    @objc func changeEnemyPosition(){
        for (cannonBallModel,view) in cannonBallViewMap{
            moveOrRemove(cannonBallModel: cannonBallModel, cannonBallView: view)
        }
    }
    //-------------------------------------------------------------
    //MARK: - 계산 함수
    //
    
    /**
     슬라이더 값을 라디안 값으로 전환 후 리턴
     슬라이더 값 -> 라디안 값 (-45 - 45도 처럼 보임)
    */
    private func sliderValueToRadian(sliderValue: Float) -> CGFloat{
        let radian = CGFloat.pi/4 + (CGFloat.pi/2) * CGFloat(sliderValue)
        return radian
    }
    
    /**
     view위치 바꾸기
     만약 핸드폰 프레임을 벗어나면 데이터, view 제거.
     - timer selector에서 사용
     */
    func moveOrRemove(cannonBallModel : CannonBallModel, cannonBallView: UIView){
        //UPDATE MODEL - cannonballModel position
        cannonBallModel.moveCannonBall()
        //UPDATE VIEW - cannonballview position
        cannonBallView.center = cannonBallModel.position
        
        //수퍼뷰 관점에서 포탄 위치
        let currentBallLoc = cannonFieldView.convert(cannonBallViewMap[cannonBallModel]?.center ?? CGPoint(x: 0, y: 0), to: nil)
        print(currentBallLoc)
        //화면 밖으로 나가면
        if currentBallLoc.x <= 0 || currentBallLoc.x >= ((self.view.frame.maxX) + CGFloat(0))  || currentBallLoc.y <= 0 {
            print("제거")
            //REMOVE MODEL
            cannonBallViewMap.removeValue(forKey: cannonBallModel)
            //REMOVE VIEW
            cannonBallView.removeFromSuperview()
            
        }
    } 
}

