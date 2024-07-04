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
        
    }

    @IBAction func slidersValueChanged() {
    }
    
}

