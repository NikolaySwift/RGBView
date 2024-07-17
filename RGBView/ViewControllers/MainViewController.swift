//
//  MainViewController.swift
//  RGBView
//
//  Created by NikolayD on 17.07.2024.
//

import UIKit

protocol ColorSettingViewControllerDelegate: AnyObject {
    func setBackGroundColor(_ color: UIColor)
}


final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingVC = segue.destination as? ColorSettingViewController else {
            return
        }
        colorSettingVC.mainVCBackgroundColor = view.backgroundColor
        colorSettingVC.delegate = self
    }

}

// MARK: - ColorSettingViewControllerDelegate
extension MainViewController: ColorSettingViewControllerDelegate {
    func setBackGroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
