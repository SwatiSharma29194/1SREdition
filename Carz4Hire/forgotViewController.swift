//
//  forgotViewController.swift
//  Carz4Hire
//
//  Created by user on 3/1/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class forgotViewController: UIViewController {
    
    
    let connection = webservices()
    var message = ""
    var userData = UserDefaults()
    let validation:Validation = Validation.validationManager() as! Validation
    @IBOutlet var emailView: UIView!
    
    @IBOutlet var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.layer.cornerRadius = 5
        
        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.clipsToBounds = true
        emailView.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }
    @IBAction func forgotPasswordTap(_ sender: Any) {
         forgotPassword()
    }
    func forgotPassword(){
        
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
            
            
            
        else {
            // param ["user_email"]  = emailUser.text! as NSObject
            var param = [NSString: NSObject]()
            
            
            param = ["email":emailTxt.text! as NSObject]
            
            
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
        
            connection.startConnectionWithSting(getUrlString: "forgotpassword", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(((receivedData.value(forKey: "message") != nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "Please check your email for new password")
                        {
                            IJProgressView.shared.hideProgressView()
                        
                            
                            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: "Please check your email for getting the new password", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                                
                                self.navigationController?.pushViewController(vc!, animated: true)
                                
                            }
                            
                            
                            alert.addAction(okAction)
                            
                            
                            
                            self.present(alert, animated: true, completion: nil)

                            
                            
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
                        
                        self.forgotPassword()
                        
                        
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
