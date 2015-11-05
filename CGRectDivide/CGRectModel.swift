//
//  CGRectModel.swift
//  CGRectDivide
//
//  Created by FrankLiu on 15/11/4.
//  Copyright © 2015年 刘大帅. All rights reserved.
//

import UIKit

class CGRectModel {
    
    let rect: CGRect
    
    init(rect: CGRect) {
    
        self.rect = rect
    }
    
    func divided(amout: CGFloat, edge: CGRectEdge) -> (slice: CGRect, reminder: CGRect) {
    
        var slice:    CGRect = CGRectZero
        var reminder: CGRect = CGRectZero
        CGRectDivide(rect, &slice, &reminder, amout, edge)
        
        return (slice, reminder)
    }
    
    func dividedWithPadding(padding: CGFloat, amout: CGFloat, edge: CGRectEdge) -> (slice: CGRect, reminder: CGRect) {
    
        var slice:    CGRect = CGRectZero
        var reminder: CGRect = CGRectZero
        var tmpSlcie: CGRect = CGRectZero
        
        CGRectDivide(rect, &slice, &reminder, amout, edge)
        
        CGRectDivide(reminder, &tmpSlcie, &reminder, padding, edge)
        
        return (slice, reminder)
    }
}
