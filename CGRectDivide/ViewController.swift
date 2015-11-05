//
//  ViewController.swift
//  CGRectDivide
//
//  Created by FrankLiu on 15/11/3.
//  Copyright © 2015年 刘大帅. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        gridLayout()
        
//        gridLayoutWithPadding()
        
        gridLayoutByOOP()

    }


    // 生成小网格
    func addGrid(rect: CGRect) {
    
        let gridView: UIView = UIView(frame: rect)
        gridView.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
        gridView.layer.borderColor = UIColor.grayColor().CGColor
        gridView.layer.borderWidth = 0.5
        
        view.addSubview(gridView)
    }
    
    // 网格布局
    func gridLayout() {
    
        let gridWidth:      CGFloat   = 40
        let gridHeight:     CGFloat   = 30
        let numberOfRow:    NSInteger = NSInteger(floor((view.bounds.size.height-20)/gridHeight))
        let numberOfColumn: NSInteger = NSInteger(floor((view.bounds.size.width)/gridWidth))
        var slice:          CGRect    = CGRectZero
        var rowReminder:    CGRect    = CGRectMake(0, 20, view.bounds.size.width, view.bounds.size.height-20)
        var columnReminder: CGRect    = CGRectZero
        
        // 行
        for _ in 0 ..< numberOfRow {
        
            CGRectDivide(rowReminder, &slice, &rowReminder, gridHeight, .MinYEdge)
            
            columnReminder = slice
            
            // 列
            for _ in 0 ..< numberOfColumn {
            
                CGRectDivide(columnReminder, &slice, &columnReminder, gridWidth, .MinXEdge)
                addGrid(slice)
            }
        }
        
    }
    
    func rectDividedWithPading(var rect: CGRect, slice: UnsafeMutablePointer<CGRect>, reminder: UnsafeMutablePointer<CGRect>, amout: CGFloat, padding: CGFloat, edge: CGRectEdge) {
        
        CGRectDivide(rect, slice, &rect, amout, edge)
        
        var tmpSlice: CGRect = CGRectZero
        
        CGRectDivide(rect, &tmpSlice, reminder, padding, edge)
        
    }
    
    // 带padding的网格布局
    func gridLayoutWithPadding() {
        
        let paddingX:       CGFloat   = 3
        let paddingY:       CGFloat   = 5
        let gridWidth:      CGFloat   = 40
        let gridHeight:     CGFloat   = 30
        let numberOfRow:    NSInteger = NSInteger(floor((view.bounds.size.height-20)/gridHeight))
        let numberOfColumn: NSInteger = NSInteger(floor((view.bounds.size.width)/gridWidth))
        var slice:          CGRect    = CGRectZero
        var rowReminder:    CGRect    = CGRectMake(0, 20, view.bounds.size.width, view.bounds.size.height-20)
        var columnReminder: CGRect    = CGRectZero
    
        // 行
        for _ in 0 ..< numberOfRow {
            
            rectDividedWithPading(rowReminder, slice: &slice, reminder: &rowReminder, amout: gridHeight, padding: paddingY, edge: .MinYEdge)
            
            columnReminder = slice
            
            // 列
            for _ in 0 ..< numberOfColumn {
                
                rectDividedWithPading(columnReminder, slice: &slice, reminder: &columnReminder, amout: gridWidth, padding: paddingX, edge: .MinXEdge)
                addGrid(slice)
            }
        }
        
    }
    
    // 利用面向对象的方式来使用CGRectDivide
    func gridLayoutByOOP() {
        
        let paddingX:       CGFloat   = 3
        let paddingY:       CGFloat   = 5
        let gridWidth:           CGFloat     = 40
        let gridHeight:          CGFloat     = 30
        let numberOfRow:         NSInteger   = NSInteger(floor((view.bounds.size.height-20)/gridHeight))
        let numberOfColumn:      NSInteger   = NSInteger(floor((view.bounds.size.width)/gridWidth))
        var horizontalRectModel: CGRectModel = CGRectModel(rect: CGRectMake(0, 20, view.bounds.size.width, view.bounds.size.height-20))
        var verticalRectModel:   CGRectModel
        
        /*网格布局*/
//        // 行
//        for _ in 0 ..< numberOfRow {
//            
//            let tmpTuple = horizontalRectModel.divided(gridHeight, edge: .MinYEdge)
//            horizontalRectModel = CGRectModel(rect: tmpTuple.reminder)
//            
//            verticalRectModel = CGRectModel(rect: tmpTuple.slice)
//            
//            // 列
//            for _ in 0 ..< numberOfColumn {
//                
//                let tuple = verticalRectModel.divided(gridWidth, edge: .MinXEdge)
//                verticalRectModel = CGRectModel(rect: tuple.reminder)
//                addGrid(tuple.slice)
//            }
//        }
        
        /*带padding的网格布局*/
        // 行
        for _ in 0 ..< numberOfRow {
            
            let tmpTuple = horizontalRectModel.dividedWithPadding(paddingY, amout: gridHeight, edge: .MinYEdge)
            horizontalRectModel = CGRectModel(rect: tmpTuple.reminder)
            
            verticalRectModel = CGRectModel(rect: tmpTuple.slice)
            
            // 列
            for _ in 0 ..< numberOfColumn {
                
                let tuple = verticalRectModel.dividedWithPadding(paddingX, amout: gridWidth, edge: .MinXEdge)
                verticalRectModel = CGRectModel(rect: tuple.reminder)
                addGrid(tuple.slice)
            }
        }
        
    }
    
}

