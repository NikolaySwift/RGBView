//
//  ViewController.swift
//  RGBView
//
//  Created by NikolayD on 04.07.2024.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var colourView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourView.layer.cornerRadius = 30
        
        setViewColour()
        setValue(redSlider.value, ForLabel: redLabel)
        setValue(greenSlider.value, ForLabel: greenLabel)
        setValue(blueSlider.value, ForLabel: blueLabel)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        setViewColour()
        
        switch sender {
        case redSlider:
            setValue(redSlider.value, ForLabel: redLabel)
        case greenSlider:
            setValue(greenSlider.value, ForLabel: greenLabel)
        default:
            setValue(blueSlider.value, ForLabel: blueLabel)
        }
    }
    
    private func setViewColour() {
        colourView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(_ value: Float, ForLabel label: UILabel) {
        label.text = value.formatted(
            .number.precision(.fractionLength(2))
        )
    }
}

