//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var passwordTextField: UITextField = UITextField()
    private var passWordContainerView: UIView = UIView()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    var isOpen = true
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.text = "Enter Password"
        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .light)
        
        //password container
        addSubview(passWordContainerView)
        passWordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passWordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passWordContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        passWordContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passWordContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        passWordContainerView.layer.borderColor = UIColor.blue.cgColor
        passWordContainerView.layer.borderWidth = 2.0
        passWordContainerView.layer.cornerRadius = 7.0
        
        //textField
        passWordContainerView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: passWordContainerView.leadingAnchor, constant: 8).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passWordContainerView.topAnchor, constant: 8).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passWordContainerView.trailingAnchor, constant: -8).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passWordContainerView.bottomAnchor, constant: -8).isActive = true
        passwordTextField.placeholder = "Enter Your Password"
        
        //show or hide button
        passWordContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalToSystemSpacingBelow: passWordContainerView.topAnchor, multiplier: 1.0).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: passWordContainerView.trailingAnchor, constant: -8).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: passWordContainerView.bottomAnchor, constant: -8).isActive = true
        let image = UIImage.init(named: "eyes-closed")
        passwordTextField.isSecureTextEntry = true
        showHideButton.setImage(image!, for: .normal)
        showHideButton.addTarget(self, action: #selector(buttonShow), for: .touchUpInside )
        
        //weakView
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: passWordContainerView.leadingAnchor).isActive = true
        weakView.topAnchor.constraint(equalTo: passWordContainerView.bottomAnchor, constant: 8).isActive = true
        weakView.frame.size = colorViewSize
        weakView.backgroundColor = unusedColor
        if textField(passwordTextField, shouldChangeCharactersIn: NSRange(location: 0, length: 9), replacementString: passwordTextField.text!  ){
            weakView.backgroundColor = weakColor
            
        }
        
        
        //mediumView
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 5).isActive = true
        mediumView.topAnchor.constraint(equalToSystemSpacingBelow: passWordContainerView.bottomAnchor, multiplier: 1.0).isActive = true
        mediumView.frame.size = colorViewSize
        mediumView.backgroundColor = unusedColor
        if textField(passwordTextField, shouldChangeCharactersIn: NSRange(location: 10, length: 19), replacementString: passwordTextField.text! ){
            mediumView.backgroundColor = mediumColor
        }
        
        
        //strongView
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 5).isActive = true
        strongView.topAnchor.constraint(equalToSystemSpacingBelow: passWordContainerView.bottomAnchor, multiplier: 1.0).isActive = true
        strongView.frame.size = colorViewSize
        strongView.backgroundColor = unusedColor
        if textField(passwordTextField, shouldChangeCharactersIn: NSRange(location: 20, length: 30), replacementString: passwordTextField.text! ){
            strongView.backgroundColor = strongColor
        }
        
        
        
        
    }
    
    @objc func buttonShow(){
        if isOpen{
            passwordTextField.isSecureTextEntry = false
            let image = UIImage.init(named: "eyes-open")
            showHideButton.setImage(image!, for: .normal)
        }else {
            passwordTextField.isSecureTextEntry = true
            let image = UIImage.init(named: "eyes-closed")
            showHideButton.setImage(image!, for: .normal)
        }
        
        isOpen = !isOpen
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
