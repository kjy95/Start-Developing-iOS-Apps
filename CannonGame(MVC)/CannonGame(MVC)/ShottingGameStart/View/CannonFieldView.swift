//
//  CannonFieldView.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 30/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

/**
 대포 필드
 */
class CannonFieldView: UIView {
    
    //-------------------------------------------------------------
    //MARK: - define vlaue
    //
    
    //MARK: View
    //대포 struct
    @IBOutlet weak var cannon: UIView!
    @IBOutlet weak var cannonBallGuideLine: UIView!
    //포탄 struct
    @IBOutlet weak var triangleBall: TriangleView!
    @IBOutlet weak var commonBall: CannonBallView!
    
    //체력 바
    var healthSlider : HealthSlider?
    var healthLable : UILabel?
    
    var health: Int?
    //-------------------------------------------------------------
    //MARK: - define function
    //
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSlider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSlider()
    }
    
    
    //MARK: transform view, view shape
    
    func createSlider(){
        healthSlider = HealthSlider.init(frame: CGRect(x: 20, y: 20, width: self.frame.maxX / 3, height: 40))
        healthLable = UILabel.init(frame: CGRect(x: 20, y: 7, width: self.frame.maxX / 3, height: 40))
    }
    
    /*
     체력바 초기화
     */
    func healthSliderInit(health: Int){
        self.health = health
        //make health slider
        healthSlider?.getMaxHealth(maxHealth: health)
        self.addSubview(healthSlider!)
        //label
        healthLable?.text = "체력: \(health)"
        self.addSubview(healthLable!)
    }
    
    /*
     대포, 포탄 각도, 크기 초기화
     */
    func cannonFieldInit(radian : CGFloat){
        //---대포
        //대포각도 초기화 (90도)
        cannon.transform = cannon.transform.rotated(by: radian)
        
        //---포탄 가이드라인
        //초기화 (90도)
        cannonBallGuideLine.frame = CGRect(x: cannonBallGuideLine.frame.minX, y: cannonBallGuideLine.frame.minY, width: 1000 * 2, height: 1);
        cannonBallGuideLine.center = cannon.center
        cannonBallGuideLine.transform = cannonBallGuideLine.transform.rotated(by: radian)
    }
    
    /*
     대포 회전할 때 관련 요소 모두 회전
     */
    func roateCannonStruct(radian: CGFloat){
        cannonBallGuideLine.transform = CGAffineTransform.identity.rotated(by: radian)
        cannon.transform = CGAffineTransform.identity.rotated(by: radian)
        triangleBall.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
        commonBall.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
    }
    
    /*
     포탄 바꾸기
     사각형 또는 원, 삼각형 포탄 보이기
     */
    func showChangeCannonBallType(type :String){
        switch type {
        case "triangle":
            commonBall.isHidden = true
            triangleBall.isHidden = false
            
        case "circle":
            triangleBall.isHidden = true
            commonBall.isHidden = false
            //원
            commonBall.layer.cornerRadius = commonBall.frame.size.width/2
            
        case "rectangle":
            triangleBall.isHidden = true
            commonBall.isHidden = false
            //사각형
            commonBall.layer.cornerRadius = 0.0
            
        default:
            print("default")
            
        }
    }
    
    //잃은 체력만큼 슬라이더 값 움직임     
    func loseHealth(losePoint:Int){
        self.health = self.health! - losePoint
        self.healthSlider?.loseHealth(losePoint: losePoint)  
        healthLable?.text = "체력: \(health!)"
    }
    
}
