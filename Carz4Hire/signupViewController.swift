//
//  signupViewController.swift
//  Carz4Hire
//
//  Created by user on 3/1/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {
    @IBOutlet var phonenumberview: UIView!
    
    @IBOutlet var emailView: UIView!
    @IBOutlet var titleview: UIView!
    
    @IBOutlet var locationView: UIView!
    @IBOutlet var locationTxt: UITextField!
    @IBOutlet var titleTxt: UITextField!
    @IBOutlet var phonenumberTxt: UITextField!
    @IBOutlet var firstnameTxt: UITextField!
    @IBOutlet var firstnameView: UIView!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var paswordView: UIView!
    
    @IBOutlet var currencyTxt: UITextField!
    @IBOutlet var curencyView: UIView!
    let connection = webservices()
    var message = ""
    var userData = UserDefaults()
    let validation:Validation = Validation.validationManager() as! Validation
    override func viewDidLoad() {
        
        super.viewDidLoad()
        emailView.layer.cornerRadius = 5
        
        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.clipsToBounds = true
        emailView.layer.borderWidth = 1
        paswordView.layer.cornerRadius = 5
        
        paswordView.layer.borderColor = UIColor.white.cgColor

        paswordView.clipsToBounds = true
        paswordView.layer.borderWidth = 1
        
        paswordView.layer.cornerRadius = 5
        
        
        
        firstnameView.layer.borderColor = UIColor.white.cgColor
        
        firstnameView.clipsToBounds = true
        firstnameView.layer.borderWidth = 1
        
        firstnameView.layer.cornerRadius = 5
        
        titleview.layer.borderColor = UIColor.white.cgColor
        
        titleview.clipsToBounds = true
        titleview.layer.borderWidth = 1
        
        phonenumberview.layer.cornerRadius = 5
        
        phonenumberview.layer.borderColor = UIColor.white.cgColor
        
        phonenumberview.clipsToBounds = true
        phonenumberview.layer.borderWidth = 1
        
        locationView.layer.cornerRadius = 5
        
        locationView.layer.borderColor = UIColor.white.cgColor
        
        locationView.clipsToBounds = true
        locationView.layer.borderWidth = 1
        
        curencyView.layer.borderColor = UIColor.white.cgColor
        
        curencyView.clipsToBounds = true
        curencyView.layer.borderWidth = 1
        
        curencyView.layer.cornerRadius = 5
        
        
        phonenumberTxt.text = self.userData.value(forKey: "phonenumberSave") as! String

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(!(userData.value(forKey: "saveCurrency") == nil))
        {
            currencyTxt.text = userData.value(forKey: "saveCurrency") as! String
        }
    }
    
    @IBAction func signUpTap(_ sender: Any) {
        
        signup()
    }
    func signup(){
        
        if !validation.validateBlankField(emailTxt.text!){
            
            message = "Please enter email address"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else  if !validation.validateEmail(emailTxt.text!){
            
            message = "Please enter valid email address"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
            
        else if !validation.validateBlankField(passwordTxt.text!){
            
            message = "Please enter password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if((passwordTxt.text?.characters.count)! < 6){
            message = "Please enter 6 digit password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
        else if !validation.validateBlankField(firstnameTxt.text!){
            
            message = "Please enter your full name"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if !validation.validateBlankField(phonenumberTxt.text!){
            
            message = "Please enter your phone number"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if !validation.validateBlankField(titleTxt.text!){
            
            message = "Please enter your title"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if !validation.validateBlankField(locationTxt.text!){
            
            message = "Please enter your location"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            // param ["user_email"]  = emailUser.text! as NSObject
            var param = [NSString: NSObject]()
            
            
            param = ["email":emailTxt.text! as NSObject,"password":passwordTxt.text! as NSObject,"first_name":firstnameTxt.text! as NSObject,"title":titleTxt.text! as NSObject,"phone_number":phonenumberTxt.text! as NSObject,"location":locationTxt.text! as NSObject,"phone_verification":"1" as NSObject,"currency":currencyTxt.text! as NSObject]
            
            
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
            
            connection.startConnectionWithSting(getUrlString: "signup", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            
                            self.message = "Signed up successfully"
                            
                            
                            print(receivedData)
                            
                            
                            
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: self.message, preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                IJProgressView.shared.hideProgressView()
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                                
                                self.navigationController?.pushViewController(vc!, animated: false)
                                
                            }
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            

                            
                            
                      
                        }
                            
                            
                        else{
                            
                            
                            
                            
                            
                            //  print(message)
                            
                            self.message = receivedData.value(forKey: "message") as! String
                            
                            
                            print(receivedData)
                            
                            
                            
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: self.message, preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                IJProgressView.shared.hideProgressView()
                                
                            }
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        }
                        
                        
                    }
                        
                        
                        //                    if((receivedData.value(forKey: "status") as! Int) == 0){
                        //
                        //
                        //                    }
                    else{
                        
                        
                        
                        
                        
                        //  print(message)
                        
                        
                        
                        
                        let message:String  = "The email has already been taken."
                        
                        
                        self.message = message
                        
                        
                        
                        self.message = message
                        
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: self.message, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            IJProgressView.shared.hideProgressView()
                            
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                else{
                    
                    print(receivedData)
                    
                    
                    let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.signup()
                        
                        
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                    }
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            })
            
            
        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
