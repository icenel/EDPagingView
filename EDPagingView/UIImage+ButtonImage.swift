//
//  UIImage+ButtonImage.swift
//  TestingSlideView
//
//  Created by Edward Anthony on 7/3/16.
//  Copyright © 2016 Edward Anthony. All rights reserved.
//

import UIKit

extension UIImage {
    class func addButtonImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 44.0, height: 44.0), false, UIScreen.mainScreen().scale)
        
        // Circle
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 44, height: 44))
        UIColor.grayColor().setFill()
        ovalPath.fill()
        
        //  Plus
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 24, y: 20))
        bezierPath.addLineToPoint(CGPoint(x: 24, y: 12.99))
        bezierPath.addCurveToPoint(CGPoint(x: 22, y: 11), controlPoint1: CGPoint(x: 24, y: 11.89), controlPoint2: CGPoint(x: 23.1, y: 11))
        bezierPath.addCurveToPoint(CGPoint(x: 20, y: 12.99), controlPoint1: CGPoint(x: 20.89, y: 11), controlPoint2: CGPoint(x: 20, y: 11.89))
        bezierPath.addLineToPoint(CGPoint(x: 20, y: 20))
        bezierPath.addLineToPoint(CGPoint(x: 12.99, y: 20))
        bezierPath.addCurveToPoint(CGPoint(x: 11, y: 22), controlPoint1: CGPoint(x: 11.89, y: 20), controlPoint2: CGPoint(x: 11, y: 20.9))
        bezierPath.addCurveToPoint(CGPoint(x: 12.99, y: 24), controlPoint1: CGPoint(x: 11, y: 23.11), controlPoint2: CGPoint(x: 11.89, y: 24))
        bezierPath.addLineToPoint(CGPoint(x: 20, y: 24))
        bezierPath.addLineToPoint(CGPoint(x: 20, y: 31.01))
        bezierPath.addCurveToPoint(CGPoint(x: 22, y: 33), controlPoint1: CGPoint(x: 20, y: 32.11), controlPoint2: CGPoint(x: 20.9, y: 33))
        bezierPath.addCurveToPoint(CGPoint(x: 24, y: 31.01), controlPoint1: CGPoint(x: 23.11, y: 33), controlPoint2: CGPoint(x: 24, y: 32.11))
        bezierPath.addLineToPoint(CGPoint(x: 24, y: 24))
        bezierPath.addLineToPoint(CGPoint(x: 31.01, y: 24))
        bezierPath.addCurveToPoint(CGPoint(x: 33, y: 22), controlPoint1: CGPoint(x: 32.11, y: 24), controlPoint2: CGPoint(x: 33, y: 23.1))
        bezierPath.addCurveToPoint(CGPoint(x: 31.01, y: 20), controlPoint1: CGPoint(x: 33, y: 20.89), controlPoint2: CGPoint(x: 32.11, y: 20))
        bezierPath.addLineToPoint(CGPoint(x: 24, y: 20))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;
        
        UIColor.whiteColor().setFill()
        bezierPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
