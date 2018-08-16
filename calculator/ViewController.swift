//
//  ViewController.swift
//  calculator
//
//  Created by 임지후 on 2018. 8. 16..
//  Copyright © 2018년 임지후. All rights reserved.
//  Reference :
//      1. Make Calculator App - https://youtu.be/AG2QDwmj64A
//      2. Swift function Reference - docs.swift.org/swift-book/LanguageGuide/Functions.html
//

import UIKit

class ViewController: UIViewController {

    var numberOnScreen:Double = 0 //Screen Display Number Value
    var previousNumber:Double = 0 //Before Number
    var operation = 0; //Operator tag Number
    var performingMath = false
    var equalClickYn = true    //clicked "=" button?
    var firstOperationYn = true //Is it first Operation?
    
    @IBOutlet weak var fullLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton)
    {
        let selectNumber:String = String(sender.tag-1)
        
        //Check before click button "="
        setInitVariables()

        if performingMath == true
        {
            label.text = selectNumber
            numberOnScreen = Double(label.text!)!
            performingMath = false
            
        } else {
            label.text = label.text! + selectNumber
            numberOnScreen = Double(label.text!)!
            
        }
        
        //display full operation
        fullLabel.text = fullLabel.text! + selectNumber
        
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        //Check before click button "="
        setInitVariables()
        
        if label.text != "" && sender.tag != 11 && sender.tag != 16
        {
            let presentNumber:Double = Double(label.text!)!
            
            //show selected operator on label
            label.text = sender.titleLabel?.text
            
            //Check first operation
            if firstOperationYn == true
            {
                previousNumber = presentNumber
                firstOperationYn = false
                
            } else {
                
                previousNumber = getOperate(op: operation , leftValue: previousNumber, rightValue: presentNumber)
                print("click opeator  \(label.text!) : previousNumber \(previousNumber)")
            }
            
            
            //change state of 'performingMath'
            performingMath = true
            
            //store selected operator
            operation = sender.tag
            
            //display full operation
            fullLabel.text = fullLabel.text! + label.text!
        }
        else if sender.tag == 16 //Click "="
        {
            print(previousNumber, numberOnScreen)
            label.text = String(getOperate(op: operation , leftValue: previousNumber, rightValue: numberOnScreen))
            
            equalClickYn = true
         
        }
        else if sender.tag == 11 //Click "C"
        {
            label.text = ""
            fullLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    func setInitVariables(){
        if equalClickYn == true
        {
            fullLabel.text = ""
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            equalClickYn = false
            firstOperationYn = true
        }
    }
    
    func getOperate(op: Int, leftValue: Double, rightValue: Double) -> Double {
        
        var result: Double = 0
        let opValue :Int = op
        print("getOperate  \(op)   left \(leftValue)  right \(rightValue) ")
        
        if opValue == 15 {
            result = leftValue + rightValue
        } else if opValue == 14 {
            result = leftValue - rightValue
        } else if opValue == 13 {
            result = leftValue * rightValue
        } else if opValue == 12 {
            result = leftValue / rightValue
        }

        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

