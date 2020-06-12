//
//  checkingViewController.swift
//  Carz4Hire
//
//  Created by user on 3/7/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class checkingViewController: UIViewController {
    @IBOutlet var indicator: UIActivityIndicatorView!
    var getResultsArr = NSMutableArray()
    var getDictData = NSDictionary()
    var connection = webservices()
    var userData = UserDefaults()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    override func viewDidLoad() {
        super.viewDidLoad()
         indicator.startAnimating()
        searchCars()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "location")
//
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
        // Do any additional setup after loading the view.
    }
    func searchCars(){
        
       
            
            
      
            // param ["user_email"]  = emailUser.text! as NSObject
            var param = [NSString: NSObject]()
        
     
     //   param = ["type":getDictData.value(forKey: "type") as! NSObject,"from":"\(getDictData.value(forKey: "fromDate1")!) \(getDictData.value(forKey: "fromtime1")!)" as NSObject,"to":"\(String(describing: getDictData.value(forKey: "fromDate2")!)) \(getDictData.value(forKey: "fromtime2")!)" as NSObject,"latitude":getDictData.value(forKey: "latitude")  as! NSObject,"longitude":getDictData.value(forKey: "longitude") as! NSObject,"age":getDictData.value(forKey: "age") as! NSObject]
            
        param = ["":""  as! NSObject]
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            

            connection.startConnectionWithSting2(getUrlString: "getalllocations", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(((receivedData.value(forKey: "message") != nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                         //   IJProgressView.shared.hideProgressView()
                            
                        
                            
                            let getDataArr = receivedData.value(forKey: "data") as! NSArray
                            
                            if(getDataArr.count == 0)
                            {
                                
                            }
                            else
                            {
                            let getLatitudes = getDataArr.value(forKey: "latitude") as! NSArray
                            
                             let getLongitude = getDataArr.value(forKey: "longitude") as! NSArray
                            
                           
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! locationViewController
                             vc.getData = self.getDictData
                            
                            self.userData.setValue(self.getDictData, forKey: "getDictData")
                            
                          
                            
                vc.latitudeArr = getLatitudes
                            
                vc.longitudeArr = getLongitude
                            self.userData.setValue(getLatitudes, forKey: "getLatitudes")
                            self.userData.setValue(getLongitude, forKey: "getLongitude")
                    self.navigationController?.pushViewController(vc, animated: false)
                            
                            }
                            
                            
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
                        
                        self.searchCars()
                        
                        
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
        else{
            connection.startConnectionWithSting(getUrlString: "getalllocations", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(((receivedData.value(forKey: "message") != nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            //   IJProgressView.shared.hideProgressView()
                            
                            
                            
                            let getDataArr = receivedData.value(forKey: "data") as! NSArray
                            
                            if(getDataArr.count == 0)
                            {
                                
                            }
                            else
                            {
                                let getLatitudes = getDataArr.value(forKey: "latitude") as! NSArray
                                
                                let getLongitude = getDataArr.value(forKey: "longitude") as! NSArray
                                
                                
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! locationViewController
                                vc.getData = self.getDictData
                                
                                self.userData.setValue(self.getDictData, forKey: "getDictData")
                                
                                
                                
                                vc.latitudeArr = getLatitudes
                                
                                vc.longitudeArr = getLongitude
                                self.userData.setValue(getLatitudes, forKey: "getLatitudes")
                                self.userData.setValue(getLongitude, forKey: "getLongitude")
                                self.navigationController?.pushViewController(vc, animated: false)
                                
                            }
                            
                            
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
                        
                        self.searchCars()
                        
                        
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
