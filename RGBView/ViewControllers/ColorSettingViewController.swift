//
//  ViewController.swift
//  RGBView
//
//  Created by NikolayD on 04.07.2024.
//

import UIKit

final class ColorSettingViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet var colourView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - public property
    var mainVCBackgroundColor: UIColor!
    weak var delegate: ColorSettingViewControllerDelegate?
    
    private var oldTextValue: String?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourView.layer.cornerRadius = 30
        configureTextFields()
        
        setSlidersValue(from: mainVCBackgroundColor)
        setViewColour()
        
        setValue(redSlider.value, forLabel: redLabel)
        setValue(greenSlider.value, forLabel: greenLabel)
        setValue(blueSlider.value, forLabel: blueLabel)
        
        setValue(redSlider.value, forTextField: redTextField)
        setValue(greenSlider.value, forTextField: greenTextField)
        setValue(blueSlider.value, forTextField: blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        setViewColour()
        
        switch sender {
        case redSlider:
            setValue(redSlider.value, forLabel: redLabel)
            setValue(redSlider.value, forTextField: redTextField)
        case greenSlider:
            setValue(greenSlider.value, forLabel: greenLabel)
            setValue(greenSlider.value, forTextField: greenTextField)
        default:
            setValue(blueSlider.value, forLabel: blueLabel)
            setValue(blueSlider.value, forTextField: blueTextField)
        }
    }
    
    @IBAction func doneButtonTapped() {
        view.endEditing(true)
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
    

    
    // MARK: - private method
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
    
    private func setValue(_ value: Float, forTextField textField: UITextField) {
        textField.text = value.formatted(
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

// MARK: - method to configure textFields
extension ColorSettingViewController {
    private func configureTextFields() {
        let bar = UIToolbar()
        let flexible = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneTapped)
        )
        bar.setItems([flexible, doneButton], animated: false)
        bar.sizeToFit()
        
        [redTextField, greenTextField, blueTextField].forEach {
            $0?.delegate = self
            $0?.inputAccessoryView = bar
        }
    }
    
    @IBAction func doneTapped() {
        view.endEditing(true)
    }
}

// MARK: - AlertController
extension ColorSettingViewController {
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ColorSettingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        oldTextValue = textField.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(
                withTitle: "Неправильный формат числа",
                andMessage: "введите число правильно"
            )
            textField.text = oldTextValue
            return
        }
        let transformText = text.replacingOccurrences(of: ",", with: ".")
        guard let toFloat = Float(transformText) else {
            showAlert(
                withTitle: "Неправильный формат числа",
                andMessage: "введите число правильно"
            )
            textField.text = oldTextValue
            return
        }
        guard (redSlider.minimumValue...redSlider.maximumValue).contains(toFloat) else {
            showAlert(
                withTitle: "Неправильный формат числа",
                andMessage: "введите число правильно"
            )
            textField.text = oldTextValue
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(toFloat, animated: true)
            setValue(toFloat, forTextField: redTextField)
            setValue(toFloat, forLabel: redLabel)
        case greenTextField:
            greenSlider.setValue(toFloat, animated: true)
            setValue(toFloat, forTextField: greenTextField)
            setValue(toFloat, forLabel: greenLabel)
        default:
            blueSlider.setValue(toFloat, animated: true)
            setValue(toFloat, forTextField: blueTextField)
            setValue(toFloat, forLabel: blueLabel)

        }
        setViewColour()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

