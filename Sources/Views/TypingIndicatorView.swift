/*
MIT License

Copyright (c) 2017 MessageKit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit

open class TypingIndicatorView: UIView {
    
    // MARK: - Properties
    
    open var animated: Bool = true
    
    private var animationDuration: Double = 1.0
    
    private var animationKeyTimes: [NSNumber] = [
        NSNumber(value: 0),
        NSNumber(value: 2/7.0),
        NSNumber(value: 1/2.0),
        NSNumber(value: 5/7.0),
        NSNumber(value: 1)
    ]
    
    private var dot: CAShapeLayer!
    
    private var dotsColor: UIColor = .lightGray
    
    private var animateToColor: UIColor = .gray
    
    private lazy var fillColorAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "fillColor"
        animation.values = [
            dotsColor.cgColor,
            dotsColor.cgColor,
            animateToColor.cgColor,
            dotsColor.cgColor,
            dotsColor.cgColor,
        ]
        animation.keyTimes = animationKeyTimes
        animation.duration = animationDuration
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        return animation
    }()
    
    private lazy var pulseAnimation: CAAnimation = {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform"
        animation.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        ]
        animation.keyTimes = animationKeyTimes
        animation.duration = animationDuration
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        return animation
    }()
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        let dotDimension = self.frame.size.width / 7.125
        let firstDotCenterX = 2 * self.frame.size.width / 7
        let intervalBetweenDotsOnXAxis = 3 * self.frame.size.width / 14
        
        let container = CAReplicatorLayer()
        container.position = CGPoint(x: self.layer.bounds.size.width / 2.0, y: self.layer.bounds.size.height / 2.0)
        container.bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        container.instanceCount = 3
        container.instanceTransform = CATransform3DMakeTranslation(intervalBetweenDotsOnXAxis, 0.0, 0.0)
        container.instanceDelay = Double(self.animationDuration / 7.0)
        
        let dot = CAShapeLayer()
        dot.position = CGPoint(x: firstDotCenterX, y: container.bounds.size.height / 2.0);
        dot.bounds = CGRect(x: 0, y: 0, width: dotDimension, height: dotDimension);
        dot.path = UIBezierPath(ovalIn: dot.bounds).cgPath
        dot.fillColor = self.dotsColor.cgColor
        
        // Add animations
        dot.add(fillColorAnimation, forKey: "darkening")
        dot.add(pulseAnimation, forKey: "pulsating")
        
        self.dot = dot
        self.layer.addSublayer(container)
        container.addSublayer(dot)
    }
    
}
