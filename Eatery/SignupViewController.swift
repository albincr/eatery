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
    
    var eatNow: EateriesGridViewController!
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var width: CGFloat!
    private var height: CGFloat!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading")
        
        self.view.backgroundColor = .eateryBlue()
        self.navigationController?.navigationBarHidden = true
        
        width = self.view.bounds.width
        height = self.view.bounds.height
        
        exitButton = UIButton(frame: CGRect(origin: CGPointMake(width-40, 30), size: CGSizeMake(25, 25)))
        exitButton.setImage(UIImage(named: "closeIcon"), forState: .Normal)
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
        onepasswordButton.setImage(UIImage(named: "onepassword-button-light"), forState: .Normal)
        onepasswordButton.addTarget(self, action: #selector(SignupViewController.onepasswordPressed(_:)), forControlEvents: .TouchUpInside)
//        onepasswordButton.hidden = !OnePasswordExtension.sharedExtension().isAppExtensionAvailable()
        self.view.addSubview(onepasswordButton)
        
        for view in self.view.subviews{
            let textField = (view as? UITextField)
            textField?.textAlignment = .Left
            textField?.textColor = UIColor.whiteColor()
            textField?.backgroundColor = UIColor(white: 1, alpha: 0.3)
            textField?.clearsOnBeginEditing = false
            textField?.clearButtonMode = .WhileEditing
            textField?.delegate = self
            if textField != passwordField { textField?.autocapitalizationType = .Words }
            textField?.keyboardAppearance = .Dark
            textField?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            textField?.leftView = leftView
            textField?.leftViewMode = .Always
        }
        
        eateryIcon = UIImageView(frame: CGRect(x: self.width/2-40, y: 40, width: 80, height: 100))
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
        signupButton = UIButton(frame: CGRect(x: width/3, y: height-80, width: width/3, height: 40))
        signupButton.backgroundColor = UIColor.whiteColor()
        signupButton.layer.borderColor = UIColor.whiteColor().CGColor
        signupButton.layer.borderWidth = 1
        signupButton.setTitleColor(.eateryBlue(), forState: .Normal)
        signupButton.setTitle("Sign Up", forState: .Normal)
        signupButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 16)
        signupButton.layer.opacity = 0
        signupButton.addTarget(self, action: #selector(SignupViewController.signupPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(signupButton)
        
        loginLabel = UILabel(frame: CGRect(x: width/2-105, y: height-35, width: 130, height: 20))
        loginLabel.textAlignment = .Center
        loginLabel.text = "Already signed up?"
        loginLabel.textColor = UIColor.whiteColor()
        loginLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        loginButton = UIButton(frame: CGRect(x: width/2+25, y: height-35, width: 80, height: 20))
        loginButton.setTitle("Login here.", forState: .Normal)
        loginButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 14)
        loginButton.addTarget(self, action: #selector(SignupViewController.goToLoginScreen(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(loginLabel)
        self.view.addSubview(loginButton)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignupViewController.keyboardToggle(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.8, delay: 0.3, options: .CurveEaseIn, animations: {
            self.eateryLabel.layer.opacity = 1
            self.eateryIcon.layer.opacity = 1
        }) { (finished) in
            UIView.animateWithDuration(0.7, animations: {
//                self.loginLabel.frame = CGRect(x: self.width/2-105, y: self.height-35, width: 130, height: 20)
//                self.loginButton.frame = CGRect(x: self.width/2+25, y: self.height-35, width: 80, height: 20)
                self.exitButton.layer.opacity = 1
                self.signupButton.layer.opacity = 1
                self.signupButton.frame = CGRect(x: self.width/3, y: self.height-110, width: self.width/3, height: 40)
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
                self.signupButton.frame = CGRect(x: width/3, y: height - 110, width: width/3, height: 40)
                self.passwordField.frame = CGRect(x: width/6, y: height/2 + 80, width: width*2/3, height: 40)
                self.phoneNumberField.frame = CGRect(x: width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.lNameField.frame = CGRect(x: width/6, y: phoneNumberField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.fNameField.frame = CGRect(x: width/6, y: lNameField.frame.origin.y - 50, width: width*2/3, height: 40)
                self.eateryIcon.frame = CGRect(x: width/2-40, y: 40, width: 80, height: 100)
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
            self.onepasswordButton.frame = CGRect(x: passwordField.frame.origin.x + passwordField.frame.width + 5, y: passwordField.frame.origin.y + 5, width: 30, height: 30)
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    @IBAction func onepasswordPressed(sender: UIButton){
        
        if !checkInputs(){ return }
        
        let signupDetails:[String: AnyObject] = [
            AppExtensionTitleKey: "Eatery",
            AppExtensionUsernameKey: self.phoneNumberField.text!,
            AppExtensionPasswordKey: self.passwordField.text!,
            AppExtensionNotesKey: "Saved with the Eatery app",
            AppExtensionSectionTitleKey: "Eatery App",
            AppExtensionFieldsKey: [
                "firstname" : self.fNameField.text!,
                "lastname" : self.lNameField.text!
            ]
        ]
        
        OnePasswordExtension.sharedExtension().storeLoginForURLString("app://org.cuappdev.eatery", loginDetails: signupDetails, passwordGenerationOptions: nil, forViewController: self, sender: sender) { (loginDictionary, error) in
            if loginDictionary == nil {
                if error!.code != Int(AppExtensionErrorCodeCancelledByUser) {
                    print("Error invoking 1Password App Extension for find login: \(error)")
                }
                return
            }
            
            self.phoneNumberField.text = loginDictionary?[AppExtensionUsernameKey] as? String
            self.passwordField.text = loginDictionary?[AppExtensionPasswordKey] as? String
            self.fNameField.text = loginDictionary?[AppExtensionReturnedFieldsKey]?["firstname"] as? String
            self.lNameField.text = loginDictionary?[AppExtensionReturnedFieldsKey]?["lastname"] as? String
            
            self.showSuccessfulStorageAlert("Externally stored login credentials.")
        }
    }
    
    // Display error message or try to login
    @IBAction func signupPressed(sender: UIButton){
        print("Signing up!!")
        if !checkInputs(){ return }
        
        // Validate inputs
        // Validate phone number
        // Push to beacons screen
        
        // Store name, and number
//        if defaults.objectForKey("firstName") == nil{
            defaults.setValue(fNameField.text, forKey: "firstName")
//        }
//        if defaults.valueForKey("lastName") == nil{
            defaults.setValue(lNameField.text, forKey: "lastName")
//        }
//        if defaults.valueForKey("phoneNumber") == nil{
            defaults.setValue(phoneNumberField.text, forKey: "phoneNumber")
//        }
        defaults.setValue(passwordField.text, forKey: "password")
        
        self.checkIfStorageWorked()
    }
    
    @IBAction func goToLoginScreen(sender: UIButton){
        let loginVC = LoginViewController()
        loginVC.eatNow = self.eatNow
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func exitToEatnow(sender: UIButton){
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.pushViewController(eatNow, animated: true)
    }
    
    func checkInputs() -> Bool {
        if fNameField.text == ""{
            fNameField.becomeFirstResponder()
            return false
        } else if lNameField.text == ""{
            lNameField.becomeFirstResponder()
            return false
        } else if phoneNumberField.text == ""{
            phoneNumberField.becomeFirstResponder()
            return false
        } else if passwordField.text == ""{
            passwordField.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func showSuccessfulStorageAlert(message: String){
        let alertController = UIAlertController(title: "Notification", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .Default){ (action) in
            self.signupPressed(self.signupButton)
        }
        
        alertController.addAction(dismissAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func checkIfStorageWorked(){
        var message = ""
        message += "First: \(defaults.objectForKey("firstName")), "
        message += "Last: \(defaults.valueForKey("lastName")), "
        message += "Number: \(defaults.valueForKey("phoneNumber"))"
        message += "Pswd: \(defaults.valueForKey("password"))"

        let alertController = UIAlertController(title: "Checking Defaults", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            print("Done")
        }
        
        alertController.addAction(dismissAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
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

