//
//  phonenumberaddViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 21/02/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import CountryList

class phonenumberaddViewController: UIViewController,CountryListDelegate {
    @IBOutlet var phoneView: UIView!

    
    @IBOutlet var codeCounrty: UILabel!
    @IBOutlet var flagImg: UIButton!
    @IBOutlet var phTxt: UITextField!
    var gwtCountryExt = ""
    let connection = webservices()
    var message = ""
    var userData = UserDefaults()
    let validation:Validation = Validation.validationManager() as! Validation
    var countryList = CountryList()
    var toggleBtns = false
    var toggleBtns2 = false
    @IBOutlet var btnAgree: UIButton!
    @IBOutlet var btnTems: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     countryList.delegate = self
        phoneView.layer.cornerRadius = 5
        phoneView.layer.borderColor = UIColor.white.cgColor
        phoneView.clipsToBounds = true
        phoneView.layer.borderWidth = 1
        let imaged = UIImage(named: "font-awesome_4-7-0_square-o_256_0_ffffff_none.png")
        btnAgree.setImage(imaged, for: .normal)
        
        let imaged2 = UIImage(named: "font-awesome_4-7-0_square-o_256_0_ffffff_none.png")
        btnTems.setImage(imaged2, for: .normal)
        // Do any additional setup after loading the view.
    }

  
    func selectedCountry(country: Country) {
        print(country.name)
        print(country.flag)
        print(country.countryCode)
        print(country.phoneExtension)
        //codeCounrty.text = "+\(country.countryCode)"
        gwtCountryExt = "\(country.phoneExtension)"
        
        print(gwtCountryExt)
        let flag = country.flag
        codeCounrty.text=" \(country.flag ?? "") +\(country.phoneExtension) "
   //     flagImg.setImage(country.flag, for: .normal)
    }
    @IBAction func verifyNumber(_ sender: Any) {
        
        if(btnTems.currentImage == UIImage(named:"font-awesome_4-7-0_square-o_256_0_ffffff_none.png"))
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Accept the terms and conditions", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
                
                
            }
            
            
            alertController.addAction(okAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
       else if(btnAgree.currentImage == UIImage(named:"font-awesome_4-7-0_square-o_256_0_ffffff_none.png"))
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Accept the Privacy Policy", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
                
                
            }
            
            
            alertController.addAction(okAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
else if (phTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Add some phone number to continue", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
                
                
            }
            
            
            alertController.addAction(okAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
        self.getOtp()
        }
    }
    func getOtp()
    {
        var param = [NSString: NSObject]()
      
        if(gwtCountryExt == "")
        {
            gwtCountryExt = "1"
        }
        param = ["contact":"+\(gwtCountryExt)\(phTxt.text!)" as NSObject]
        
        
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
                        
                        self.userData.set("+\(self.gwtCountryExt)\(self.phTxt.text!)", forKey: "phonenumberSave")
                     
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
                    
                    self.getOtp()
                    
                    
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
    @IBAction func phNumberTap(_ sender: Any) {
        
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func togglr(_ sender: Any) {
        if(toggleBtns == false)
        {
            toggleBtns = true
            let imaged = UIImage(named: "font-awesome_4-7-0_check-square_256_0_ffffff_none.png")
            btnTems.setImage(imaged, for: .normal)
        }
        else
        {
            toggleBtns = false
            let imaged = UIImage(named: "font-awesome_4-7-0_square-o_256_0_ffffff_none.png")
            btnTems.setImage(imaged, for: .normal)
        }
    }
    @IBAction func togglr2(_ sender: Any) {
        if(toggleBtns2 == false)
        {
            toggleBtns2 = true
            let imaged = UIImage(named: "font-awesome_4-7-0_check-square_256_0_ffffff_none.png")
            btnAgree.setImage(imaged, for: .normal)
        }
        else
        {
            toggleBtns2 = false
            let imaged = UIImage(named: "font-awesome_4-7-0_square-o_256_0_ffffff_none.png")
            btnAgree.setImage(imaged, for: .normal)
        }
    }
    
    
    @IBAction func termsConditionTap(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "termsViewController") as! termsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func privacyPolicyTap(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "privacyPolicyViewController") as! privacyPolicyViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
