//
//  ViewController.swift
//  RGBView
//
//  Created by NikolayD on 04.07.2024.
//

import UIKit

final class ColorSettingViewController: UIViewController {

    @IBOutlet var colourView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var mainVCBackgroundColor: UIColor!
    weak var delegate: ColorSettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourView.layer.cornerRadius = 30
        
        setSlidersValue(from: mainVCBackgroundColor)
        
        setViewColour()
        setValue(redSlider.value, forLabel: redLabel)
        setValue(greenSlider.value, forLabel: greenLabel)
        setValue(blueSlider.value, forLabel: blueLabel)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        setViewColour()
        
        switch sender {
        case redSlider:
            setValue(redSlider.value, forLabel: redLabel)
        case greenSlider:
            setValue(greenSlider.value, forLabel: greenLabel)
        default:
            setValue(blueSlider.value, forLabel: blueLabel)
        }
    }
    
    @IBAction func doneButtonTapped() {
        if let delegate = delegate {
            delegate.setBackGroundColor(
                UIColor(
                    red: CGFloat(redSlider.value),
                    green: CGFloat(greenSlider.value),
                    blue: CGFloat(blueSlider.value),
                    alpha: 1
                )
            )
        }
        dismiss(animated: true)
    }
    
    
    private func setViewColour() {
        colourView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(_ value: Float, forLabel label: UILabel) {
        label.text = value.formatted(
            .number.precision(.fractionLength(2))
        )
    }
    
    private func setSlidersValue(from color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
}

