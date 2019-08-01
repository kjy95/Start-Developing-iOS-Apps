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
    //mapping two object
    var cannonBallViewMaps = [CannonBallModel:UIView]()
    var enemyViewMaps = [EnemyModel:EnemyView]()
    
    //MARK: value
    var timer = [Timer]()

    
    //MARK: 상수 선언
    //포탄 상수
    let potentialCannonSpeed : CGFloat = 12
    let cannonHealth : Int = 3
    let cannonAttackPower : Int = 1
    //적 상수
    let potentialEnemyMaxSpeed : CGFloat = 8
    let potentialEnemyMinSpeed : CGFloat = 1
    let enemyHealth : Int = 3
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
        
        //init cannonModel
        cannonStructModel = CannonStructModel.init(currentLoc: cannonFieldView.cannon.center, frame: cannonFieldView.commonBall.frame, health: cannonHealth )
        cannonStructModel?.updateCannonVector(radian: CGFloat.pi/2, speed: potentialCannonSpeed)
        
        //cannonModel 데이터를 사용하는 cannonFieldView init
        cannonFieldView.cannonFieldInit(radian: cannonStructModel?.radian ?? CGFloat.pi/2)
        setStartGameCannonHealthData()
        
        //게임 시작 버튼 맨 앞으로
        self.cannonControlView.disableAllControl()
        //setting pause view
        self.view.bringSubviewToFront(gamePauseView)
    }
    
    //-------------------------------------------------------------
    // MARK: - Implementation of CannonContorlView's protocol method
    //
    
    /*
     포탄 type 바꾸기
     버튼에 해당하는 type으로 포탄model의 type 바꿈
     그 후 뷰도 해당 타입으로 변환.
     */
    //tap type(shape) button
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
        
        //Model update : 대포 라디안 업데이트
        cannonStructModel?.updateCannonVector(radian: radian, speed: potentialCannonSpeed)
        
        //View update : cannonStructView rotate
        cannonFieldView.roateCannonStruct(radian: radian)
    }
    
    //tap fire button
    func fireCannonBall(){
        /**
         쏠 포탄 생성
         */
        
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
        //cannonBallView.cannonBallInit(type: type, cannonballviewFrame: cannonballviewFrame)
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
    
    //tap start button
    func startNewGame() {
        //reset health
        setStartGameCannonHealthData()
        
        //view contorl
        self.cannonControlView.enableAllControl()
        
        //Remove CannonBall
        for cannonBall in cannonBallViewMaps{
            removeCannonBallModelAndView(cannonBallViewMap: cannonBall)
        }
        
        //Remove Enemy
        for enemy in enemyViewMaps{
            removeEnemyModelAndView(enemyViewMap: enemy)
        }
        
        //TIMER SETTING
        //move cannonball and enemy timer
        timer.append(Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(changeFieldObejctPosition), userInfo: nil, repeats: true))
        //create enemy timer
        timer.append(Timer.scheduledTimer(timeInterval: TimeInterval(enemyCreateTimeSpeed), target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true))
    }
    
    //When start game first or When gameover
    func pauseGame(){
        //모든 타이머 멈춤
        for timer in timer{
            timer.invalidate()
        }
        //control
        self.cannonControlView.disableAllControl()
        //setting pause view
        self.view.bringSubviewToFront(gamePauseView)
    }
    
    //-------------------------------------------------------------
    //MARK: - timer selector
    //
    
    @objc func changeFieldObejctPosition(){
        for (cannonBallModel,view) in cannonBallViewMaps{
            moveOrRemoveCannonBall(cannonBallModel: cannonBallModel, cannonBallView: view)
        }
        
        for (enemyModel,enemyView) in enemyViewMaps{
            //적 움직이기, 적이 포탄을 공격하면(화면 밖을 나가면) 제거됨.
            moveOrRemoveEnemy(enemyModel: enemyModel, enemyView: enemyView )
            //포탄이랑 적이 겹치면 포탄이 제거됨
            removeWhenCannonBallIntersected(enemyModel: enemyModel, enemyView: enemyView)
            //적 체력이 0이면 적이 제거됨.
            removeEnemyWhenHealthZero(enemyModel: enemyModel, enemyView: enemyView)
        }
        
        //cannon의 체력이 0이라면
        if cannonStructModel?.myHealth == 0 {
            print("game over")
            //View
            gamePauseView.gameOver()
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
        enemyView.enemyInit(maxHealth: enemyHealth)
        enemyView.center = enemy.position
        
        //mapping view
        enemyViewMaps[enemy] = enemyView
        
        //add the view
        self.view.addSubview(enemyView)
        
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
    private func moveOrRemoveCannonBall(cannonBallModel : CannonBallModel, cannonBallView: UIView){
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
    
    private func moveOrRemoveEnemy(enemyModel: EnemyModel, enemyView: EnemyView){
        //UPDATE MODEL - cannonballModel position
        enemyModel.moveEnemy()
        //UPDATE VIEW - cannonballview position
        enemyView.center = enemyModel.position
        //수퍼뷰 관점에서 대포필드 최소 Y값
        let cannonFieldBoundY = cannonFieldView.convert(CGPoint(x: cannonFieldView.frame.minY,y: cannonFieldView.frame.minX), to: nil).y
        
        //포탄을 공격(화면 밖으로 나감)했다면
        if enemyModel.position.y >= cannonFieldBoundY {
            //UPDATE CANNON health
            //UPDATE Model
            cannonStructModel?.loseHealth(losePoint: enemyAttackPower)
            //UPDATE VIEW update
            cannonFieldView.loseHealth(losePoint: enemyAttackPower)
            
            //REMOVE ENEMY
            removeEnemyModelAndView(enemyViewMap: (key: enemyModel, value: enemyView))
        }
    }
    
    private func removeWhenCannonBallIntersected(enemyModel: EnemyModel, enemyView: EnemyView){
        for cannonBallViewMap in cannonBallViewMaps{
            let cannonBallViewFrame = cannonFieldView.convert(cannonBallViewMap.value.frame, to: nil)
            //겹치면
            if cannonBallViewFrame.intersects(enemyView.frame) {
                //적 체력 -1
                //MODEL
                enemyModel.loseHealth(losePoint: cannonAttackPower)
                //VIEW
                enemyView.loseHealth(losePoint: cannonAttackPower)
                
                //REMOVE CANNON BALL
                removeCannonBallModelAndView(cannonBallViewMap: cannonBallViewMap)
            }
        }
    }
    
    private func removeEnemyWhenHealthZero(enemyModel: EnemyModel, enemyView: EnemyView){
        if enemyModel.IsMyHealthZero(){
            removeEnemyModelAndView(enemyViewMap: (key: enemyModel, value: enemyView))
        }
    }
    
    //Remove CannonBall
    private func removeCannonBallModelAndView(cannonBallViewMap:(key: CannonBallModel, value: UIView)){
        //REMOVE MODEL
        cannonBallViewMaps.removeValue(forKey: cannonBallViewMap.key)
        //REMOVE VIEW
        cannonBallViewMap.value.removeFromSuperview()
    }
    
    //Remove Enemy
    private func removeEnemyModelAndView(enemyViewMap: (key: EnemyModel, value: EnemyView)){
        //REMOVE MODEL
        enemyViewMaps.removeValue(forKey: enemyViewMap.key)
        //REMOVE VIEW
        enemyViewMap.value.removeFromSuperview()
    }
    
    //대포 체력 full로 채우기
    private func setStartGameCannonHealthData(){
        //Model full Health
        cannonStructModel?.myHealth = cannonHealth
        //View full Health
        cannonFieldView.healthSliderInit(health: cannonHealth)
    }
}
