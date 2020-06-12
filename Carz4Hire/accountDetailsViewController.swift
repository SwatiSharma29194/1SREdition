//
//  accountDetailsViewController.swift
//  Carz4Hire
//
//  Created by user on 3/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class accountDetailsViewController: UIViewController{
  
    @IBOutlet var cardtype: UITextField!
    @IBOutlet var cardname: UITextField!
    
    @IBOutlet var currencyTxt: UITextField!
    @IBOutlet var titleTxt: UITextField!
    
   
    @IBOutlet var phoneTxt: UITextField!
    
      let validation:Validation = Validation.validationManager() as! Validation
    var connection = webservices()
    var message = String()
    var userData = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAccountDetails()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
        self.updateProfile()
    }
    override func viewWillAppear(_ animated: Bool) {
        if(!(userData.value(forKey: "saveCurrency") == nil))
        {
        currencyTxt.text = userData.value(forKey: "saveCurrency") as! String
        }
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "privacyPolicyViewController")
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    func updateProfile(){
        if !validation.validateBlankField(titleTxt.text!){
            
            message = "Please enter title"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if !validation.validateBlankField(cardtype.text!){
            
            message = "Please enter your full name"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if !validation.validateBlankField(cardname.text!){
            
            message = "Please enter email address"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else  if !validation.validateEmail(cardname.text!){
            
            message = "Please enter valid email address"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
            
        
        
    
        else if !validation.validateBlankField(phoneTxt.text!){
            
            message = "Please enter your phone number"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if !validation.validateBlankField(currencyTxt.text!){
            
            message = "Please enter your currency"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
       
        else {
            // param ["user_email"]  = emailUser.text! as NSObject
            var param = [NSString: NSObject]()
            
            
            param = ["email":cardname.text! as NSObject,"first_name":cardtype.text! as NSObject,"title":titleTxt.text! as NSObject,"currency":currencyTxt.text! as NSObject]
            
           
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
            
            connection.startConnectionWithSting2(getUrlString: "updateprofile", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            
               
                            
                            
                            print(receivedData)
                       //     self.userData.value(forKey:"saveCurrency")
                            
                            self.userData.set(self.currencyTxt.text!, forKey: "saveCurrency")
                            
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Update Successfully", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                IJProgressView.shared.hideProgressView()
                                
                      
                                
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
                        
                        self.updateProfile()
                        
                        
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
    func getAccountDetails(){
        
        // param ["user_email"]  = emailUser.text! as NSObject
        
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        
        connection.startConnectionWithStringGetType2(getUrlString: "getuserdetails", outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(!((receivedData.value(forKey: "message") == nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        IJProgressView.shared.hideProgressView()
                        let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
          
                        self.titleTxt.text = (getDataDict.value(forKey: "title") as! String)
                        self.cardname.text = getDataDict.value(forKey: "email") as? String
                        self.phoneTxt.text = getDataDict.value(forKey: "phone_number") as? String
                        self.cardtype.text = getDataDict.value(forKey: "first_name") as? String
                        self.currencyTxt.text = getDataDict.value(forKey: "currency") as? String
                        
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
                    
                    
                    
                    
                }
                
            }
            else{
                
                print(receivedData)
                
                
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    IJProgressView.shared.hideProgressView()
                    
                    self.getAccountDetails()
                    
                    
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
