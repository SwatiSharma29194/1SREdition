//
//  otpscreenViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 21/02/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class otpscreenViewController: UIViewController,UITextFieldDelegate {
    var otpSuccess = String()
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    
    @IBOutlet var verificationTxt: UILabel!
    @IBOutlet var text4: UITextField!
    var userData = UserDefaults()
    var phonenumberController = phonenumberaddViewController()
    var connection = webservices()
    var message = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text4.delegate = self
        let getnumber = "\(self.userData.value(forKey:"phonenumberSave")!)"
        
        verificationTxt.text = "A verification code has been sent to mobile number *****\(getnumber.suffix(4)). Please enter the code below to continue "
        // Do any additional setup after loading the view.
    }
    @IBAction func resendBtnTap(_ sender: Any) {
        
       self.getOtp2()
    }
    func getOtp2()
    {
        var param = [NSString: NSObject]()
        
        param = ["contact":"\(self.userData.value(forKey:"phonenumberSave")!)" as NSObject]
        
        
        //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
        
        print(param)
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        connection.startConnectionWithSting(getUrlString: "sendotp", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(!((receivedData.value(forKey: "message") == nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "Success")
                    {
                        
                        
                        
                        
                        print(receivedData)
                        

                        
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the verification code sent to your phone", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            IJProgressView.shared.hideProgressView()
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "otpscreenViewController") as! otpscreenViewController
                            vc.otpSuccess =  "\(receivedData.value(forKey: "otp")!)"
                            self.navigationController?.pushViewController(vc, animated: false)
                            
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
                    
                    
                    
                    
                    let message:String  = "The phone number has already been taken."
                    
                    
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
                    
                    self.getOtp2()
                    
                    
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
    func textFieldShouldReturn(_ txtField: UITextField) -> Bool {
        txtField.resignFirstResponder()
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 2 {
            //this is textfield 2, so call your method here
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 0 {
            //
            if textField == text1 {
                if !(text1.text == "") {
                    text2.text = string
                } else {
                    textField.text = (string as? NSString)?.substring(to: 1)
                }
                text2.becomeFirstResponder()
            } else if textField == text2 {
                if !(text2.text == "") {
                    text3.text = string
                } else {
                    textField.text = (string as? NSString)?.substring(to: 1)
                }
                text3.becomeFirstResponder()
            } else if textField == text3 {
                if !(text3.text == "") {
                    text4.text = string
                } else {
                    textField.text = (string as? NSString)?.substring(to: 1)
                }
                text4.becomeFirstResponder()
            }
            else if textField == text4 {
                if !(text4.text == "") {
                    text4.text = string
                } else {
                    textField.text = (string as? NSString)?.substring(to: 1)
                }
                text4.resignFirstResponder()
            }
            return false
            
        }
        else
        {
            if (textField == self.text4) {
                self.text4.resignFirstResponder;
                self.text4.text = "";
                self.text3.becomeFirstResponder;
            } else if (textField == self.text3) {
                self.text3.resignFirstResponder;
                self.text3.text  = "";
                self.text2.becomeFirstResponder;
            } else if (textField == self.text2)
            {
                self.text2.resignFirstResponder;
                self.text2.text = "";
                self.text1.becomeFirstResponder;
            } else {
                self.text1.resignFirstResponder;
                self.text1.text = "";
                textField.resignFirstResponder;
            }
            return false
        }
        return true
    }
    
    @IBAction func verifyBtnTap(_ sender: Any) {
        if(text1.text == "" || text2.text == "" || text3.text == "" || text4.text == "")
        {
            
        }
        else
        {
            let getString = "\(text1.text!)\(text2.text!)\(text3.text!)\(text4.text!)"
            if(getString == otpSuccess)
            {
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Number is verified", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    IJProgressView.shared.hideProgressView()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "signupViewController") as! signupViewController
                 
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            }
        }
    }
        
    
    
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
