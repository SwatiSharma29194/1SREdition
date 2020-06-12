//
//  loginViewController.swift
//  Carz4Hire
//
//  Created by user on 3/1/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    let connection = webservices()
    var message = ""
    var userData = UserDefaults()
    let validation:Validation = Validation.validationManager() as! Validation
    @IBOutlet var emailAddress: UIView!
    @IBOutlet var passwordView: UIView!

    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var sideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddress.layer.cornerRadius = 5
         emailAddress.layer.borderColor = UIColor.white.cgColor
        emailAddress.clipsToBounds = true
        emailAddress.layer.borderWidth = 1
        passwordView.layer.cornerRadius = 5
        
        passwordView.layer.borderColor = UIColor.white.cgColor
        passwordView.clipsToBounds = true
          passwordView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinTap(_ sender: Any) {
        
        login()
    }
    @IBAction func mybooking(_ sender: Any) {
        
        userData.removeObject(forKey: "getSeg")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mybookings")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    func login(){
        
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
            
            
        else {
            // param ["user_email"]  = emailUser.text! as NSObject
            var param = [NSString: NSObject]()
            
     
                param = ["email":emailTxt.text! as NSObject,"password":passwordTxt.text! as NSObject]
            
            
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
            
            connection.startConnectionWithSting(getUrlString: "login", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(((receivedData.value(forKey: "message") != nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            IJProgressView.shared.hideProgressView()
                            var token = String()
                            if(!(receivedData.value(forKey: "access_token") == nil)){
                                token = receivedData.value(forKey: "access_token") as! String
                                self.userData.set(token, forKey:"acessToken")

                            }
                            let getData = receivedData.value(forKey: "data") as! NSDictionary
                            if((getData.value(forKey: "address_proof") is NSNull) || (getData.value(forKey: "address_proof")as! String == ""))
                            {
                                self.userData.set("havenot", forKey: "licence")
                            }
                            
                            else
                            {
                                   self.userData.set("have", forKey: "licence")
                            }
                            self.userData.set(self.emailTxt.text!, forKey: "emailSave")
                             self.userData.set(getData.value(forKey: "currency"), forKey: "saveCurrency")
                                 self.userData.set(self.passwordTxt.text!, forKey: "passwordSave")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "booking")
                            
                            self.navigationController?.pushViewController(vc!, animated: false)
                            
                            
                            
                            
                            
                     
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
                        
                        _ =   receivedData.value(forKey: "error")
                        
                        
                        let message:String  = (receivedData.value(forKey: "errors") as AnyObject).value(forKey:"error") as! String
                        
                        
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
                        
                        self.login()
                        
                        
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
    

    @IBAction func menubtnTap(_ sender: Any) {
            // sideView.isHidden = false
  
           self.sideView.isHidden = false;
        var napkinBottomFrame: CGRect = sideView.frame
        napkinBottomFrame.origin.x = 0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
            self.sideView.frame = napkinBottomFrame
        }, completion: {(_ finished: Bool) -> Void in
            /*done*/
        
        })

    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func hotoffers(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "hotoffers")
        
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func myaccounttap(_ sender: Any) {
        
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "myaccount")
            
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "login")
            
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
    
    @IBAction func btnSideBar(_ sender: Any) {
        
        var basketTopFrame: CGRect = sideView.frame
        basketTopFrame.origin.x = -950
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {() -> Void in
            self.sideView.frame = basketTopFrame
        }, completion: {(_ finished: Bool) -> Void in
            self.sideView.isHidden = true;
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
