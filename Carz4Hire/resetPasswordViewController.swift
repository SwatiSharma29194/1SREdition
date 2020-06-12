//
//  resetPasswordViewController.swift
//  Carz4Hire
//
//  Created by user on 3/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class resetPasswordViewController: UIViewController {
    @IBOutlet var oldPassword: UITextField!
    
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var newPassword: UITextField!
    let connection = webservices()
    var message = ""
    var userData = UserDefaults()
    let validation:Validation = Validation.validationManager() as! Validation
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func savechanges(_ sender: Any) {
        resetPassword()
        
    }
    func resetPassword(){
        
        if !validation.validateBlankField(oldPassword.text!){
            
            message = "Please enter the old password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
 
        else if((oldPassword.text?.characters.count)! < 6){
            message = "Please enter 6 digit password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        if !validation.validateBlankField(newPassword.text!){
            
            message = "Please enter the new password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
            
        else if((newPassword.text?.characters.count)! < 6){
            message = "Please enter 6 digit password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        if !validation.validateBlankField(confirmPassword.text!){
            
            message = "Please enter the confirm password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
            
        else if((confirmPassword.text?.characters.count)! < 6){
            message = "Please enter 6 digit password"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }

            else if (!(newPassword.text == confirmPassword.text))
        {
                message = "Password does not matches"
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)

        }
        
        else {
           
            // param ["user_email"]  = emailUser.text! as NSObject
            var param = [NSString: NSObject]()
            
            
            param = ["oldpassword":oldPassword.text! as NSObject,"password":newPassword.text! as NSObject,"password_confirmation":confirmPassword.text! as NSObject]
           // http://carz4hire.com/api/updatepassword
            
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
            
            connection.startConnectionWithSting2(getUrlString: "updatepassword", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                print(receivedData)

                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(((receivedData.value(forKey: "message") != nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "Password Updated Successfully")
                        {
                            IJProgressView.shared.hideProgressView()
                            var token = String()
                            
                            
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Password updated successfully", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                self.userData.removeObject(forKey: "emailSave")
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
                        
                        self.resetPassword()
                        
                        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
