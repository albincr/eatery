//
//  LoginViewController.swift
//  Eatery
//
//  Created by Logan Allen on 4/17/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit
import OnePasswordExtension

class LoginViewController: UIViewController {
    
    var eatNow: EateriesGridViewController!
    var signupVC: SignupViewController!
    private let defaults = NSUserDefaults.standardUserDefaults()
    private let onepassword = OnePasswordExtension.sharedExtension()
    private let keychainWrapper = KeychainWrapper()
    
    private var width: CGFloat!
    private var height: CGFloat!
    
    private var eateryLabel: UILabel!
    private var eateryIcon: UIImageView!
    private var phoneNumberField: UITextField!
    private var passwordField: UITextField!
    private var forgotPasswordButton: UIButton!
    private var onepasswordButton: UIButton!
    
    private var numberPromptField: UITextField!
    
    private var spinImage: UIImageView!
    private var loginButton: UIButton!
    private var exitButton: UIButton!
    private var goToSignupButton: UIButton!
    private var goToSignupLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .eateryBlue()
        self.navigationController?.navigationBarHidden = true
        
        width = self.view.bounds.width
        height = self.view.bounds.height
        
        exitButton = UIButton(frame: CGRect(origin: CGPointMake(width-40, 30), size: CGSizeMake(25, 25)))
        exitButton.setImage(UIImage(named: "closeIconWhite"), forState: .Normal)
        exitButton.layer.opacity = 1
        exitButton.addTarget(self, action: #selector(LoginViewController.exitToEatnow(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(exitButton)
        
        // Initialize username and password textfields
        passwordField = UITextField(frame: CGRect(x: width/6, y: height/2 + 50, width: width*2/3, height: 40))
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        passwordField.secureTextEntry = true
        phoneNumberField = UITextField(frame: CGRect(x: self.width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40))
        phoneNumberField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.6)])
        phoneNumberField.keyboardType = .NumberPad
        forgotPasswordButton = UIButton(frame: CGRect(x: width/4, y: passwordField.frame.origin.y + 50, width: width/2, height: 20))
        forgotPasswordButton.setTitle("Forgot your password?", forState: .Normal)
        forgotPasswordButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 14)
        forgotPasswordButton.addTarget(self, action: #selector(LoginViewController.forgotPassword(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(passwordField)
        self.view.addSubview(phoneNumberField)
        self.view.addSubview(forgotPasswordButton)
        
        onepasswordButton = UIButton(frame: CGRect(x: passwordField.frame.origin.x + passwordField.frame.width + 5, y: passwordField.frame.origin.y + 5, width: 30, height: 30))
        onepasswordButton.setImage(UIImage(named: "onepassword-button-light"), forState: .Normal)
        onepasswordButton.addTarget(self, action: #selector(LoginViewController.onepasswordPressed(_:)), forControlEvents: .TouchUpInside)
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
        eateryIcon.image = UIImage(named: "eateryIcon")
        self.view.addSubview(eateryIcon)
        
        eateryLabel = UILabel(frame: CGRect(x: width/3, y: eateryIcon.frame.origin.y + 120, width: width/3, height: 40))
        eateryLabel.text = "Eatery"
        eateryLabel.backgroundColor = UIColor.clearColor()
        eateryLabel.textColor = UIColor.whiteColor()
        eateryLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 26)
        eateryLabel.textAlignment = .Center
        self.view.addSubview(eateryLabel)
        
        // Initialize login button
        loginButton = UIButton(frame: CGRect(x: width/3, y: height-110, width: width/3, height: 40))
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1
        loginButton.setTitleColor(.eateryBlue(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 16)
        loginButton.layer.opacity = 1
        loginButton.addTarget(self, action: #selector(LoginViewController.loginPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(loginButton)
        
        goToSignupButton = UIButton(frame: CGRect(x: width/2-68, y: height-40, width: 54, height: 25))
        goToSignupButton.setTitle("Signup", forState: .Normal)
        goToSignupButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Bold", size: 14)
        goToSignupButton.addTarget(self, action: #selector(LoginViewController.goToSignupVC(_:)), forControlEvents: .TouchUpInside)
        goToSignupLabel = UILabel(frame: CGRect(x: width/2-14, y: height-40, width: 90, height: 25))
        goToSignupLabel.text = "for Beacons."
        goToSignupLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        goToSignupLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(goToSignupButton)
        self.view.addSubview(goToSignupLabel)
        
        
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
                loginButton.frame = CGRect(x: width/3, y: height - 110, width: width/3, height: 40)
                passwordField.frame = CGRect(x: width/6, y: height/2 + 50, width: width*2/3, height: 40)
                phoneNumberField.frame = CGRect(x: width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40)
                eateryIcon.frame = CGRect(x: width/2-40, y: 70, width: 80, height: 100)
                eateryLabel.frame = CGRect(x: width/3, y: eateryIcon.frame.origin.y + 120, width: width/3, height: 40)
                forgotPasswordButton.layer.opacity = 1
            } else {
                loginButton.frame = CGRect(x: width/3, y: height - (endFrame?.size.height)! - 50, width: width/3, height: 40)
                passwordField.frame = CGRect(x: width/6, y: loginButton.frame.origin.y - 50, width: width*2/3, height: 40)
                phoneNumberField.frame = CGRect(x: width/6, y: passwordField.frame.origin.y - 50, width: width*2/3, height: 40)
                if phoneNumberField.frame.origin.y < eateryLabel.frame.origin.y + 50{
                    eateryLabel.frame = CGRect(x: width/3, y: phoneNumberField.frame.origin.y - 50, width: width/3, height: 40)
                    eateryIcon.frame = CGRect(x: width/2-40, y: eateryLabel.frame.origin.y - 110, width: 80, height: 100)
                }
                forgotPasswordButton.layer.opacity = 0
            }
            self.onepasswordButton.frame = CGRect(x: passwordField.frame.origin.x + passwordField.frame.width + 5, y: passwordField.frame.origin.y + 5, width: 30, height: 30)
            UIView.animateWithDuration(duration, delay: NSTimeInterval(0), options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() }, completion: nil)
        }
    }
    
    @IBAction func onepasswordPressed(sender: UIButton){
    
        OnePasswordExtension.sharedExtension().findLoginForURLString("app://org.cuappdev.eatery", forViewController: self, sender: sender) { (loginDictionary, error) in
            if loginDictionary == nil {
                if error!.code != Int(AppExtensionErrorCodeCancelledByUser) {
                    print("Error invoking 1Password App Extension for find login: \(error)")
                }
                return
            }
            
            self.phoneNumberField.text = loginDictionary?[AppExtensionUsernameKey] as? String
            self.passwordField.text = loginDictionary?[AppExtensionPasswordKey] as? String
        }
    }
    
    // Display error message or try to login
    @IBAction func loginPressed(sender: UIButton){
        if self.checkInputs(){
            self.checkLogin(phoneNumberField.text!, password: passwordField.text!)
        }
    }
    
    @IBAction func exitToEatnow(sender: UIButton){
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.pushViewController(eatNow, animated: true)
    }
    
    @IBAction func goToSignupVC(sender: UIButton){
        if signupVC == nil{
            print("First push to signupVC.")
            signupVC = SignupViewController()
            signupVC.eatNow = self.eatNow
        }
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func forgotPassword(sender: UIButton){
        // TODO: Send text message to phone number attached to Eatery
        let msg = "Eatery will send you a text message containing your password."
        let phoneNumberPrompt = UIAlertController(title: "Forgot Password?", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let sendAction = UIAlertAction(title: "Get Password", style: .Default){ (action) in
            // TODO: Backend function to get password reset
            print("Find password for \(self.numberPromptField.text!)")
        }
        
        func addTextField(textField: UITextField!){
            textField.placeholder = "Phone Number"
            textField.keyboardType = .NumberPad
            textField.clearButtonMode = .WhileEditing
            textField.delegate = self
            self.numberPromptField = textField
        }
        
        phoneNumberPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        phoneNumberPrompt.addAction(sendAction)
        phoneNumberPrompt.addTextFieldWithConfigurationHandler(addTextField)
        self.presentViewController(phoneNumberPrompt, animated: true, completion: nil)
    }
    
    func checkInputs() -> Bool {
        if phoneNumberField.text == ""{
            phoneNumberField.becomeFirstResponder()
            return false
        } else if passwordField.text == ""{
            passwordField.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func checkLogin(number: String, password: String){
        // TODO: Login functionality with backend
        
        if number == NSUserDefaults.standardUserDefaults().valueForKey("phoneNumber") as? String && password == NSUserDefaults.standardUserDefaults().valueForKey("password") as? String{
            let alertController = UIAlertController(title: "Login Successful", message: "YAY", preferredStyle: UIAlertControllerStyle.Alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                print("Swag")
            }
            
            alertController.addAction(dismissAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Login Failure", message: "Invalid phone number and password.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let dismissAction = UIAlertAction(title: "Try Again", style: .Default){ (action) in
                self.passwordField.text = ""
                self.passwordField.becomeFirstResponder()
            }
            
            alertController.addAction(dismissAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //Toggle keyboard when background tapped
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneNumberField || textField == self.numberPromptField{
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 10
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == phoneNumberField{
            if phoneNumberField.text == defaults.valueForKey("phoneNumber") as? String{
                passwordField.text = keychainWrapper.myObjectForKey(kSecValueData) as? String
            }
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == phoneNumberField{
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
            self.loginPressed(loginButton)
        }
        return true
    }
    
}


