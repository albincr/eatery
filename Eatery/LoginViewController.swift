//
//  LoginViewController.swift
//  Eatery
//
//  Created by Logan Allen on 4/17/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var eateryLabel: UILabel!
    var eateryIcon: UIImageView!
    var fNameField: UITextField!
    var lNameField: UITextField!
    var phoneNumberField: UITextField!
    var passwordField: UITextField!
    var onepasswordButton: UIButton!
    
    var spinImage: UIImageView!
    var loginButton: UIButton!
    var exitButton: UIButton!
    
    var width: CGFloat!
    var height: CGFloat!
    
    var eatNow: EateriesGridViewController!
    
    let masterLogin = ["1234567890":"cuappdev"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading")
        
        self.view.backgroundColor = .eateryBlue()
        
        width = self.view.bounds.width
        height = self.view.bounds.height
        
        exitButton = UIButton(frame: CGRect(origin: CGPointMake(width-40, 30), size: CGSizeMake(25, 25)))
        exitButton.setImage(UIImage(named: "exitIcon"), forState: .Normal)
        exitButton.addTarget(self, action: #selector(LoginViewController.exitToEatnow(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(exitButton)
        
        // Initialize username and password textfields
        passwordField = UITextField(frame: CGRect(x: width/6, y: height/2 + 50, width: width*2/3, height: 40))
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        passwordField.secureTextEntry = true
        phoneNumberField = UITextField(frame: CGRect(x: self.width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40))
        phoneNumberField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        phoneNumberField.keyboardType = .PhonePad
        self.view.addSubview(passwordField)
        self.view.addSubview(phoneNumberField)
        
        onepasswordButton = UIButton(frame: CGRect(x: passwordField.frame.origin.x + passwordField.frame.width + 5, y: passwordField.frame.origin.y + 5, width: 30, height: 30))
        onepasswordButton.setImage(UIImage(named: "onepasswordButtonLight"), forState: .Normal)
        onepasswordButton.addTarget(self, action: #selector(LoginViewController.onepasswordPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(onepasswordButton)
        
        for view in self.view.subviews{
            let textField = (view as? UITextField)
            textField?.textAlignment = .Left
            textField?.textColor = UIColor.whiteColor()
            textField?.backgroundColor = UIColor(white: 1, alpha: 0.3)
            textField?.clearsOnBeginEditing = false
            textField?.clearButtonMode = .WhileEditing
            textField?.delegate = self
            textField?.autocapitalizationType = .None
            textField?.autocorrectionType = .No
            textField?.spellCheckingType = .No
            textField?.keyboardAppearance = .Dark
            textField?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            textField?.leftView = leftView
            textField?.leftViewMode = .Always
        }
        
        eateryIcon = UIImageView(frame: CGRect(x: self.width/2-40, y: 70, width: 80, height: 100))
        eateryIcon.image = UIImage(named: "eateryLoginIcon")
        self.view.addSubview(eateryIcon)
        
        eateryLabel = UILabel(frame: CGRect(x: width/3, y: eateryIcon.frame.origin.y + 120, width: width/3, height: 40))
        eateryLabel.text = "EATERY"
        eateryLabel.backgroundColor = UIColor.clearColor()
        eateryLabel.textColor = UIColor.whiteColor()
        eateryLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        eateryLabel.textAlignment = .Center
        self.view.addSubview(eateryLabel)
        
        // Initialize login button
        loginButton = UIButton(frame: CGRect(x: width/3, y: height-120, width: width/3, height: 40))
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1
        loginButton.setTitleColor(.eateryBlue(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 16)
        loginButton.layer.opacity = 1
        loginButton.addTarget(self, action: #selector(LoginViewController.loginPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(loginButton)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardToggle(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardToggle(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame?.origin.y >= UIScreen.mainScreen().bounds.size.height {
                self.loginButton.frame = CGRect(x: width/3, y: height - 120, width: width/3, height: 40)
                self.passwordField.frame = CGRect(x: width/6, y: height/2 + 50, width: width*2/3, height: 40)
            } else {
                self.loginButton.frame = CGRect(x: width/3, y: height - (endFrame?.size.height)! - 50, width: width/3, height: 40)
                self.passwordField.frame = CGRect(x: width/6, y: loginButton.frame.origin.y - 50, width: width*2/3, height: 40)
            }
            self.phoneNumberField.frame = CGRect(x: width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40)
            UIView.animateWithDuration(duration, delay: NSTimeInterval(0), options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() }, completion: nil)
        }
    }
    
    @IBAction func onepasswordPressed(sender: UIButton){
        print("One Password!")
    }
    
    // Display error message or try to login
    @IBAction func loginPressed(sender: UIButton){
        print("Login")
        if phoneNumberField.text == ""{
            phoneNumberField.becomeFirstResponder()
        } else if passwordField.text == ""{
            passwordField.becomeFirstResponder()
        }
    }
    
    @IBAction func exitToEatnow(sender: UIButton){
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.pushViewController(eatNow, animated: true)
    }
    
    //Toggle keyboard when background tapped
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneNumberField{
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 10
        }
        return true
    }
    
}


