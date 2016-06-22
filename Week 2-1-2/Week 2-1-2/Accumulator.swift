//
//  Accumulator.swift
//  Week 2-1-2
//
//  Created by 김기범 on 2016. 6. 20..
//  Copyright © 2016년 김기범. All rights reserved.
//

import Foundation

class Accumulator {
    
    func makeAccumulator(startNum:Double) -> (Double)->Double {
        var sum = startNum
        func add(number:Double)->Double{
            sum += number
            return sum
        }
        return add
    }
    
}