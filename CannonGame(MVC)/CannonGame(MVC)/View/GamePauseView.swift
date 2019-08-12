//
//  GamePauseView.swift
//  CannonGame(MVC)
//
//  Created by Vimosoft on 01/08/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

/**
 게임 멈춤화면
 */

//MARK: - define protocol
protocol GamePauseViewDelegate: class {
    // 각 버튼 선택 했을 때 함수 (프로토콜)
    func pauseGame()
    func startNewGame()
}

//MARK: - define class
class GamePauseView: UIView {
    //MARK: - define value
    //UI
    @IBOutlet weak var pauseComment : UILabel!
    
    //delegate
    weak var delegate: GamePauseViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func gameOver(){
        self.isHidden = false
        pauseComment.text = "YOU DIED"
        pauseComment.textColor = .red
        delegate?.pauseGame()
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        self.isHidden = true
        delegate?.startNewGame()
    }
    
}
