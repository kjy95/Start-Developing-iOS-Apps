//
//  ViewController.swift
//  Hierarchy_code
//
//  Created by Vimosoft on 11/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //view 정의
    //label parent view
    private let labelView1 = View(frame: CGRect(x:20, y:20, width:350, height:350), color: .gray)
    private let labelView2 = View(frame: CGRect(x:20, y:20, width:310, height:310), color: .white)
    private let labelView3 = View(frame: CGRect(x:20, y:20, width:270, height:270), color: .black)
    private let labelScaleUpDownView = View(frame: CGRect(x:26, y:53, width:72, height:21), color: .gray)
    private let testlayoutView = View(frame: CGRect(x:20, y:253, width:72, height:21), color: .green)
    //버튼 클릭시 추가할 뷰
    private let testAddRemoveView = View(frame: CGRect(x:8, y: 220, width:72, height:21), color: .white)
    
    //label 정의
    private var rotate45DegreeLabel = Label(frame: CGRect(x: 10, y: 20, width: 72, height: 21), text: "45도회전")
    private var printConvertLabel = Label(frame: CGRect(x: 90, y: 20, width: 72, height: 21), text: "좌표변환")
    private var transformLabel = Label(frame: CGRect(x: 170, y: 20, width: 72, height: 21), text: "위치이동")
    private var scaleUpDownLabel = Label(frame: CGRect(x: 0, y: 0, width: 72, height: 21), text: "확대/축소")
    private var tagLabel = Label(frame: CGRect(x: 90, y: 220, width: 72, height: 21), text: "tag")
    private var testLabel = Label(frame: CGRect(x: 170, y: 50, width: 72, height: 21), text: "test label")
    
    //button 정의
    //상단 버튼
    private var rotateButton = Button(frame: CGRect(x: 10, y: 450, width: 70, height: 30), text: "도회전")
    private var printConvertButton = Button(frame: CGRect(x: 100, y: 450, width: 70, height: 30), text: "좌표변환")
    private var transformButton = Button(frame: CGRect(x: 190, y: 450, width: 70, height: 30), text: "위치변환")
    private var autoresizeOffButton = Button(frame: CGRect(x: 280, y: 450, width: 70, height: 30), text: "오토Off")
    private var autoresizeOnButton = Button(frame: CGRect(x: 280, y: 490, width: 70, height: 30), text: "오토On")
    //중단 버튼
    private var scaleDownButton = Button(frame: CGRect(x: 10, y: 540, width: 70, height: 30), text: "축소")
    private var scaleUpButton = Button(frame: CGRect(x: 100, y: 540, width: 70, height: 30), text: "확대")
    private var heightButton = Button(frame: CGRect(x: 280, y: 540, width: 70, height: 30), text: "height")
    private var tagButton = Button(frame: CGRect(x: 190, y: 540, width: 70, height: 30), text: "alpa_tag")
    //히단 버튼
    private var changeLayoutAsynicButton = Button(frame: CGRect(x: 30, y: 620, width: 170, height: 30), text: "Asyn레이아웃")
    private var changeLayoutSynicButton = Button(frame: CGRect(x: 230, y: 620, width: 170, height: 30), text: "Syn레이아웃")
    //최하단 버튼
    private var addRemoveSubviewButton = Button(frame: CGRect(x: 230, y: 700, width: 170, height: 30), text: "서브 뷰 추가")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiallize()
    }
    
    private func initiallize(){
        addButtonAction()
        //autoResizingOn()
        addView()
        printLog()
    }
    //필요한 view 추가
    private func addView(){
        //autoresizing
        //view.autoresizesSubviews = true
        //view.translatesAutoresizingMaskIntoConstraints = false
        
        //add label view
        self.view.addSubview(labelView1)
        self.labelView1.addSubview(labelView2)
        self.labelView2.addSubview(labelView3)
        self.labelView3.addSubview(labelScaleUpDownView)
        self.labelView3.addSubview(tagLabel)
        self.view.addSubview(testlayoutView)
        
        //add label
        self.labelView3.addSubview(rotate45DegreeLabel)
        self.labelView3.addSubview(printConvertLabel)
        self.labelView3.addSubview(transformLabel)
        self.labelScaleUpDownView.addSubview(scaleUpDownLabel)
        self.labelView3.addSubview(testLabel)
        
        //add button
        self.view.addSubview(transformButton)
        self.view.addSubview(printConvertButton)
        self.view.addSubview(rotateButton)
        self.view.addSubview(scaleUpButton)
        self.view.addSubview(scaleDownButton)
        self.view.addSubview(heightButton)
        self.view.addSubview(tagButton)
        self.view.addSubview(autoresizeOffButton)
        self.view.addSubview(autoresizeOnButton)
        self.view.addSubview(changeLayoutAsynicButton)
        self.view.addSubview(changeLayoutSynicButton)
        self.view.addSubview(addRemoveSubviewButton)
    }
    //autolayout
    private func autoResizingOn(){
        viewAutoResizingOn(view: labelView1)
        viewAutoResizingOn(view: labelView2)
        viewAutoResizingOn(view: labelView3)
    }
    private func autoResizingOff(){
        viewAutoResizingOff(view: labelView1)
        viewAutoResizingOff(view: labelView2)
        viewAutoResizingOff(view: labelView3)
    }
    private func viewAutoResizingOn(view: UIView){
        view.autoresizesSubviews = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
    }
    private func viewAutoResizingOff(view: UIView){
        view.autoresizesSubviews = false
    }
    //print center, frame, bound
    private func printLog(){
        print("labelView1: frame-\(labelView1.frame)  bound - \(labelView1.bounds) center - \(labelView1.center)\n labelView2: frame-\(labelView2.frame)  bound - \(labelView2.bounds) center - \(labelView2.center)\n labelView3: frame-\(labelView3.frame)  bound - \(labelView3.bounds) center - \(labelView3.center)\n")
    }
    
    //add button touchupInside handler
    private func addButtonAction(){
        transformButton.addTarget(self,
                           action: #selector(transformAction),
                           for: .touchUpInside)
        printConvertButton.addTarget(self,
                                     action: #selector(printConvertButtonAction),
                                     for: .touchUpInside)
        rotateButton.addTarget(self,
                               action: #selector(rotateButtonAction),
                               for: .touchUpInside)
        scaleUpButton.addTarget(self,
                               action: #selector(scaleUpButtonAction),
                               for: .touchUpInside)
        scaleDownButton.addTarget(self,
                                  action: #selector(scaleDownButtonAction),
                                  for: .touchUpInside)
        heightButton.addTarget(self,
                               action: #selector(heightButtonAction),
                               for: .touchUpInside)
        tagButton.addTarget(self,
                            action: #selector(tagButtonAction),
                            for: .touchUpInside)
        autoresizeOffButton.addTarget(self,
                                      action: #selector(autoresizeOffButtonAction),
                                      for: .touchUpInside)
        autoresizeOnButton.addTarget(self,
                                     action: #selector(autoresizeOnButtonAction),
                                     for: .touchUpInside)
        changeLayoutAsynicButton.addTarget(self,
                                           action: #selector(changeLayoutAsynicButtonAction),
                                           for: .touchUpInside)
        changeLayoutSynicButton.addTarget(self,
                                          action: #selector(changeLayoutSynicButtonAction),
                                          for: .touchUpInside)
        addRemoveSubviewButton.addTarget(self,
                                          action: #selector(addRemoveSubviewButtonButtonAction),
                                          for: .touchUpInside)
    }
    
    //convert and print(printConvertLabel bound를 각 superview의 관점으로 변환한것을 print)
    @objc private func printConvertButtonAction(){
        //convert to
        let labelBound = printConvertLabel.bounds
        let labelView1Bound = printConvertLabel.convert(labelBound, to: labelView1)
        let labelView2Bound = printConvertLabel.convert(labelBound, to: labelView2)
        let labelView3Bound = printConvertLabel.convert(labelBound, to: labelView3)
        
        print("printConvertLabel bound:\(labelBound) \n labelView1 location point:\(labelView1Bound)point \n labelView2 location point:\(labelView2Bound)point \n labelView 3 location point:\(labelView3Bound)point\n")
    }
    //버튼 클릭시 transform (-1, +1)point 변환
    @objc private func transformAction(){
        transformLabel.transform = transformLabel.transform.translatedBy(x: -1, y: 1)
        print("(-1, +1)point 변환")
    }
    //버튼 클릭시 rotate 45도 변환
    @objc private func rotateButtonAction(){
        rotate45DegreeLabel.transform = rotate45DegreeLabel.transform.rotated(by: CGFloat(Double.pi/4))
        print(" rotate 45도")
    }
    //버튼 클릭시 scaleDownButtonAction
    @objc private func scaleDownButtonAction(){
        labelScaleUpDownView.transform = labelScaleUpDownView.transform.scaledBy(x: 0.7, y: 0.7)
        print("(x: 0.7, y: 0.7)scale 변환")
    }
    //버튼 클릭시 scaleUpButtonAction
    @objc private func scaleUpButtonAction(){
        labelScaleUpDownView.transform = labelScaleUpDownView.transform.scaledBy(x: 1.3, y: 1.3)
        print(" (x: 1.3, y: 1.3)scale 변환")
    }
    //버튼 클릭시 labelview height + 10
    @objc private func heightButtonAction(){
        //labelView1.frame.size.height = labelView1.frame.height + 10
        labelView3.frame.size.height = labelView3.frame.height + 10
    }
    
    //constraint center layout
    @objc private func changeLayoutAsynicButtonAction(){
        testlayoutView.translatesAutoresizingMaskIntoConstraints = false
        testlayoutView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testlayoutView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
       UIView.animate(withDuration: 2.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    //constraint default layout
    @objc private func changeLayoutSynicButtonAction(){
        testlayoutView.translatesAutoresizingMaskIntoConstraints = false
        testlayoutView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        testlayoutView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        UIView.animate(withDuration: 2.0) {
            self.view.setNeedsLayout()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //auto resizing
    @objc private func autoresizeOffButtonAction(){
        autoResizingOff()
    }
    //auto resizing
    @objc private func autoresizeOnButtonAction(){
        autoResizingOn()
    }
    //버튼 클릭시 tag 1에 속하는 view -> 15 drgree rotate
    @objc private func tagButtonAction(){
        print("\ntag:\(tagLabel.tag)")
        tagLabel.tag = 1000
        if let willRoateView = self.view.viewWithTag(1000){
            willRoateView.alpha -= 0.2
            print("\ntag:\(tagLabel.tag)")
        }
    }
    //subview 추가/제거
    var isRemoved = true
    @objc private func addRemoveSubviewButtonButtonAction(){
        if isRemoved{
            self.labelView3.addSubview(testAddRemoveView)
        }else{
            testAddRemoveView.removeFromSuperview()
        }
        isRemoved = !isRemoved
    }
}

