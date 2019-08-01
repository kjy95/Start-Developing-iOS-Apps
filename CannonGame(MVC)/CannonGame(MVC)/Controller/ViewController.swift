//
//  ViewController.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CannonControlViewDelegate, GamePauseViewDelegate {
    
    
  
    //-------------------------------------------------------------
    //MARK: - Define Value
    //
    
    //MARK: View
    @IBOutlet weak var cannonControlView: CannonControlView!
    @IBOutlet weak var cannonFieldView: CannonFieldView!
    @IBOutlet weak var gamePauseView: GamePauseView!
    
    //MARK: Model
    //대포 모델
    var cannonStructModel : CannonStructModel?
    
    //MARK: value
    var timer = [Timer]()

    //mapping two object
    var cannonBallViewMaps = [CannonBallModel:UIView]()
    var enemyViewMaps = [EnemyModel:[UIView]]()
    
    //상수 선언
    let potentialCannonSpeed : CGFloat = 12
    let cannonHealth : Int = 3
    let potentialEnemyMaxSpeed : CGFloat = 2
    let potentialEnemyMinSpeed : CGFloat = 1
    let enemyHealth : Int = 2
    let enemyAttackPower : Int = 1
    let enemyCreateTimeSpeed : Int = 1
    //-------------------------------------------------------------
    //MARK: - Define FUNCTION
    //
    
    //MARK: VC lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        cannonControlView.delegate = self
        gamePauseView.delegate = self
        
        self.cannonFieldView.bringSubviewToFront(gamePauseView)
        //init cannonModel
        cannonStructModel = CannonStructModel.init(currentLoc: cannonFieldView.cannon.center, frame: cannonFieldView.commonBall.frame, health: cannonHealth )
        cannonStructModel?.updateCannonVector(radian: CGFloat.pi/2, speed: potentialCannonSpeed)
        
        //cannonModel 데이터를 사용하는 cannonFieldView init
        cannonFieldView.cannonFieldInit(radian: cannonStructModel?.radian ?? CGFloat.pi/2)
        
        setStartGameCannonHealthData()
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
        cannonBallViewMaps[cannonBallModel] = cannonBallView
    }
    
    
    func startAllTimer() {
        //data reset
        setStartGameCannonHealthData()
        //view contorl
        self.cannonControlView.enableAllControl()
        
        //보이는 적, 포탄 다 지우기
        for cannonBall in cannonBallViewMaps{
            removeCannonBallModelAndView(cannonBallViewMap: cannonBall)
        }
        for enemy in enemyViewMaps{
            removeEnemyModelAndView(enemyViewMap: enemy)
        }
        
        //timer setting
        //move cannonball/enemy timer
        timer.append(Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(changeFieldObejctPosition), userInfo: nil, repeats: true))
        //create enemy timer
        timer.append(Timer.scheduledTimer(timeInterval: TimeInterval(enemyCreateTimeSpeed), target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true))
    }
    
    //모든 타이머 멈춤
    func invalidateAllTimer(){
        for timer in timer{
            timer.invalidate()
        }
        self.cannonControlView.disableAllControl()
        //setting pause view
        self.view.bringSubviewToFront(gamePauseView)
    }
    //-------------------------------------------------------------
    //MARK: - timer selector
    //
    
    @objc func changeFieldObejctPosition(){
        for (cannonBallModel,view) in cannonBallViewMaps{
            moveOrRemove(cannonBallModel: cannonBallModel, cannonBallView: view)
        }
        for (enemyModel,viewList) in enemyViewMaps{
            moveOrRemoveEnemy(enemyModel: enemyModel, enemyView: viewList)
        }
    }
    
    @objc func createEnemy(){
        let vectY = (sin(CGFloat.pi/2)) * 1
        let vector = CGVector(dx: CGFloat(0), dy: vectY)
        
        //create Enemy
        //MODEL
        let enemy = EnemyModel.init(vector: vector, maxX: UInt32(self.view.frame.maxX), maxSpeed: potentialEnemyMaxSpeed, minSpeed: potentialEnemyMinSpeed, maxHealth: enemyHealth)
        
        //VIEW
        //enemy view
        let enemyViewFrame = CGRect(x: enemy.position.x, y: enemy.position.y, width: 30, height: 30)
        let enemyView = EnemyView.init(frame: enemyViewFrame)
        enemyView.center = enemy.position
        //health view
        let enemyHealthSliderFrame = CGRect(x: enemy.position.x, y: enemy.position.y, width: 30, height: 30)
        let enemyHealthSlider = HealthSlider.init(frame: enemyHealthSliderFrame)
        enemyHealthSlider.getMaxHealth(maxHealth: enemyHealth)
        
        //mapping view
        enemyViewMaps[enemy] = [UIView]()
        enemyViewMaps[enemy]?.append(enemyView)
        enemyViewMaps[enemy]?.append(enemyHealthSlider)
        
        //add the view
        self.view.addSubview(enemyView)
        self.view.addSubview(enemyHealthSlider)
        
        print("적 생성")
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
    private func moveOrRemove(cannonBallModel : CannonBallModel, cannonBallView: UIView){
        //UPDATE MODEL - cannonballModel position
        cannonBallModel.moveCannonBall()
        //UPDATE VIEW - cannonballview position
        cannonBallView.center = cannonBallModel.position
        
        //수퍼뷰 관점에서 포탄 위치
        let currentBallLoc = cannonFieldView.convert(cannonBallViewMaps[cannonBallModel]?.center ?? CGPoint(x: 0, y: 0), to: nil)
        
        //화면 밖으로 나가면
        if currentBallLoc.x <= 0 || currentBallLoc.x >= self.view.frame.maxX  || currentBallLoc.y <= 0 {
            //포탄 지움(모델, 뷰 모두)
            removeCannonBallModelAndView(cannonBallViewMap: (key: cannonBallModel, value: cannonBallView))
        }
    }
    
    private func moveOrRemoveEnemy(enemyModel: EnemyModel, enemyView: [UIView]){
        //UPDATE MODEL - cannonballModel position
        enemyModel.moveEnemy()
        //UPDATE VIEW - cannonballview position
        enemyView[0].center = enemyModel.position
        enemyView[1].frame = enemyView[0].frame
        //수퍼뷰 관점에서 대포필드 최소 Y값
        let cannonFieldBoundY = cannonFieldView.convert(CGPoint(x: cannonFieldView.frame.minY,y: cannonFieldView.frame.minX), to: nil).y
        
        //화면 밖으로 나가면
        if enemyModel.position.y >= cannonFieldBoundY {
            //REMOVE ENEMY
            removeEnemyModelAndView(enemyViewMap: (key: enemyModel, value: enemyView))
            print("적이 대포를 공격")
            //UPDATE CANNONSTRUCT
            //Model
            cannonStructModel?.loseHealth(losePoint: enemyAttackPower)
            //VIEW update
            cannonFieldView.loseHealth(losePoint: enemyAttackPower)
            if cannonStructModel?.myHealth == 0 {
                print("game over")
                //타이머 멈춤
                gamePauseView.gameOver()
            }
        }
        
        //포탄이랑 적이 겹치는지 확인 - todo: 함수 빼기
        for cannonBallViewMap in cannonBallViewMaps{
            let cannonBallViewFrame = cannonFieldView.convert(cannonBallViewMap.value.frame, to: nil)
            //겹치면
            if cannonBallViewFrame.intersects(enemyView[0].frame) {
                //적 체력 -1
                //MODEL
                enemyModel.loseHealth(losePoint: 1)
                //VIEW
                (enemyView[1] as! HealthSlider).loseHealth(losePoint: 1)
                //적 체력이 0이면 REMOVE
                if enemyModel.AmIDisappear(){
                    removeEnemyModelAndView(enemyViewMap: (key: enemyModel, value: enemyView))
                }
                //REMOVE CANNON BALL
                removeCannonBallModelAndView(cannonBallViewMap: cannonBallViewMap)
            }
        }
    }
    
    //포탄 지우기
    private func removeCannonBallModelAndView(cannonBallViewMap:(key: CannonBallModel, value: UIView)){
        //REMOVE MODEL
        cannonBallViewMaps.removeValue(forKey: cannonBallViewMap.key)
        //REMOVE VIEW
        cannonBallViewMap.value.removeFromSuperview()
    }
    
    //적 지우기
    private func removeEnemyModelAndView(enemyViewMap: (key: EnemyModel, value: [UIView])){
        //REMOVE MODEL
        enemyViewMaps.removeValue(forKey: enemyViewMap.key)
        //REMOVE VIEW
        enemyViewMap.value[0].removeFromSuperview()
        enemyViewMap.value[1].removeFromSuperview()
    }
    
    private func setStartGameCannonHealthData(){
        //cannonModel 데이터를 사용하는 cannonFieldView init
        cannonFieldView.healthSliderInit(health: cannonHealth)
        cannonStructModel?.myHealth = cannonHealth
        
    }
}
