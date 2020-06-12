//
//  detailsViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 19/11/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate {
    @IBOutlet var nameSupplier: UILabel!
  
    
    @IBOutlet var saveQuoteBtn: UIButton!
    @IBOutlet var companyLogo: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var carscrollView: UIScrollView!
    @IBOutlet var addressSuplier: UILabel!
   
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lastView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var toggleBtn: UIButton!
    var userData = UserDefaults()
    var typeList = String()
    var headerSection = Int()
    var arraySpeed = NSMutableArray()
    var getIdBus = Int()
    var saveq = String()
    var connection = webservices()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    var getcarData = NSDictionary()
    var toggleBtns = Bool()
    var urlApi = String()
       var cell =  WheelCell()
    var imgStr = String()
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    var imageCell = ["Top speed.png","0-60 mph.png","Transmission.png","year.png"]
    var titleArr  = ["Top speed","0-60 MPH","Transmission","Year"]
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.lastView.frame.origin.y + self.lastView.frame.size.height + 20)
        let imaged = UIImage(named: "blank-square.png")
        toggleBtn.setImage(imaged, for: .normal)
        if(typeList == "bus")
        {
                self.sectionNames = [ "General Information", "Driver and passenger safety", "Wait times and soilage charge","Deposit & Excess"];
             saveQuoteBtn.isHidden = false
            urlApi = "getbusdetails"
               imgStr = "http://carz4hire.com/busimages/"
            if(saveq == "1")
            {
                self.saveQuoteBtn.isHidden = true
            }
            else
            {
                  self.saveQuoteBtn.isHidden = false
            }
        }
        else if (typeList == "helicopter")
        {
                 self.sectionNames = [ "General Information", "Driver and passenger safety", "Regulations"];
             saveQuoteBtn.isHidden = true
            urlApi = "gethelicopterdetails"
            imgStr = "http://carz4hire.com/helicopterimages/"
        }
        else
        {
                 self.sectionNames = [ "General Information", "Driver and passenger safety"];
            saveQuoteBtn.isHidden = true
   imgStr = "http://carz4hire.com/horseimages/"
            urlApi = "gethorsedetails"
            
        }
        
        self.getDetails()
        // Do any additional setup after loading the view.
    }
    
    func saveQuote()
    {
    
            
            var param = [NSString: NSObject]()

        param = ["bus_id":getIdBus as NSObject,"from":""  as NSObject,"to":"" as NSObject,"location":"" as NSObject,"bookingcharges":0,"companycharges":0,"is_offer":0] as! [NSString : NSObject]
            
            print(param)
            
       
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
            
            connection.startConnectionWithSting2(getUrlString: "savequote", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            IJProgressView.shared.hideProgressView()
                            //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "thanksPage")
                            //                        self.navigationController?.pushViewController(vc!, animated: true)
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Added in quote", preferredStyle: .alert)
                            //    self.userData.set(20, forKey: "finalPRiceTxt")
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mybookings") as! mybookingsViewController
                                
                                vc.getSeg = "seg"
                                
                                self.userData.set("seg", forKey: "getSeg")
                                
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
                    
                    
                    
                    
                }
                else{
                    
                    print(receivedData)
                    
                    
                    let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.saveQuote()
                        
                        
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
        
    
    @IBAction func callbtn(_ sender: Any) {
        if(toggleBtn.currentImage == UIImage(named:"blank-square.png"))
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Accept the terms and conditions", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
                
                
            }
            
            
            alertController.addAction(okAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else
        {
        let phoneNumber = "01204777200"
        let phone = "tel://" + phoneNumber
        let url = NSURL(string: phone)
        
        if let url = url {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url as URL)
            }
            else {
                UIApplication.shared.openURL(url as URL)
            }
            print(url)
        } else {
            print("There was an error")
        }
        }
    }
    @IBAction func togglr(_ sender: Any) {
        if(toggleBtns == false)
        {
            toggleBtns = true
            let imaged = UIImage(named: "check-box.png")
            toggleBtn.setImage(imaged, for: .normal)
        }
        else
        {
            toggleBtns = false
            let imaged = UIImage(named: "blank-square.png")
            toggleBtn.setImage(imaged, for: .normal)
        }
    }

    @IBAction func savequote(_ sender: Any) {
  //      self.saveQuote()
        if(toggleBtn.currentImage == UIImage(named:"blank-square.png"))
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Accept the terms and conditions", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
                
                
            }
            
            
            alertController.addAction(okAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else
        {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendrequest1") as! sendreuest2ViewController
       vc.getTypeD = "bus"
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getDetails()
    {
        
        
            
            
            var param = [NSString: NSObject]()
            
            
            param = ["id":getIdBus as NSObject]
            
            print(param)
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)

        connection.startConnectionWithSting2(getUrlString: urlApi as NSString, method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                    
                    if (self.connection.responseCode == 1){
                        
                        print(receivedData)
                        
                        if(!((receivedData.value(forKey: "message") == nil)))
                        {
                            if(receivedData.value(forKey: "message") as! String == "success")
                            {
                                
                                IJProgressView.shared.hideProgressView()
                              
                                
                               self.getcarData = receivedData.value(forKey: "data") as! NSDictionary
//                                self.reservationCharges = self.getcarData.value(forKey: "reservation_charges") as! Int
//
                         
                             let generalInfo = self.getcarData.value(forKey: "generalinfo") as! String
                                self.titleLbl.text = self.getcarData.value(forKey: "title") as! String
                             let safety = self.getcarData.value(forKey: "safety") as! String
                                if(!((self.getcarData.value(forKey: "waittimes") is NSNull) || (self.getcarData.value(forKey: "waittimes") == nil)))
                                {
                                let waittimes = self.getcarData.value(forKey: "waittimes") as! String
                                    
                                            let deposit = self.getcarData.value(forKey: "deposit") as! String
                                    self.sectionItems = [ ["\(generalInfo)"],
                                                          ["\(safety)"], ["\(waittimes)"] ,["\(deposit)"]];
                                }
                                    else if (!((self.getcarData.value(forKey: "regulations") is NSNull) || (self.getcarData.value(forKey: "regulations") == nil)))
                                {
                                     let regulations = self.getcarData.value(forKey: "regulations") as! String
                                    self.sectionItems = [ ["\(generalInfo)"],
                                                          ["\(safety)"],["\(regulations)"]];
                                }
                                else
                                {
                                    self.sectionItems = [ ["\(generalInfo)"],
                                                          ["\(safety)"]];
                                }
                                
//                               let year = self.getcarData.value(forKey: "year") as! String
//
                                
                         

//                                let getStr = "Have a special request, need to make multiple bookings or even add an additional driver?\n\nThen Please call our friendly team on:01204777200\n\nOur call centre is open:Monday to sunday 9am-10pm\n\nOut of hours please email:1stoprentals@mail.com\n\nWe can assist you with any queries you may have.\n\n*Most FAQ answers are usually covered in the terms and conditions section."
//
//                                //
//                                //        let attributedString = NSMutableAttributedString(string: "I agree to the terms of serviceand privacy policyPLEASE NOTE: please translateterms of service and privacy policy as well, and leave the around your translations just as in the English version of this message.")
//                                //        attributedString.addAttribute(nslink, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
//
//
//
//
//                                //        cell.lbl_name.attributedText = aAttrString
//
                            
                                
                                
//
                             let getsupplier_information = self.getcarData.value(forKey: "supplierinfo") as! NSDictionary
//
                           self.nameSupplier.text = getsupplier_information.value(forKey: "name") as! String
//
                               self.addressSuplier.text = getsupplier_information.value(forKey: "address") as! String
                                
                                let getcarsImges = self.getcarData.value(forKey: "imagesinfo") as! NSArray
                                for x in 0..<getcarsImges.count
                                {
                                    let imageviewdata = UIImageView()
                                    imageviewdata.frame = CGRect(x: CGFloat(self.carscrollView.frame.size.width * CGFloat(x)), y: 0, width: self.carscrollView.frame.size.width, height: self.carscrollView.frame.size.height)
                                    imageviewdata.contentMode = .scaleAspectFit;
                                    
                                    if(x == 0)
                                    {
                                        let getindex = getcarsImges.object(at: 0)
                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                        let stringAppend2 = self.imgStr
                                        
                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
                                        let fileUrl1 = NSURL(string: imagecar)
                                        print("fileUrl1",fileUrl1)
                                        imageviewdata.setImageWith(fileUrl1! as URL)
                                    }
                                        
                                        
                                    else if(x == 1)
                                    {
                                        let getindex = getcarsImges.object(at: 1)
                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                        let stringAppend2 = self.imgStr
                                        
                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
                                        let fileUrl1 = NSURL(string: imagecar)
                                        print("fileUrl1",fileUrl1)
                                        imageviewdata.setImageWith(fileUrl1! as URL)
                                    }
                                        
                                    else if(x == 2)
                                    {
                                        let getindex = getcarsImges.object(at: 2)
                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                        let stringAppend2 = self.imgStr
                                        
                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
                                        let fileUrl1 = NSURL(string: imagecar)
                                        print("fileUrl1",fileUrl1)
                                        imageviewdata.setImageWith(fileUrl1! as URL)
                                    }
                                        
                                    else if(x == 3)
                                    {
                                        let getindex = getcarsImges.object(at: 3)
                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                        let stringAppend2 = self.imgStr
                                        
                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
                                        let fileUrl1 = NSURL(string: imagecar)
                                        print("fileUrl1",fileUrl1)
                                        imageviewdata.setImageWith(fileUrl1! as URL)
                                    }
                                    imageviewdata.contentMode = .scaleAspectFill
                                    imageviewdata.clipsToBounds = true
                                    self.carscrollView.addSubview(imageviewdata)
                                    self.carscrollView.isPagingEnabled = true
                                    
                                }
                                self.carscrollView.contentSize = CGSize(width: self.carscrollView.frame.size.width * CGFloat(getcarsImges.count), height: self.carscrollView.frame.size.height)
                                
//
                           let getcompanyLogo =  self.getcarData.value(forKey:"company_logo")  as! String
//
                               let stringAppend = "http://carz4hire.com/companylogo/"
//
                               let imageCompany = "\(stringAppend)\(getcompanyLogo)"

                               let fileUrl = NSURL(string: imageCompany)
                             self.companyLogo.setImageWith(fileUrl! as URL)
//                                let getcarsImges = self.getcarData.value(forKey: "imagesinfo") as! NSArray
//
//                                for x in 0..<getcarsImges.count
//                                {
//                                    let imageviewdata = UIImageView()
//                                    imageviewdata.frame = CGRect(x: CGFloat(self.carscrollview.frame.size.width * CGFloat(x)), y: 0, width: self.carscrollview.frame.size.width, height: self.carscrollview.frame.size.height)
//                                    imageviewdata.contentMode = .scaleAspectFit;
//
//                                    if(x == 0)
//                                    {
//                                        let getindex = getcarsImges.object(at: 0)
//                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
//                                        let stringAppend2 = "http://carz4hire.com/carimages/"
//
//                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
//                                        let fileUrl1 = NSURL(string: imagecar)
//                                        print("fileUrl1",fileUrl1)
//                                        imageviewdata.setImageWith(fileUrl1! as URL)
//                                    }
//
//
//                                    else if(x == 1)
//                                    {
//                                        let getindex = getcarsImges.object(at: 1)
//                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
//                                        let stringAppend2 = "http://carz4hire.com/carimages/"
//
//                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
//                                        let fileUrl1 = NSURL(string: imagecar)
//                                        print("fileUrl1",fileUrl1)
//                                        imageviewdata.setImageWith(fileUrl1! as URL)
//                                    }
//
//                                    else if(x == 2)
//                                    {
//                                        let getindex = getcarsImges.object(at: 2)
//                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
//                                        let stringAppend2 = "http://carz4hire.com/carimages/"
//
//                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
//                                        let fileUrl1 = NSURL(string: imagecar)
//                                        print("fileUrl1",fileUrl1)
//                                        imageviewdata.setImageWith(fileUrl1! as URL)
//                                    }
//
//                                    else if(x == 3)
//                                    {
//                                        let getindex = getcarsImges.object(at: 3)
//                                        let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
//                                        let stringAppend2 = "http://carz4hire.com/carimages/"
//
//                                        let imagecar = "\(stringAppend2)\(getcarLogo)"
//                                        let fileUrl1 = NSURL(string: imagecar)
//                                        print("fileUrl1",fileUrl1)
//                                        imageviewdata.setImageWith(fileUrl1! as URL)
//                                    }
//
//                                    imageviewdata.contentMode = .scaleAspectFill
//                                    imageviewdata.clipsToBounds = true
//                                    self.carscrollview.addSubview(imageviewdata)
//                                    self.carscrollview.isPagingEnabled = true
//
//
//                                }
//                                self.carscrollview.contentSize = CGSize(width: self.carscrollview.frame.size.width * CGFloat(getcarsImges.count), height: self.carscrollview.frame.size.height)
//
//                                let carName = self.getcarData.value(forKey:"cartitle") as! String
//                                self.nameCar.text = carName
//
//                                let getcarType = self.getcarData.value(forKey:"car_type") as! String
//                                if(getcarType == "Chauffeur")
//                                {
//
//                                    self.lbl1.text = "Quotation will be send to you by email."
//                                    self.lbl2.text = "An agent will call you to take payment."
//
//
//
//                                    self.finalPrice.isHidden = false
//
//                                    self.bookCarBtn.setTitle("Send Request", for: .normal)
//                                    self.bookCarBtn.addTarget(self, action: #selector(self.sendRequest), for: .touchUpInside)
//
//                                    if(!(self.userData.value(forKey: "getcompanyCost") == nil))
//                                    {
//                                        self.savequotebtn.isHidden = false
//                                        self.validtill.isHidden = true
//                                        self.reservetodaytxt.isHidden = true
//                                        self.reservetodaytxt.text = ""
//                                        //                let getIntd = self.userData.value(forKey: "getcompanyCost") as! Int
//                                        //                let getT = self.userData.value(forKey:"bookCharges") as! Int
//                                        //                let chargescom = getIntd - getT
//                                        //                print(" = rererer \(chargescom)")
//
//                                        //   self.userData.set(chargescom, forKey: "compnyCharges")
//                                        //    let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
//                                        let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
//                                        let companychargesg = self.getcarData.value(forKey:"company_charges") as! Int
//
//                                        let getBo =  self.reservationCharges + bookingchargesg
//
//                                        self.userData.set(getBo, forKey: "bookCharges")
//                                        //                let getPercentage = (bookingchargesg * companychargesg ) / 100
//
//
//                                        //                let validto = gethotoffersData.value(forKey:"validto") as! String
//                                        //                let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
//                                        //                let getTime = validfrom.toDateTime1()
//                                        //                let gettime2 = validto.toDateTime1()
//                                        // self.validtill.text = "\(getTime) - \(gettime2)"
//                                    }
//
//
//                                    else if(!(self.userData.value(forKey: "saveQuotes") == nil))
//                                    {
//                                        self.savequotebtn.isHidden = true
//                                    }
//
//                                    else if(!(self.userData.value(forKey: "upcoming") == nil))
//                                    {
//                                        self.savequotebtn.isHidden = true
//                                    }
//                                    else
//                                    {
//
//                                        let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
//                                        let companychargesg = self.getcarData.value(forKey:"company_charges") as! Int
//
//                                        // let getPercentage = (bookingchargesg * companychargesg ) / 100
//
//                                        let getBo =  self.reservationCharges + bookingchargesg
//
//                                        self.userData.set(getBo, forKey: "bookCharges")
//
//                                        self.userData.set(self.getcarData.value(forKey:"company_charges"), forKey: "compnyCharges")
//                                        self.savequotebtn.isHidden = false
//                                    }
//                                    //            if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//                                    //            {
//                                    //                self.finalPrice.text = "Please call our reservations team to book this vehicle"
//                                    //                self.reservetodaytxt.text = ""
//                                    //            }
//                                    //            else
//                                    //            {
//                                    self.finalPrice.text = "From £99"
//                                    //}
//                                }
//                                else
//                                {
//                                    var dateStr = self.getDataDictGWt1.value(forKey: "fromDate1")
//
//                                    var dateStr2 = self.getDataDictGWt1.value(forKey: "fromDate2")
//                                    print(dateStr2)
//                                    print(dateStr)
//                                    // Set date format
//                                    var dateFmt = DateFormatter()
//
//                                    dateFmt.timeZone = NSTimeZone.default
//
//                                    dateFmt.dateFormat =  "yyyy/MM/dd"
//                                    var dateFmt2 = DateFormatter()
//                                    dateFmt2.timeZone = NSTimeZone.default
//                                    //dateFmt.timeZone = NSTimeZone.default
//                                    dateFmt2.dateFormat =  "yyyy/MM/dd"
//                                    // Get NSDate for the given string
//                                    var firstDate = dateFmt.date(from: dateStr as! String)
//                                    var secondDate = dateFmt.date(from: dateStr2 as! String)
//
//                                    print(firstDate!)
//                                    if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//                                    {
//                                        self.bookCarBtn.setTitle("Call Now", for: .normal)
//
//                                        self.bookCarBtn.addTarget(self, action: #selector(self.callBtnTap), for: .touchUpInside)
//                                    }
//                                    else
//
//                                    {
//                                        self.bookCarBtn.setTitle("Book this car", for: .normal)
//
//                                        self.bookCarBtn.addTarget(self, action: #selector(self.bookCars), for: .touchUpInside)
//                                    }
//
//                                    self.finalPrice.isHidden = false
//                                    self.toggleBtn.isHidden = false
//                                    self.acceptTxt.isHidden = false
//                                    self.lbl1.text = "Reservation fee will deducted from Final price."
//                                    self.lbl2.text = "Remainder of balance payable on the day of rental."
//                                    self.reservetodaytxt.isHidden = false
//                                    // self.reservetodaytxt.text = "Reserve today with £20,4443"
//
//                                    if(!(self.userData.value(forKey: "getcompanyCost") == nil))
//                                    {
//
//                                        self.validtill.isHidden = false
//                                        self.reservetodaytxt.isHidden = true
//                                        self.reservetodaytxt.text = ""
//                                        let getIntd = self.userData.value(forKey: "getcompanyCost") as! Int
//                                        let getT = self.userData.value(forKey:"bookCharges") as! Int
//
//                                        let chargescom = getIntd - getT
//                                        print(" = rererer \(chargescom)")
//                                        self.userData.set(chargescom, forKey: "compnyCharges")
//                                        let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
//                                        //  let bookingchargesg = self.getBook
//                                        let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
//                                        let companychargesg = gethotoffersData.value(forKey:"companycharges") as! Int
//
//
//
//                                        // let getPercentage = self.getBook
//
//                                        let getBo =  self.reservationCharges + bookingchargesg
//
//                                        self.userData.set(companychargesg, forKey: "bookCharges")
//                                        // self.userData.set(getPercentage, forKey: "bookCharges")
//                                        //self.userData.set(bookingchargesg, forKey: "bookCharges")
//                                        self.userData.set(companychargesg, forKey: "compnyCharges")
//                                        let validto = gethotoffersData.value(forKey:"validto") as! String
//                                        let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
//                                        let getTime = validfrom.toDateTime1()
//                                        let gettime2 = validto.toDateTime1()
//                                        self.validtill.text = "\(getTime) - \(gettime2)"
//                                        //  self.validtill.text = "434343"
//                                        if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//                                        {
//                                            self.finalPrice.text = "Please call our reservations team to book this vehicle"
//                                            self.reservetodaytxt.text = ""
//                                        }
//                                        else
//                                        {
//                                            self.finalPrice.text = "Final Price: £\(companychargesg)"
//
//                                            self.lbl1.text = "Full payment payable immediately on booking with 1SR"
//                                        }
//
//                                        self.lbl2.text = " Offer only valid for the dates listed above"
//                                        self.reservetodaytxt.isHidden = false
//                                        self.savequotebtn.isHidden = true
//
//                                        // self.reservetodaytxt.text = "Reserve today with £\(getT)"
//                                    }
//
//                                    else if(!(self.userData.value(forKey: "saveQuotes") == nil))
//                                    {
//                                        //                self.validtill.isHidden = false
//                                        //                self.reservetodaytxt.isHidden = true
//                                        //                self.reservetodaytxt.text = ""
//
//                                        //                if(gethotoffersData == "")
//                                        //                {
//                                        //
//                                        //                }
//                                        let geth = self.userData.value(forKey: "gethot") as! Int
//
//                                        if(geth == 1)
//                                        {
//                                            self.validtill.isHidden = false
//                                            self.reservetodaytxt.isHidden = true
//                                            self.reservetodaytxt.text = ""
//                                            let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
//                                            let bookingchargesg = gethotoffersData.value(forKey:"bookingcharges") as! Int
//                                            let companychargesg = gethotoffersData.value(forKey:"companycharges") as! Int
//                                            //                    let getPercentage = (bookingchargesg * companychargesg ) / 100
//                                            self.userData.set(bookingchargesg, forKey: "bookCharges")
//                                            // self.userData.set(bookingchargesg, forKey: "bookCharges")
//                                            self.userData.set(companychargesg, forKey: "compnyCharges")
//                                            let validto = gethotoffersData.value(forKey:"validto") as! String
//                                            let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
//                                            let getTime = validfrom.toDateTime1()
//                                            let gettime2 = validto.toDateTime1()
//                                            self.validtill.text = "\(getTime) - \(gettime2)"
//                                            self.lbl1.text = "Full payment payable immediately on booking with 1SR"
//                                            self.lbl2.text = " Offer only valid for the dates listed above"
//                                            //  self.validtill.text = "434343"
//
//                                        }
//                                        else
//                                        {
//                                            self.validtill.isHidden = true
//                                            self.lbl1.text = "Reservation fee will deducted from Final price."
//                                            self.lbl2.text = "Remainder of balance payable on the day of rental."
//                                            //       let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
//                                            let bookingchargesg = self.getBook
//                                            let reservationP = self.userData.value(forKey: "strReservation") as! Int
//                                            let getReser = self.userData.value(forKey: "bookinc") as! Int
//                                            //let bookingchargesg = self.userData.value(forKey: "bookCharges") as! Int
//                                            //                    let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
//                                            let companychargesg = self.userData.value(forKey:"getCompanyPrice") as! Int
//                                            self.reservetodaytxt.text = "Reserve today with £\(getReser)"
//
//                                            let ef = reservationP + bookingchargesg
//                                            //                    let getPercentage = (bookingchargesg * companychargesg ) / 100
//                                            self.userData.set(getReser, forKey: "bookCharges")
//                                            //  self.userData.set(bookingchargesg, forKey: "bookCharges")
//                                            self.userData.set(companychargesg, forKey: "compnyCharges")
//                                            //                    let validto = self.getcarData.value(forKey:"validto") as! String
//                                            //                    let validfrom = self.getcarData.value(forKey:"validfrom") as! String
//                                            //                    let getTime = validfrom.toDateTime1()
//                                            //                    let gettime2 = validto.toDateTime1()
//                                            //                    self.validtill.text = "\(getTime) - \(gettime2)"
//                                        }
//
//                                        self.reservetodaytxt.isHidden = false
//                                        let getFinalPrice = self.userData.value(forKey: "getCompanyPrice") as! Int
//                                        let getds = "\(getFinalPrice)"
//                                        let getEncoded = getds.decodeEmoji
//                                        if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//                                        {
//                                            self.finalPrice.text = "Please call our reservations team to book this vehicle"
//                                            self.reservetodaytxt.text = ""
//                                        }
//                                        else
//                                        {
//                                            self.finalPrice.text = "Final Price: £\(getEncoded)" as! String
//
//                                        }
//
//                                        self.savequotebtn.isHidden = true
//                                    }
//                                    else if(!(self.userData.value(forKey: "upcoming") == nil))
//                                    {
//                                        //                self.validtill.isHidden = false
//                                        //                self.reservetodaytxt.isHidden = true
//                                        //                self.reservetodaytxt.text = ""
//
//                                        //                if(gethotoffersData == "")
//                                        //                {
//                                        //
//                                        //                }
//                                        let geth = self.userData.value(forKey: "gethot") as! Int
//
//                                        if(geth == 1)
//                                        {
//                                            self.validtill.isHidden = false
//                                            self.reservetodaytxt.isHidden = true
//                                            self.reservetodaytxt.text = ""
//                                            let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
//                                            let bookingchargesg = gethotoffersData.value(forKey:"bookingcharges") as! Int
//
//
//                                            let companychargesg = gethotoffersData.value(forKey:"companycharges") as! Int
//                                            //  let getPercentage = (bookingchargesg * companychargesg ) / 100
//                                            let getBo =  self.reservationCharges + bookingchargesg
//                                            self.userData.set(getBo, forKey: "bookCharges")
//                                            // self.userData.set(bookingchargesg, forKey: "bookCharges")
//                                            self.userData.set(companychargesg, forKey: "compnyCharges")
//                                            let validto = gethotoffersData.value(forKey:"validto") as! String
//                                            let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
//                                            let getTime = validfrom.toDateTime1()
//                                            let gettime2 = validto.toDateTime1()
//                                            self.validtill.text = "\(getTime) - \(gettime2)"
//                                            self.lbl1.text = "Full payment payable immediately on booking with 1SR"
//                                            self.lbl2.text = " Offer only valid for the dates listed above"
//                                            self.userData.set(companychargesg, forKey: "bookCharges")
//                                            //  self.validtill.text = "434343"
//
//                                        }
//                                        else
//                                        {
//                                            self.validtill.isHidden = true
//                                            self.lbl1.text = "Reservation fee will deducted from Final price."
//                                            self.lbl2.text = "Remainder of balance payable on the day of rental."
//                                            //       let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
//                                            let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
//                                            let companychargesg = self.getcarData.value(forKey:"company_charges") as! Int
//                                            //   let getPercentage = (bookingchargesg * companychargesg ) / 100
//                                            let getBo =  self.reservationCharges + bookingchargesg
//                                            self.userData.set(getBo, forKey: "bookCharges")
//
//                                            // self.userData.set(bookingchargesg, forKey: "bookCharges")
//                                            self.userData.set(companychargesg, forKey: "compnyCharges")
//
//                                            self.reservetodaytxt.text = "Reserve today with £\(getBo)"
//                                            //                    let validto = self.getcarData.value(forKey:"validto") as! String
//                                            //                    let validfrom = self.getcarData.value(forKey:"validfrom") as! String
//                                            //                    let getTime = validfrom.toDateTime1()
//                                            //                    let gettime2 = validto.toDateTime1()
//                                            //                    self.validtill.text = "\(getTime) - \(gettime2)"
//                                        }
//
//                                        self.reservetodaytxt.isHidden = false
//                                        let getFinalPrice = self.userData.value(forKey: "getCompanyPrice") as! Int
//                                        //  let getEncoded = getFinalPrice.decodeEmoji
//                                        if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//                                        {
//                                            self.finalPrice.text = "Please call our reservations team to book this vehicle"
//                                            self.reservetodaytxt.text = ""
//                                        }
//                                        else
//                                        {
//                                            self.finalPrice.text = "Final Price: £\(getFinalPrice)"
//
//                                        }
//
//
//
//                                        self.savequotebtn.isHidden = true
//                                        self.bookCarBtn.isUserInteractionEnabled = false
//                                        self.toggleBtn.isHidden = true
//                                        self.acceptTxt.isHidden = true
//                                        self.bookCarBtn.setTitle("Booked", for: .normal)
//                                    }
//                                    else
//                                    {
//                                        self.savequotebtn.isHidden = false
//                                        self.validtill.isHidden = true
//                                        var date = firstDate! // first date
//                                        let endDate = secondDate! // last date
//                                        print(date)
//                                        print(endDate)
//                                        // Formatter for printing the date, adjust it according to your needs:
//                                        let fmt = DateFormatter()
//                                        fmt.dateFormat = "yyyy/MM/dd"
//
//                                        while date <= endDate {
//                                            print(fmt.string(from: date))
//                                            date = self.self.calendar.date(byAdding: .day, value: 1, to: date)!
//                                            self.getDatesArr.add(fmt.string(from: date))
//                                            print(date)
//                                        }
//                                        for i in 0..<self.getDatesArr.count
//                                        {
//                                            let ftDate = dateFmt.date(from: self.self.getDatesArr[i] as! String)
//                                            let weekday = Calendar.current.component(.weekday, from: ftDate as! Date)
//
//                                            print(weekday)
//
//                                            let string = self.getDatesArr[i]
//
//                                            let dateFormatter = DateFormatter()
//                                            let tempLocale = dateFormatter.locale // save locale temporarily
//                                            //     dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                                            dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//
//                                            dateFormatter.dateFormat = "yyyy/MM/dd"
//                                            let date = dateFormatter.date(from: string as! String)!
//                                            dateFormatter.dateFormat = "EEE"
//                                            dateFormatter.locale = tempLocale // reset the locale
//                                            let dateString = dateFormatter.string(from: date)
//                                            print("EXACT_DATE : \(dateString)")
//                                            self.getDays2.add(dateString)
//                                        }
//                                        print(self.getDatesArr)
//                                        print("getDays.count",self.getDays2.count)
//                                        var monInt = Int()
//                                        var tueInt = Int()
//                                        var wedInt = Int()
//                                        var thuInt = Int()
//                                        var friInt = Int()
//                                        var satInt = Int()
//                                        var sunInt = Int()
//                                        let getDaysString:String = self.getDays2.componentsJoined(by: ",")
//
//                                        self.getValuesArr2.add(self.getcarData.value(forKey:"booking_charges")  as! Int)
//                                        // self.userData.set(self.getcarData.value(forKey:"booking_charges"), forKey: "bookCharges")
//                                        let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
//
//                                        let companychargesg = self.getcarData.value(forKey:"company_charges") as! Int
//
//
//                                        self.userData.set(self.getcarData.value(forKey:"company_charges"), forKey: "compnyCharges")
//
//
//                                        print("klkl",self.getValuesArr2)
//                                        var getArray = NSArray()
//                                        getArray = self.getValuesArr2.mutableCopy() as! NSArray
//                                        var getStost = self.userData.value(forKey: "getStrCell") as! String
//
//                                        let getA = getStost.replacingOccurrences(of: "£", with: "") as! String
//                                        let getB = Int(getA)
//
//                                        self.totalget = getB!
//                                        //        for element in getArray {
//                                        //            print("\(element) ")
//                                        //            total += element as! Int
//                                        //        }
//                                        //
//                                        print(" =  \(self.totalget)")
//                                        let getT = self.userData.value(forKey: "getStrCellBook")
//                                        //   let getT = self.getcarData.value(forKey:"booking_charges") as! Int
//                                        let strReservation = self.userData.value(forKey: "strReservation") as! Int
//
//                                        let getTotalBookP = getT as! String
//                                        let book:Int? = Int(getTotalBookP)
//
//                                        //                let chargescom = total! - getT
//                                        //            print(" = rererer \(chargescom)")
//                                        //             self.userData.set(chargescom, forKey: "compnyCharges")
//                                        // self.finalPrice.text = "Final Price: £\(total! + getTotalBookP)"
//                                        if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//                                        {
//                                            self.finalPrice.text = "Please call our reservations team to book this vehicle"
//                                            self.reservetodaytxt.text = ""
//                                        }
//                                        else
//                                        {
//                                            self.finalPrice.text = "Final Price: £\(self.totalget)"
//                                            self.reservetodaytxt.text = "Reserve today with £\(strReservation + book!) "
//
//                                        }
//
//
//                                        let reser = strReservation + book!
//                                        self.userData.set(reser, forKey: "bookCharges")
//
//                                    }
//
//
//                                }
                                
                                //self.userData.set(self.finalPrice.text!, forKey: "finalPRiceTxt")
                                
                                
                                //        cell.moneyCar.text = "£\(total)"
                                
                                // cell.moneyCar.text = "£\(total)"
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
                        
                        
                        
                        
                    }
                    else{
                        
                        print(receivedData)
                        
                        
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            IJProgressView.shared.hideProgressView()
                            
                            self.getDetails()
                            
                            
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

   
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            
            
            tableView.backgroundView = nil

            return sectionNames.count
            
        }
        else {
            
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)!
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = self.sectionItems[section] as! NSArray
            return arrayOfItems.count;
        } else {
            return 0;
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.sectionNames.count != 0) {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    //
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        //  header.contentView.backgroundColor = UIColor.colorWithHexString(hexStr: "#408000")
        header.textLabel?.textColor = UIColor.black
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
        theImageView.image = UIImage(named: "drop-down-arrow.png")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        let getH = getHeight + 20
    //        return CGFloat(getHeight)
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! tableCell
        let section = self.sectionItems[indexPath.section] as! NSArray
        
       cell.txt.frame.size.height = 0
        cell.txt.textColor = UIColor.black
        cell.label.text = section[indexPath.row] as? String
        cell.label.numberOfLines = 0
        
        //
        //                lab.attributedText = attributedString
        //                let st = lab.attributedText
        //                cell.txt.attributedText = attributedString
        //        let str = section[indexPath.row] as! NSString
        //        var attributedString = NSMutableAttributedString(string: section[indexPath.row] as! String)
        //        var s = attributedString.string
        
        
        
        print(indexPath.row)
        headerSection = indexPath.row
        cell.txt.delegate = self
        cell.txt.isEditable = false
        cell.txt.center.y = cell.center.y
//        if(expandedSectionHeaderNumber == 3)
//        {
//
//            cell.txt.isUserInteractionEnabled = true
//
//            let linkAttributes = [
//                NSLinkAttributeName: NSURL(string: "")!,
//                NSForegroundColorAttributeName: UIColor.blue
//                ] as [String : Any]
//
//            let linkAttributes2 = [
//                NSLinkAttributeName: NSURL(string: "")!,
//                NSForegroundColorAttributeName: UIColor.blue
//                ] as [String : Any]
//
//            let attributedString = NSMutableAttributedString(string: "Have a special request, need to make multiple bookings or even add an additional driver?\n\nThen Please call our friendly team on: 01204777200\n\nOur call centre is open:Monday to sunday 9am-10pm\n\nOut of hours please email:1stoprentals@mail.com\n\nWe can assist you with any queries you may have.\n\n*Most FAQ answers are usually covered in the terms and conditions section.")
//
//            // Set the 'click here' substring to be the link
//
//            attributedString.setAttributes(linkAttributes, range: NSMakeRange(129, 11))
//
//            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: 1.0, range: NSRange.init(location: 129, length: 11))
//
//            attributedString.setAttributes(linkAttributes2, range: NSMakeRange(219, 23))
//
//            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: 1.0, range: NSRange.init(location: 220, length: 22))
//
//            let lab = UILabel()
//
//            lab.attributedText = attributedString
//
//            let st = lab.attributedText
//            cell.label.attributedText = attributedString
//            cell.txt.attributedText = attributedString
//            cell.txt.font = UIFont.systemFont(ofSize: 15)
//            cell.label.font = UIFont.systemFont(ofSize: 15)
//            cell.txt.frame.size.height = cell.label.optimalHeight + 30
//            tableView.rowHeight = cell.txt.frame.size.height + 10
//            cell.txt.frame.origin.y = 5
//            print(expandedSectionHeaderNumber)
//        }
        
//        else
//        {
            cell.txt.frame.size.height = 0
            cell.txt.frame.origin.y = 5
            cell.label.text = section[indexPath.row] as? String
            cell.txt.text = section[indexPath.row] as? String
            cell.txt.font = UIFont.systemFont(ofSize: 15)
            cell.label.font = UIFont.systemFont(ofSize: 15)
//        cell.label.frame.origin.y = 0
//         cell.txt.frame.origin.y = 0
//            if(cell.label.optimalHeight < 40)
//            {
//                cell.txt.frame.size.height = 60
//            }
//            else
//            {
                cell.txt.frame.size.height = cell.label.optimalHeight + 30
         //   }
            //            cell.viewLine.isHidden = false
            tableView.rowHeight = cell.txt.frame.size.height + 10
        
            print(expandedSectionHeaderNumber)
        
        
   //     }
        //        cell.viewLine.isHidden = false
        //          cell.viewLine.frame.origin.y =  cell.txt.frame.size.height + cell.txt.frame.origin.y + 4
        
        
        return cell
    }
    
    //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 0.00001
    //    }
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Expand / Collapse Methods
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    //      //  let cell = tableView.cellForRow(at: indexPath) as! tableCell
    // // let betFrame = cell.label.optimalHeight + 50 + 10
    //        return 200
    //    }
    func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        
        
        //tableView.rowHeight = (cell?.label.optimalHeight)! + 50 + 10
        
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        tableView.frame.size.height = 210
        lastView.frame.origin.y = tableView.frame.size.height + tableView.frame.origin.y + 10
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.lastView.frame.origin.y + self.lastView.frame.size.height + 20)
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        
        let getData = sectionData[0] as! String
        print(getData)
        
        let getHeights = UILabel()
        getHeights.numberOfLines = 0
        getHeights.text = getData
        let getTotalHeight = getHeights.optimalHeight
        tableView.frame.size.height = getTotalHeight + 250 + 10
        
        lastView.frame.origin.y = tableView.frame.size.height + tableView.frame.origin.y + 10
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.lastView.frame.origin.y + self.lastView.frame.size.height + 20)
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            
            
            for i in 0 ..< sectionData.count {
                
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
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
