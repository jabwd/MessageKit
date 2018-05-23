//
//  PulseActivityView.swift
//  PulseActivityView
//
//  Created by Antwan van Houdt on 08/05/2017.
//  Copyright © 2017 Antwan van Houdt. All rights reserved.
//

import UIKit

public class PulseActivityView: UIView {
    
    private var pathLayer: CAShapeLayer?
	
	var path: UIBezierPath?
    
    var placeholderColor: UIColor = UIColor(white: 0.0, alpha: 1.0)
	var isAnimating: Bool = false
    
    func generatePath_old(_ frame: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.lineJoinStyle = CGLineJoin.round
        bezierPath.move(to: CGPoint(x: frame.minX + 1.5, y: frame.minY + 69.47))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 37.27, y: frame.minY + 69.47))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 52.6, y: frame.minY + 104.92))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 78.15, y: frame.minY + 49.77))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 108.8, y: frame.minY + 132.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 134.35, y: frame.minY + 2.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 159.9, y: frame.minY + 69.47))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 211, y: frame.minY + 69.47))
        //UIColor.black.setStroke()
        bezierPath.lineWidth = 3.0
        
        return bezierPath
    }
    
    func generatePath(_ frame: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.lineJoinStyle = CGLineJoin.round
        bezierPath.move(to: CGPoint(x: frame.minX + 1.5, y: frame.minY + 71.47))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 22.84, y: frame.minY + 71.47))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 31.99, y: frame.minY + 106.92))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 47.23, y: frame.minY + 51.77))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 65.52, y: frame.minY + 134.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 80.77, y: frame.minY + 4.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 96.01, y: frame.minY + 71.47))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 126.5, y: frame.minY + 71.47))
        //UIColor.black.setStroke()
        bezierPath.lineWidth = 3.0
        return bezierPath
    }
    
    func generatePathSmall(_ frame: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.lineJoinStyle = CGLineJoin.round
        bezierPath.move(to: CGPoint(x: frame.minX + 1.5, y: frame.minY + 48.8))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 15.07, y: frame.minY + 48.8))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 20.89, y: frame.minY + 72.26))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 30.59, y: frame.minY + 35.77))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 42.22, y: frame.minY + 90.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 51.91, y: frame.minY + 4.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 61.61, y: frame.minY + 48.8))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 81, y: frame.minY + 48.8))
        //UIColor.black.setStroke()
        bezierPath.lineWidth = 3.0
        return bezierPath
    }
    
    func generateFrame() -> CGRect {
        let width: CGFloat = 126.0
        let height: CGFloat = 130.0
        let centerX = frame.size.width / 2 - width/2
        let centerY = frame.height/2 - height/2
        let pulseFrame = CGRect(x: centerX, y: centerY, width: frame.size.width, height: frame.size.height)
        return pulseFrame
    }
    
    func generateFrameSmall() -> CGRect {
        let width: CGFloat = 81.0
        let height: CGFloat = 90.0
        let centerX = frame.size.width / 2 - width/2
        let centerY = frame.height/2 - height/2
        let pulseFrame = CGRect(x: centerX, y: centerY, width: frame.size.width, height: frame.size.height)
        return pulseFrame
    }
    
    public func startAnimating() {
		guard isAnimating == false else { return }
		isAnimating = true
		
		if path == nil {
			path = generatePathSmall(generateFrameSmall())
		}
		
        let duration: CFTimeInterval = 1.2
        //let pulseFrame = generateFrameSmall()
        
        if pathLayer == nil {
            pathLayer = CAShapeLayer()
            pathLayer?.path = path?.cgPath
            pathLayer?.strokeColor = tintColor.cgColor
            pathLayer?.fillColor = nil
            pathLayer?.lineWidth = 3.0
            pathLayer?.lineJoin = kCALineJoinRound
            
            self.layer.addSublayer(pathLayer!)
        }
		
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.keyTimes = [0, 0.3, 0.7, 1]
        animation.values = [0, 1, 0.7, 0.0]
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        pathLayer?.add(animation, forKey: "opacity")
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = duration
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        strokeAnimation.autoreverses = false
        strokeAnimation.isRemovedOnCompletion = false
        strokeAnimation.repeatCount = HUGE
        
        pathLayer?.add(strokeAnimation, forKey: "strokeEnd")
        
        let tailAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        tailAnimation.keyTimes = [0, 0.7, 1]
        tailAnimation.values = [0.0, 0.4, 1]
        //tailAnimation.fromValue = 0.9
        //tailAnimation.toValue = 0.4
        tailAnimation.duration = duration
        tailAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        tailAnimation.autoreverses = false
        tailAnimation.isRemovedOnCompletion = false
        tailAnimation.repeatCount = HUGE
        
        pathLayer?.add(tailAnimation, forKey: "strokeStart")
        self.isHidden = false
    }
	
	public func stopAnimating() {
		isAnimating = false
		pathLayer?.removeAllAnimations()
        self.isHidden = true
	}
    
    override public func draw(_ rect: CGRect) {
		if path == nil {
			path = generatePathSmall(generateFrameSmall())
		}
		
        //let path = generatePathSmall(generateFrameSmall())
        placeholderColor.setStroke()
        path?.stroke()
    }
}
