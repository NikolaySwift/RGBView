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
        setLabelsValue()
    }

    @IBAction func slidersValueChanged() {
        setViewColour()
        setLabelsValue()
    }
    
    private func setViewColour() {
        colourView.backgroundColor = UIColor(
            red: CGFloat(255 * redSlider.value),
            green: CGFloat(255 * greenSlider.value),
            blue: CGFloat(255 * blueSlider.value),
            alpha: 1
        )
    }
    
    private func setLabelsValue() {
        redLabel.text = redSlider.value.formatted(
            .number.precision(.fractionLength(2))
        )
        greenLabel.text = greenSlider.value.formatted(
            .number.precision(.fractionLength(2))
        )
        blueLabel.text = blueSlider.value.formatted(
            .number.precision(.fractionLength(2))
        )
    }
}

