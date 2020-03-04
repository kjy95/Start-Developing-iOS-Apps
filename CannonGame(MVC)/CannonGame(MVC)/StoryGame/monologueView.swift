//
//  monologueView.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 26/10/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
import SnapKit

enum MonologueViewType{
    case MonologueBlack
}
/**
 독백
 */
class monologueView: UIView {

    //-------------------------------------------------------------
    //MARK: - Define Value
    //
    var monologueLabel = UILabel()
    var monologueText = ""
     
    //-------------------------------------------------------------
    //MARK: - Define Funtion
    //
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: calculate Function
    func setView(type: MonologueViewType = .MonologueBlack){
        
    }
    
    func setMonologueBlack(){
        
    }
}
