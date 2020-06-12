//
//  mybookingsViewController.swift
//  Carz4Hire
//
//  Created by user on 3/5/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class mybookingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var bookcar: UIButton!
    var userData = UserDefaults()
    let connection = webservices()
    var message = ""
    var getMutable = NSMutableArray()
    var getcancelbbokingId = Int()
    var cancelCard = Int()
 var getCountArr = NSArray()
    var getid = Int()
    var bookTap = String()
    var  getSeg = String()
    let validation:Validation = Validation.validationManager() as! Validation
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
var currentPrevious = String()
    @IBOutlet var loginView: UIView!
    @IBOutlet var tableView3: UITableView!
    @IBOutlet var tableView2: UITableView!
    @IBOutlet var tableView4: UITableView!
    
    @IBOutlet var currentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

  if(!(userData.value(forKey: "emailSave") == nil))
  {
    currentView.isHidden = false
    loginView.isHidden = true
    if(getSeg == "seg")
    {
        segmentedControl.selectedSegmentIndex = 3
        getQuotes()
    }
    else
    {
        segmentedControl.selectedSegmentIndex = 0
        self.currentPrevious = "current"
        getBookings()
        
    }
//    tableView.delegate = self
//    tableView.dataSource = self
//    tableView2.delegate = self
//    tableView2.dataSource = self
//    tableView3.delegate = self
//    tableView3.dataSource = self
        }
        
  else{
    currentView.isHidden = true
    loginView.isHidden = false
    
    
    
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        if(bookTap == "Yes")
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "myaccount") as! myAccountViewController

  self.navigationController?.pushViewController(vc, animated: true)
        }

        else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "booking")
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getCountArr.count
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if(tableView == tableView3)
//        {
//        if (editingStyle == UITableViewCellEditingStyle.delete) {
//
//            let getOb = getMutable.object(at: indexPath.row) as! NSDictionary
//            // let getReceiverInfo = getOb.value(forKey:"receiverinfo") as! NSDictionary
//
//            getid = getOb.value(forKey:"id") as! Int
//
//            deleteMessages()
//            }
//            
//            // delete data and row
//            
//            //            getMutable.remove(at: indexPath.row)
//            //
//            //            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func cancelBooking()
    {
               IJProgressView.shared.showProgressView(view: self.view)
            
            var param = [NSString: NSObject]()
            
           // booking_id,car_id
            param = ["booking_id":getcancelbbokingId as NSObject,"car_id":cancelCard as NSObject]
      
            IJProgressView.shared.showProgressView(view: self.view)
            //   connection.startConnectionWithStringGetType2(getUrlString: "getallquotes", outputBlock: { (receivedData) in
            connection.startConnectionWithSting2(getUrlString: "cancelbooking", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                //        connection.startConnectionWithStringGetType2(getUrlString: "deletequote" as NSString, outputBlock: { (receivedData) in
                if (self.connection.responseCode == 1){
                    print(receivedData)
                    if(!(receivedData.value(forKey: "message") == nil))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            IJProgressView.shared.hideProgressView()
                            self.currentPrevious = "upcoming"
                            //     let getDict = receivedData.value(forKey: "data") as! NSDictionary
                            self.getBookings()
                            
                        }
                        else{
                            
                            self.message = receivedData.value(forKey: "message") as! String
                            
                            
                            print(receivedData)
                            
                            
                            
                            let alertController = UIAlertController(title: "1 STOP RENTALS ", message: self.message, preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                IJProgressView.shared.hideProgressView()
                                
                            }
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                    }
                        
                    else{
                        _ =   receivedData.value(forKey: "error")
                        
                        
                        let message:String  = (receivedData.value(forKey: "errors") as AnyObject).value(forKey:"error") as! String
                        
                        
                        self.message = message
                        
                        
                        
                        self.message = message
                        
                        let alertController = UIAlertController(title: "1 STOP RENTALS ", message: self.message, preferredStyle: .alert)
                        
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
                    
                    
                    let alertController = UIAlertController(title: "1 STOP RENTALS ", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.deleteMessages()
                        
                        
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
    
    func deleteMessages()
    {
        IJProgressView.shared.showProgressView(view: self.view)
        
        var param = [NSString: NSObject]()
        
        
        param = ["quote_id":getid as NSObject]
        
        IJProgressView.shared.showProgressView(view: self.view)
        //   connection.startConnectionWithStringGetType2(getUrlString: "getallquotes", outputBlock: { (receivedData) in
        connection.startConnectionWithSting2(getUrlString: "deletequote", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
        
//        connection.startConnectionWithStringGetType2(getUrlString: "deletequote" as NSString, outputBlock: { (receivedData) in
            if (self.connection.responseCode == 1){
                print(receivedData)
                if(!(receivedData.value(forKey: "message") == nil))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        IJProgressView.shared.hideProgressView()
                        //     let getDict = receivedData.value(forKey: "data") as! NSDictionary
                        self.getQuotes()
                      
                    }
                    else{
                        
                        self.message = receivedData.value(forKey: "message") as! String
                        
                        
                        print(receivedData)
                        
                        
                        
                        let alertController = UIAlertController(title: "1 STOP RENTALS ", message: self.message, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            IJProgressView.shared.hideProgressView()
                            
                        }
                        
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                }
                    
                else{
                    _ =   receivedData.value(forKey: "error")
                    
                    
                    let message:String  = (receivedData.value(forKey: "errors") as AnyObject).value(forKey:"error") as! String
                    
                    
                    self.message = message
                    
                    
                    
                    self.message = message
                    
                    let alertController = UIAlertController(title: "1 STOP RENTALS ", message: self.message, preferredStyle: .alert)
                    
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
                
                
                let alertController = UIAlertController(title: "1 STOP RENTALS ", message: "Connection Error", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    IJProgressView.shared.hideProgressView()
                    
                    self.deleteMessages()
                    
                    
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
    
    func cancelBookings(sender:UIButton){
        
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let getOb = getMutable.object(at: indexPath.row) as! NSDictionary
        // let getReceiverInfo = getOb.value(forKey:"receiverinfo") as! NSDictionary
        
        getcancelbbokingId = getOb.value(forKey:"id") as! Int
        cancelCard = getOb.value(forKey:"car_id") as! Int
        let alertController = UIAlertController(title: "1 STOP RENTALS ", message: "Please note you will be charged the reservation fee if you cancel this booking.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Keep booking", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        
            
        
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel booking", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            self.cancelBooking()
          
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    func deleteBtn(sender:UIButton){
        
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let getOb = getMutable.object(at: indexPath.row) as! NSDictionary
        // let getReceiverInfo = getOb.value(forKey:"receiverinfo") as! NSDictionary
        
        getid = getOb.value(forKey:"id") as! Int
        
        deleteMessages()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tableView3)
        {
            let cell = tableView3.dequeueReusableCell(withIdentifier: "carz3", for: indexPath) as! carz4hireTableViewCell
        cell.btn2.tag = indexPath.row
               cell.btn2.addTarget(self, action: #selector(self.deleteBtn), for: .touchUpInside)
            let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "location") is NSNull))
            {
            let getlocation = getDetails.value(forKey: "location") as! String
            let decodedform = getlocation.decodeEmoji
            cell.locationgetlist.text = decodedform
            }
            else
            {
                cell.locationgetlist.text = ""
            }

               let car_image = getDetails.value(forKey: "car_image") as! String
            let getString = "http://carz4hire.com/carimages/"
            let getCOmbine = "\(getString)\(car_image)"
             let fileUrl1 = NSURL(string: getCOmbine)
            cell.imagecarlist.setImageWith(fileUrl1 as! URL)
            cell.backImg.setImageWith(fileUrl1 as! URL)
                    let end_date = getDetails.value(forKey: "end_date") as! String
               let start_date = getDetails.value(forKey: "start_date") as! String
            if(start_date == "1970-01-01 00:00:00")
            {
                cell.date.text = "No Dates required"
            }
            else
            {
            cell.date.text = "\(start_date) / \(end_date)"
            
            }
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.backImg.addSubview(blurEffectView)
            
            return cell
        }
        
            else if (tableView == tableView2)
        {
            let cell = tableView2.dequeueReusableCell(withIdentifier: "carz2", for: indexPath) as! carz4hireTableViewCell
            let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "location") is NSNull))
            {
            let getlocation = getDetails.value(forKey: "location") as! String
            let decodedform = getlocation.decodeEmoji
            cell.locationgetlist.text = decodedform
            }
            else
            {
                cell.locationgetlist.text = ""
            }
            let getCarinfo = getDetails.value(forKey: "carinfo") as! NSDictionary
    
            let car_image = getCarinfo.value(forKey: "default_car") as! String
            let getString = "http://carz4hire.com/carimages/"
            let getCOmbine = "\(getString)\(car_image)"
            let fileUrl1 = NSURL(string: getCOmbine)
            cell.imagecarlist.setImageWith(fileUrl1 as! URL)
            cell.backImg.setImageWith(fileUrl1 as! URL)
            let end_date = getDetails.value(forKey: "end_date") as! String
            let start_date = getDetails.value(forKey: "start_date") as! String
            if(start_date == "1970-01-01 00:00:00")
            {
                cell.date.text = "No Dates required"
            }
            else
            {
            cell.date.text = "\(start_date) / \(end_date)"
    
            }
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.backImg.addSubview(blurEffectView)
            return cell
        }
            
            else if (tableView == tableView4)
        {
            let cell = tableView4.dequeueReusableCell(withIdentifier: "carz4", for: indexPath) as! carz4hireTableViewCell
            cell.btn1.layer.cornerRadius = 5
            cell.btn1.layer.borderColor = UIColor.white.cgColor
            cell.btn1.layer.borderWidth = 1
            cell.btn1.clipsToBounds = true
            cell.btn1.tag = indexPath.row
            cell.btn1.addTarget(self, action: #selector(self.cancelBookings), for: .touchUpInside)
            let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "location") is NSNull))
            {
            let getlocation = getDetails.value(forKey: "location") as! String
            let decodedform = getlocation.decodeEmoji
            cell.locationgetlist.text = decodedform
            }
            else
            {
                cell.locationgetlist.text = ""
            }
            let getCarinfo = getDetails.value(forKey: "carinfo") as! NSDictionary
    
            let car_image = getCarinfo.value(forKey: "default_car") as! String
            let getString = "http://carz4hire.com/carimages/"
            let getCOmbine = "\(getString)\(car_image)"
            let fileUrl1 = NSURL(string: getCOmbine)
            cell.imagecarlist.setImageWith(fileUrl1 as! URL)
            cell.backImg.setImageWith(fileUrl1 as! URL)
            let end_date = getDetails.value(forKey: "end_date") as! String
            let start_date = getDetails.value(forKey: "start_date") as! String
            if(start_date == "1970-01-01 00:00:00")
            {
            cell.date.text = "No Dates required"
            }
            else
            {
                  cell.date.text = "\(start_date) / \(end_date)"
            }
    
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.backImg.addSubview(blurEffectView)
            
            return cell
        }
        else
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carz", for: indexPath) as! carz4hireTableViewCell
          
            let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "location") is NSNull))
            {
                let getlocation = getDetails.value(forKey: "location") as! String
                let decodedform = getlocation.decodeEmoji
                cell.locationgetlist.text = decodedform
                
            }
       else
            {
                cell.locationgetlist.text = ""
            }
    
    
            let getCarinfo = getDetails.value(forKey: "carinfo") as! NSDictionary
            
            let car_image = getCarinfo.value(forKey: "default_car") as! String
            let getString = "http://carz4hire.com/carimages/"
            let getCOmbine = "\(getString)\(car_image)"
            let fileUrl1 = NSURL(string: getCOmbine)
            cell.imagecarlist.setImageWith(fileUrl1 as! URL)
            cell.backImg.setImageWith(fileUrl1 as! URL)
            let end_date = getDetails.value(forKey: "end_date") as! String
            let start_date = getDetails.value(forKey: "start_date") as! String
            if(start_date == "1970-01-01 00:00:00")
            {
                cell.date.text = "No Dates required"
            }
            else
            {
            cell.date.text = "\(start_date) / \(end_date)"
    
            }
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.backImg.addSubview(blurEffectView)
            
