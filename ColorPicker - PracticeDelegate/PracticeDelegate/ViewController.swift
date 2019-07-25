//
//  ViewController.swift
//  PracticeDelegate
//
//  Created by Vimosoft on 25/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit


class ViewController: UIViewController, ColorPickerDelegate {
   
    //rootView's subView
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    //colorPicker View
    @IBOutlet weak var colorPicker: ColorPicker!
    
    //is button checked?
    var isTextButtonCheck = false
    var isBackgroundButtonCheck = false

    //-------------------------------------------------------------
    // MARK: - Life cycle management.
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate 를 VC로 할당
        colorPicker.delegate = self
        //set isHidden. 뷰 숨긴상태 메모리 관리를 위해 뷰를 숨김.
        colorPicker.isHidden = true
    }
    
    //-------------------------------------------------------------
    // MARK: -  Event handlers.
    //
    
    // 각 버튼을 눌렀을 때 버튼 state체크 action
    @IBAction func touchUpInsideBackgroundColorButton(_ sender: UIButton) {
        colorPicker.isHidden = false
        isBackgroundButtonCheck = true
        isTextButtonCheck = false
    }

    @IBAction func touchUpInsideTextColorButton(_ sender: UIButton) {
        colorPicker.isHidden = false
        setTextButtonChecked()
    }
    
    //cancel button action. hide view
    @IBAction func touchUpInsideColorPickerCancelAction(_ sender: UIButton) {
        colorPicker.isHidden = true
    }
    
    //-------------------------------------------------------------
    // MARK: - internal support method.
    //
    private func showColorPicker(){
        colorPicker.isHidden = false
    }
    
    /*
     텍스트 색상 변경을 선택함.
     백그라운드 색상 변경모드는 해제해야 한다.
     */
    private func setTextButtonChecked(){
        isBackgroundButtonCheck = false
        isTextButtonCheck = true
        /*//test
         print("isBackgroundCheck\(isBackgroundCheck)")
         print("isTextButtonCheck\(isTextButtonCheck)")*/
    }
    
    /*
     텍스트 색상 변경을 선택함.
     백그라운드 색상 변경모드는 해제해야 한다.
     */
    private func setBackgroundButtonChecked(){
        isBackgroundButtonCheck = true
        isTextButtonCheck = false
        /*//test
         print("isBackgroundCheck\(isBackgroundCheck)")
         print("isTextButtonCheck\(isTextButtonCheck)")*/
    }

    //-------------------------------------------------------------
    // MARK: - Implementation of ColorPicker's protocol method
    //
    
    internal func changedColor(newColor: UIColor) { 
        //check which button is clicked and change color
        if isTextButtonCheck{
            textLabel.textColor = newColor
        }else if isBackgroundButtonCheck{
            textLabel.backgroundColor = newColor
        }
    }
    
    internal func changingColor(newColor: UIColor) {
        //It's not used in this VC
    }
    
    
} 
