//
//  CustomProgressBar.swift
//  EYProgressBar
//
//  Created by Etjen Ymeraj on 4/15/17.
//  Copyright © 2017 Etjen Ymeraj. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomProgressBar: UIView {
    
    //Mark: - Outlets
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var sliderTitleLabel: UILabel!
    @IBOutlet weak var sliderTrackerTextField: UITextField!
    
    //Mark: - Properties
    
    //Slider View Properties
    private var sliderContainerView: UIView!
    private var backgroundCircleLayer = CAShapeLayer()
    private var progressCircleLayer = CAShapeLayer()
    private var progressNode = CAShapeLayer()
    private var sliderValue : Float = 0
    private var progressNodeValue : CGFloat = 0
    
    //XIB properties
    @IBInspectable var image: UIImage = UIImage() {
        didSet{
            sliderImageView.image = image
        }
    }
    
    @IBInspectable var title: String = "XP" {
        didSet{
            sliderTitleLabel.text = title
        }
    }
    
    @IBInspectable var value: Float {
        get {
            return sliderValue
        }
        set {
            sliderValue = min(sliderMaximumValue, max(sliderMinimumValue, newValue))
        }
    }
    
    @IBInspectable var minimumFont: CGFloat = 60 {
        didSet{
            sliderTrackerTextField.minimumFontSize = minimumFont
        }
    }
    
    //CircleLayerProperties
    @IBInspectable var layerWidth: CGFloat = 5.0 {
        didSet{
            progressCircleLayer.lineWidth = layerWidth
            backgroundCircleLayer.lineWidth = layerWidth
        }
    }
    
    @IBInspectable var nodeWidth: CGFloat = 5.0 {
        didSet{
            progressNode.lineWidth = 1 //nodewidth is needed for path below
        }
    }
    
    @IBInspectable var layerBackgroundColor: UIColor = UIColor.white {
        didSet{
            backgroundCircleLayer.strokeColor = layerBackgroundColor.cgColor
        }
    }
    
    @IBInspectable var layerBackgroundDash: Bool = false {
        didSet{
            backgroundCircleLayer.lineDashPattern = layerBackgroundDash ? [2,6] : nil
        }
    }
    
    @IBInspectable var layerProgressColor: UIColor = UIColor.orange{
        didSet{
            progressCircleLayer.strokeColor = layerProgressColor.cgColor
        }
    }
    
    @IBInspectable var nodeColor : UIColor = UIColor.white {
        didSet{
            progressNode.fillColor = nodeColor.cgColor
        }
    }
    
    //Slider Angle Properties
    private var sliderStartAngle : CGFloat = -CGFloat(M_PI_2)
    private var sliderFinishAngle: CGFloat = CGFloat(M_PI_2) * 3
    private var sliderAngleRange: CGFloat {
        return sliderFinishAngle - sliderStartAngle
    }
    
    //Slider Value Properties
    @IBInspectable var sliderMinimumValue : Float = 0.0
    @IBInspectable var sliderMaximumValue : Float = 100.0
    
    //Makes sure we are withing the boundaries of the values specified above
    var normalizedValue: Float {
        return (value - sliderMinimumValue) / (sliderMaximumValue - sliderMinimumValue)
    }
    
    //Slider Positioning Properties
    //Define the center of the slider
    private var sliderCenter : CGPoint {
        return CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    //Calculate radius based on layer width
    var sliderRadius : CGFloat {
        return min(frame.width,frame.height) / 2 - layerWidth / 2
    }
    
    //Progress Node Angle Properties
    var progressNodeAngle: CGFloat {
        return CGFloat(normalizedValue) * sliderAngleRange + sliderStartAngle
    }
    var progressNodeMiddleAngle: CGFloat {
        return (2 * CGFloat(M_PI) + sliderStartAngle - sliderFinishAngle) / 2 + sliderFinishAngle
    }
    var progressNodeRotationTransform: CATransform3D {
        return CATransform3DMakeRotation(progressNodeAngle, 0.0, 0.0, 1)
    }
    
    //MArk: - Slider Appearance
    override func draw(_ rect: CGRect) {
        //Draw Slider Path based on the center point, radius, and angles defined
        backgroundCircleLayer.path = getSliderPath()
        progressCircleLayer.path = getSliderPath()
        progressNode.path = getNodePath()
        
        //Set Slider Configurations
        setBackgroundLayer()
        setProgressLayer()
        setNodeLayer()
        
        //Update ProgressBar Value
        setValue(value, animated: false)
    }
    
    func getSliderPath() -> CGPath {
        return UIBezierPath(arcCenter: sliderCenter,
                            radius: sliderRadius,
                            startAngle: sliderStartAngle,
                            endAngle: sliderFinishAngle,
                            clockwise: true).cgPath
    }
    
    func getNodePath() -> CGPath {
        return UIBezierPath(roundedRect:
            CGRect(x: sliderCenter.x + sliderRadius - nodeWidth / 2, y: sliderCenter.y - nodeWidth / 2, width: nodeWidth, height: nodeWidth), cornerRadius: nodeWidth / 2).cgPath
    }
    
    func setBackgroundLayer() {
        backgroundCircleLayer.frame = bounds
        layer.addSublayer(backgroundCircleLayer)
        backgroundCircleLayer.fillColor = UIColor.clear.cgColor
        backgroundCircleLayer.lineCap = kCALineCapRound
    }
    
    func setProgressLayer() {
        progressCircleLayer.frame = bounds
        progressCircleLayer.strokeEnd = 0
        layer.addSublayer(progressCircleLayer)
        progressCircleLayer.fillColor = UIColor.clear.cgColor
        progressCircleLayer.lineCap = kCALineCapRound
    }
    
    func setNodeLayer(){
        progressNode.frame = bounds
        layer.addSublayer(progressNode)
        progressNode.strokeColor = UIColor.white.cgColor
    }
    
    //MARK: - Slider Progress Update
    func setValue(_ value: Float, animated: Bool) {
        setProgressLayerEnd(animated: animated)
        setProgressNodeEnd(animated: animated)
    }
    
    func setProgressLayerEnd(animated: Bool){
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.duration = 0.2
        strokeAnimation.fromValue = progressCircleLayer.strokeEnd
        strokeAnimation.toValue = CGFloat(normalizedValue)
        strokeAnimation.isRemovedOnCompletion = false
        strokeAnimation.fillMode = kCAFillModeForwards
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        progressCircleLayer.add(strokeAnimation, forKey: "strokeAnimation")
        progressCircleLayer.strokeEnd = CGFloat(normalizedValue)
        CATransaction.commit()
    }
    
    func setProgressNodeEnd(animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.2
        animation.values = [progressNodeValue, progressNodeAngle]
        progressNode.add(animation, forKey: "progressNodeAnimation")
        progressNode.transform = progressNodeRotationTransform
        
        CATransaction.commit()
        
        progressNodeValue = progressNodeAngle
    }
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        sliderContainerView = loadViewFromNib(nibName: "CustomProgressBar")
        sliderContainerView.frame = bounds
        sliderContainerView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(sliderContainerView)
    }
}