//            if(dates < getstartdate)
//            {
//
//            }
        return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == tableView3)
        {
                        let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "bus_id") == nil))
            {
            if(!(getDetails.value(forKey: "bus_id") is NSNull))
            {
                     let vc = storyboard?.instantiateViewController(withIdentifier: "busdetails") as! detailsViewController
                vc.getIdBus = getDetails.value(forKey: "bus_id") as! Int
                vc.typeList = "bus"
               vc.saveq = "1"
                self.navigationController?.pushViewController(vc, animated: false)
            }
                else
            {
                self.userData.removeObject(forKey: "getcompanyCost")
                self.userData.removeObject(forKey: "upcoming")
                let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail")
                
                let getData = getCountArr.object(at: indexPath.row) as! NSDictionary
                let idget2 = (getData.value(forKey:"id") as! Int)
                let idget = (getData.value(forKey:"car_id") as! Int)
                let cell = tableView.cellForRow(at: indexPath) as! carz4hireTableViewCell
                let getCompanyPrice = getData.value(forKey: "companycharges")
                let getCompanyPriceB = getData.value(forKey: "bookingcharges")
                let gethot = getData.value(forKey: "is_offer")
                let getdatein = getData.value(forKey: "start_date") as! String
                let getdateout = getData.value(forKey: "end_date") as! String
                let car_type = getData.value(forKey: "car_type") as! String
                var latLo = ""
                if(!(getData.value(forKey: "location") is NSNull))
                {
                    latLo = getData.value(forKey: "location") as! String
                }
                else
                {
                    latLo = ""
                }
                let getSepin:NSArray = getdatein.components(separatedBy: " ") as NSArray
                let getSepout:NSArray = getdateout.components(separatedBy: " ") as NSArray
                
                userData.set(getCompanyPriceB, forKey: "bookinc")
                userData.set(gethot, forKey: "gethot")
                //   let getStrCell = cell.moneyCar.text
                userData.set(getCompanyPrice, forKey: "getCompanyPrice")
                //     print(getStrCell)
                userData.set(idget, forKey: "idget")
                userData.set(car_type, forKey: "car_type")
                userData.set(idget2, forKey: "savequoteIdget")
                userData.set("saveQuotes", forKey: "saveQuotes")
                
                let combineData = ["fromDate1":getSepin[0] ,"fromtime1":getSepin[1],"fromDate2":getSepout[0],"fromtime2":getSepout[1],"location":latLo]
                
                userData.set(combineData, forKey: "getData")
                self.navigationController?.pushViewController(vc!, animated: false)
                }
            }
            else
            {
            self.userData.removeObject(forKey: "getcompanyCost")
             self.userData.removeObject(forKey: "upcoming")
            let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail")
      
            let getData = getCountArr.object(at: indexPath.row) as! NSDictionary
             let idget2 = (getData.value(forKey:"id") as! Int)
            let idget = (getData.value(forKey:"car_id") as! Int)
            let cell = tableView.cellForRow(at: indexPath) as! carz4hireTableViewCell
            let getCompanyPrice = getData.value(forKey: "companycharges")
             let getCompanyPriceB = getData.value(forKey: "bookingcharges")
             let gethot = getData.value(forKey: "is_offer")
             let getdatein = getData.value(forKey: "start_date") as! String
            let getdateout = getData.value(forKey: "end_date") as! String
             let car_type = getData.value(forKey: "car_type") as! String
            var latLo = ""
            if(!(getData.value(forKey: "location") is NSNull))
            {
              latLo = getData.value(forKey: "location") as! String
            }
            else
            {
                latLo = ""
            }
            let getSepin:NSArray = getdatein.components(separatedBy: " ") as NSArray
            let getSepout:NSArray = getdateout.components(separatedBy: " ") as NSArray

              userData.set(getCompanyPriceB, forKey: "bookinc")
                     userData.set(gethot, forKey: "gethot")
         //   let getStrCell = cell.moneyCar.text
            userData.set(getCompanyPrice, forKey: "getCompanyPrice")
       //     print(getStrCell)
            userData.set(idget, forKey: "idget") 
            userData.set(car_type, forKey: "car_type")
            userData.set(idget2, forKey: "savequoteIdget")
            userData.set("saveQuotes", forKey: "saveQuotes")
          
              let combineData = ["fromDate1":getSepin[0] ,"fromtime1":getSepin[1],"fromDate2":getSepout[0],"fromtime2":getSepout[1],"location":latLo]
            
            userData.set(combineData, forKey: "getData")
            self.navigationController?.pushViewController(vc!, animated: false)
            }
        }
       
        else if(tableView == tableView4)
        {
                     let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "bus_id") == nil))
            {
            if(!(getDetails.value(forKey: "bus_id") is NSNull))
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "busdetails") as! detailsViewController
                vc.getIdBus = getDetails.value(forKey: "bus_id") as! Int
                vc.typeList = "bus"
                vc.saveq = "1"
                self.navigationController?.pushViewController(vc, animated: false)
            }
            }
            else
            {
            self.userData.removeObject(forKey: "getcompanyCost")
                    self.userData.removeObject(forKey: "saveQuotes")
            userData.removeObject(forKey: "savequoteIdget")
            let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail")
            let getData = getCountArr.object(at: indexPath.row) as! NSDictionary
            let idget = (getData.value(forKey:"car_id") as! Int)
             let getCompanyPrice = getData.value(forKey: "companycharges")
            let carinfo = getData.value(forKey: "carinfo") as! NSDictionary
            
            
            let gethot = getData.value(forKey: "offer_status")
            
            let car_type = carinfo.value(forKey: "car_type") as! String
            
            userData.set("upcoming", forKey: "upcoming")
            userData.set(gethot, forKey: "gethot")
            //   let getStrCell = cell.moneyCar.text
            
            userData.set(getCompanyPrice, forKey: "getCompanyPrice")
            //     print(getStrCell)
            userData.set(idget, forKey: "idget")
            userData.set(car_type, forKey: "car_type")
            
          //  userData.set("saveQuotes", forKey: "saveQuotes")
            
            let getdatein = getData.value(forKey: "start_date") as! String
            let getdateout = getData.value(forKey: "end_date") as! String
            
            let latLo = getData.value(forKey: "location") as! String
            let getSepin:NSArray = getdatein.components(separatedBy: " ") as NSArray
            let getSepout:NSArray = getdateout.components(separatedBy: " ") as NSArray
            let combineData = ["fromDate1":getSepin[0] ,"fromtime1":getSepin[1],"fromDate2":getSepout[0],"fromtime2":getSepout[1],"location":latLo]
            userData.set(combineData, forKey: "getData")
            self.navigationController?.pushViewController(vc!, animated: false)
            }
        }
        
        else if (tableView == tableView2)
        {
            
             self.userData.removeObject(forKey: "saveQuotes")
            userData.removeObject(forKey: "savequoteIdget")
            self.userData.removeObject(forKey: "getcompanyCost")
            self.userData.removeObject(forKey: "upcoming")
            self.message = "If you would like to speak to our dedicated customer service team regarding this rental please visit the “contact us” page."
            

            
            let alertController = UIAlertController(title: "1 STOP RENTALS ", message: self.message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
               
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        else{
                     let getDetails = getCountArr.object(at: indexPath.row) as! NSDictionary
            if(!(getDetails.value(forKey: "bus_id") == nil))
            {
            if(!(getDetails.value(forKey: "bus_id") is NSNull))
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "busdetails") as! detailsViewController
                vc.getIdBus = getDetails.value(forKey: "bus_id") as! Int
                vc.typeList = "bus"
                vc.saveq = "1"
                self.navigationController?.pushViewController(vc, animated: false)
            }
            }
            else
            {
            self.userData.removeObject(forKey: "getcompanyCost")
            self.userData.removeObject(forKey: "saveQuotes")
            userData.removeObject(forKey: "savequoteIdget")
            let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail")
            let getData = getCountArr.object(at: indexPath.row) as! NSDictionary
            let idget = (getData.value(forKey:"car_id") as! Int)
            let getCompanyPrice = getData.value(forKey: "companycharges")
            let carinfo = getData.value(forKey: "carinfo") as! NSDictionary
            
            
            let gethot = getData.value(forKey: "offer_status")
            
            let car_type = carinfo.value(forKey: "car_type") as! String
            
            userData.set("upcoming", forKey: "upcoming")
            userData.set(gethot, forKey: "gethot")
            //   let getStrCell = cell.moneyCar.text
            
            userData.set(getCompanyPrice, forKey: "getCompanyPrice")
            //     print(getStrCell)
            userData.set(idget, forKey: "idget")
            userData.set(car_type, forKey: "car_type")
            
            //  userData.set("saveQuotes", forKey: "saveQuotes")
            let getdatein = getData.value(forKey: "start_date") as! String
            let getdateout = getData.value(forKey: "end_date") as! String
            
            let latLo = getData.value(forKey: "location") as! String
            let getSepin:NSArray = getdatein.components(separatedBy: " ") as NSArray
            let getSepout:NSArray = getdateout.components(separatedBy: " ") as NSArray
            let combineData = ["fromDate1":getSepin[0] ,"fromtime1":getSepin[1],"fromDate2":getSepout[0],"fromtime2":getSepout[1],"location":latLo]
            userData.set(combineData, forKey: "getData")
            
            self.navigationController?.pushViewController(vc!, animated: false)
            }
        }
    }
    @IBAction func segTap(_ sender: UISegmentedControl) {
        
         if segmentedControl.selectedSegmentIndex == 0{
            
            currentPrevious = "current"
            getBookings()
            
        }
        else if segmentedControl.selectedSegmentIndex == 1{
            currentPrevious = "previous"
            getBookings()
    }
   else if segmentedControl.selectedSegmentIndex == 2{
            
            currentPrevious = "upcoming"
            getBookings()
        }
        else
         {
               getQuotes()
        }
        }
    func getQuotes(){
        
            // param ["user_email"]  = emailUser.text! as NSObject
        
            
        
        
            
            IJProgressView.shared.showProgressView(view: self.view)
            connection.startConnectionWithStringGetType2(getUrlString: "getallquotes", outputBlock: { (receivedData) in

                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            
            let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                           
                            self.getCountArr = getDataDict.value(forKey: "data") as! NSArray
                            if(self.getCountArr.count == 0)
                            {
                                self.bookcar.isHidden = false
                            }
                            else
                            {
                                self.bookcar.isHidden = true
                            }
                          self.getMutable = self.getCountArr.mutableCopy() as! NSMutableArray
                            self.tableView.isHidden = true
                            self.tableView2.isHidden = true
                            self.tableView3.isHidden = false
                            self.tableView3.delegate = self
                            self.tableView3.dataSource = self
                               self.tableView3.reloadData()
                            
                            
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
                        
                        self.getQuotes()
                        
                        
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
        
        func getBookings()
    {
        
       var param = [NSString: NSObject]()
            param = ["type":currentPrevious as! NSObject]
        
        IJProgressView.shared.showProgressView(view: self.view)
           connection.startConnectionWithSting2(getUrlString: "getmybookings", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
                
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                               IJProgressView.shared.hideProgressView()
                            let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                            
                            self.getCountArr = getDataDict.value(forKey: "data") as! NSArray
                            if(self.getCountArr.count == 0)
                            {
                                self.bookcar.isHidden = false
                            }
                            else
                            {
                                self.bookcar.isHidden = true
                            }
                            self.getMutable = self.getCountArr.mutableCopy() as! NSMutableArray
                            
                            if(self.currentPrevious == "current")
                            {
                                self.tableView.isHidden = false
                                self.tableView2.isHidden = true
                                self.tableView3.isHidden = true
                                self.tableView4.isHidden = true
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                            self.tableView.reloadData()
                            }
                                
                 else if (self.currentPrevious == "upcoming")
                            {
                                self.tableView.isHidden = true
                                self.tableView2.isHidden = true
                                self.tableView3.isHidden = true
                                self.tableView4.isHidden = false
                                self.tableView4.delegate = self
                                self.tableView4.dataSource = self
                                self.tableView4.reloadData()
                            }
                            else
                            {
                                 self.tableView4.isHidden = true
                                self.tableView.isHidden = true
                                self.tableView2.isHidden = false
                                self.tableView3.isHidden = true
                                self.tableView2.delegate = self
                                self.tableView2.dataSource = self
                                self.tableView2.reloadData()
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
                        
                        
                        
                        
                    }
                    
                }
                else{
                    
                    print(receivedData)
                    
                    
                    let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.getQuotes()
                        
                        
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
    override func viewWillAppear(_ animated: Bool) {
        currentView.isHidden = false
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
