//
//  SignupViewController.swift
//  Eatery
//
//  Created by Logan Allen on 4/17/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit
import OnePasswordExtension

class SignupViewController: UIViewController {
    
    var eateryLabel: UILabel!
    var eateryIcon: UIImageView!
    var fNameField: UITextField!
    var lNameField: UITextField!
    var phoneNumberField: UITextField!
    var passwordField: UITextField!
    
    var spinImage: UIImageView!
    var signupButton: UIButton!
    var loginButton: UIButton!
    var loginLabel: UILabel!
    var exitButton: UIButton!
    var onepasswordButton: UIButton!
    
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
        exitButton.layer.opacity = 0
        exitButton.addTarget(self, action: #selector(SignupViewController.exitToEatnow(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(exitButton)
        
        // Initialize username and password textfields
        passwordField = UITextField(frame: CGRect(x: width/6, y: height/2 + 80, width: width*2/3, height: 40))
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        passwordField.secureTextEntry = true
        phoneNumberField = UITextField(frame: CGRect(x: self.width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40))
        phoneNumberField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        phoneNumberField.keyboardType = .PhonePad
        lNameField = UITextField(frame: CGRect(x: self.width/6, y: phoneNumberField.frame.origin.y - 50, width: width*2/3, height: 40))
        lNameField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        fNameField = UITextField(frame: CGRect(x: self.width/6, y: lNameField.frame.origin.y - 50, width: width*2/3, height: 40))
        fNameField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        self.view.addSubview(passwordField)
        self.view.addSubview(phoneNumberField)
        self.view.addSubview(lNameField)
        self.view.addSubview(fNameField)
        
        onepasswordButton = UIButton(frame: CGRect(x: passwordField.frame.origin.x + passwordField.frame.width + 5, y: passwordField.frame.origin.y + 5, width: 30, height: 30))
        onepasswordButton.setImage(UIImage(named: "onepasswordButtonLight"), forState: .Normal)
        onepasswordButton.addTarget(self, action: #selector(SignupViewController.onepasswordPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(onepasswordButton)
        
        //        onepasswordButton.hidden = !OnePasswordExtension.sharedExtension().isAppExtensionAvailable()
        
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
        eateryIcon.layer.opacity = 0
        self.view.addSubview(eateryIcon)
        
        eateryLabel = UILabel(frame: CGRect(x: width/3, y: eateryIcon.frame.origin.y + 120, width: width/3, height: 40))
        eateryLabel.text = "EATERY"
        eateryLabel.backgroundColor = UIColor.clearColor()
        eateryLabel.textColor = UIColor.whiteColor()
        eateryLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        eateryLabel.textAlignment = .Center
        eateryLabel.layer.opacity = 0
        self.view.addSubview(eateryLabel)
        
        // Initialize login button
        signupButton = UIButton(frame: CGRect(x: width/3, y: height-120, width: width/3, height: 40))
        signupButton.backgroundColor = UIColor.whiteColor()
        signupButton.layer.borderColor = UIColor.whiteColor().CGColor
        signupButton.layer.borderWidth = 1
        signupButton.setTitleColor(.eateryBlue(), forState: .Normal)
        signupButton.setTitle("Sign Up", forState: .Normal)
        signupButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 16)
        signupButton.layer.opacity = 1
        signupButton.addTarget(self, action: #selector(SignupViewController.signupPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(signupButton)
        
        loginLabel = UILabel(frame: CGRect(x: width/2-105, y: height, width: 130, height: 20))
        loginLabel.textAlignment = .Center
        loginLabel.text = "Already signed up?"
        loginLabel.textColor = UIColor.whiteColor()
        loginLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        loginButton = UIButton(frame: CGRect(x: width/2+25, y: height, width: 80, height: 20))
        loginButton.setTitle("Login here.", forState: .Normal)
        loginButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 14)
        loginButton.addTarget(self, action: #selector(SignupViewController.loginPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(loginLabel)
        self.view.addSubview(loginButton)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignupViewController.keyboardToggle(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseIn, animations: {
            self.eateryLabel.layer.opacity = 1
            self.eateryIcon.layer.opacity = 1
        }) { (finished) in
            UIView.animateWithDuration(0.7, animations: {
                self.loginLabel.frame = CGRect(x: self.width/2-105, y: self.height-40, width: 130, height: 20)
                self.loginButton.frame = CGRect(x: self.width/2+25, y: self.height-40, width: 80, height: 20)
                self.exitButton.layer.opacity = 1
            })
        }
    }
    
    func keyboardToggle(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame?.origin.y >= UIScreen.mainScreen().bounds.size.height {
                self.signupButton.frame = CGRect(x: width/3, y: height - 120, width: width/3, height: 40)
                self.passwordField.frame = CGRect(x: width/6, y: height/2 + 80, width: width*2/3, height: 40)
                self.phoneNumberField.frame = CGRect(x: width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.lNameField.frame = CGRect(x: width/6, y: phoneNumberField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.fNameField.frame = CGRect(x: width/6, y: lNameField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.eateryIcon.frame = CGRect(x: width/2-40, y: 70, width: 80, height: 100)
                self.eateryLabel.frame = CGRect(x: width/3, y: eateryIcon.frame.origin.y + 120, width: width/3, height: 40)
            } else {
                self.signupButton.frame = CGRect(x: width/3, y: height - (endFrame?.size.height)! - 50, width: width/3, height: 40)
                self.passwordField.frame = CGRect(x: width/6, y: signupButton.frame.origin.y - 50, width: width*2/3, height: 40)
                self.phoneNumberField.frame = CGRect(x: width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.lNameField.frame = CGRect(x: width/6, y: phoneNumberField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.fNameField.frame = CGRect(x: width/6, y: lNameField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.eateryLabel.frame = CGRect(x: width/3, y: fNameField.frame.origin.y - 50, width: width/3, height: 40)
                self.eateryIcon.frame = CGRect(x: width/2-40, y: eateryLabel.frame.origin.y - 110, width: 80, height: 100)
            }
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    @IBAction func onepasswordPressed(sender: UIButton){
        print("One password")
        OnePasswordExtension.sharedExtension().findLoginForURLString("app://org.cuappdev.eatery", forViewController: self, sender: sender) { (loginDictionary, error) in
            if loginDictionary!.count == 0{
                if error!.code != Int(AppExtensionErrorCodeCancelledByUser){
                    NSLog("Error invoking 1Password App Extension for find login: \(error)")
                }
            }
            print("Yoooo")
        }
    }
    
    // Display error message or try to login
    @IBAction func signupPressed(sender: UIButton){
        if fNameField.text == ""{
            fNameField.becomeFirstResponder()
        } else if lNameField.text == ""{
            lNameField.becomeFirstResponder()
        } else if phoneNumberField.text == ""{
            phoneNumberField.becomeFirstResponder()
        } else if passwordField.text == ""{
            passwordField.becomeFirstResponder()
        }
    }
    
    @IBAction func loginPressed(sender: UIButton){
        let loginVC = LoginViewController()
        loginVC.eatNow = self.eatNow
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func exitToEatnow(sender: UIButton){
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.pushViewController(eatNow, animated: true)
    }
    
    // Called when fields are fully filled in
    //    func tryToLogin(){
    //        // Animate login button
    //        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
    //            let originalFrame = self.signupButton.frame
    //            self.signupButton.frame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y + 70, width: originalFrame.width, height: originalFrame.height)
    //            self.signupButton.layer.opacity = 0.4
    //            self.spinImage.frame = CGRect(x: self.width/2-40, y: 60, width: 80, height: 80)
    //            self.spinImage.layer.opacity = 1
    //        }) { (finished) -> Void in
    //            let key = self.phoneNumberField.text!
    //            if self.masterLogin[key] == self.passwordField.text!{
    //                self.secureLogin()
    //            }else{
    //                UIView.animateWithDuration(1.3, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
    //                    let originalFrame = self.signupButton.frame
    //                    self.signupButton.frame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y - 70, width: originalFrame.width, height: originalFrame.height)
    //                    self.signupButton.layer.opacity = 1.0
    //                    self.spinImage.layer.opacity = 0
    //                }) { (finished) -> Void in
    //                    //                            self.displayErrorMessage(3)
    //                    self.spinImage.frame = CGRect(x: self.width/2-40, y: -80, width: 80, height: 80)
    //                }
    //            }
    //        }
    //        spinImage.rotate360Degrees()
    //    }
    
    //Toggle keyboard when background tapped
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension SignupViewController: UITextFieldDelegate{
    
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


extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.5, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

