//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Leon Fan on 2018/11/2.
//  Copyright © 2018 Leon Fan. All rights reserved.
//

import Foundation


func changeSign(operand: Double) -> Double {
    return -operand
}

func multiply(opt1: Double, opt2: Double) -> Double {
    return opt1 * opt2;
}


/**
 struct is a value type. For value types, only methods explicitly marked as mutating can modify the properties of self, so this is not possible within a computed property.
 **/
struct CalculatorBrain {
    
    private var accumulator: Double?
    
//    private var operations: Dictionary<String, Double> = [
//        "π" : Double.pi,
//        "e" : M_E
//    ]
//
    
    
//    mutating func performOperation(_ symbol: String) {
//        if let constant = operations[symbol] {
//            accumulator = constant
//        }
//    }
//
    
//    mutating func performOperation(_ symbol: String) {
//        switch symbol {
//        case "π":
//            accumulator = Double.pi
//            break
//        case "√":
//            if let operand = accumulator {
//                accumulator = sqrt(operand)
//            }
//            break
//        default:
//            break
//        }
//    }
    
    
    private enum Operation {
        case constant(Double) //associate value
        case unaryOperation((Double) -> Double) //一元操作符
        case binaryOperation((Double, Double) -> Double) //二元操作符
        case equals
    }
    
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation(changeSign),
        "×" : Operation.binaryOperation(multiply),
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "=" : Operation.equals
    ]

    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
                break
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                break
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperaton()
            }
            
        }
    }
    
    private mutating func performPendingBinaryOperaton() {
        if accumulator != nil && pbo != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    //read only property
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private var pbo: PendingBinaryOperation?
    
}
