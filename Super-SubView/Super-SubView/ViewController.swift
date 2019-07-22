//
//  ViewController.swift
//  Super-SubView
//
//  Created by Vimosoft on 15/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var subView: UIView!
    var sub : UIView!
    var view1 : UIView!
    var view2 : UIView!
    var view3 : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let framez = CGRect(x: 1, y: 1, width: 10, height: 10)
        var subz = UIView(frame: framez)
        self.view.addSubview(subz)
        
        //find with tag
        /*if let willRoateView = self.view.viewWithTag(1){
            print("a")
            willRoateView.transform = willRoateView.transform.rotated(by: CGFloat(Double.pi/4))
            print(willRoateView.transform)
        
        }*/
    }


}

