//
//  ViewController.swift
//  Calculator
//
//  Created by Leon Fan on 2018/11/2.
//  Copyright © 2018 Leon Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //optional ui label
    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
//        print("\(digit) touchDigit was called!")
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display!.text!
            display!.text = textCurrentlyInDisplay + digit
        } else {
            display!.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    
    //option + p = pai; option + v = square root
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathmeticalSymbol = sender.currentTitle {
            brain.performOperation(mathmeticalSymbol)
        }
        if let result = brain.result  {
            displayValue = result
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    
}

