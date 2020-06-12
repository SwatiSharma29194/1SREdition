             //
//  cardetailss.swift
//  Carz4Hire
//
//  Created by rv-apple on 15/03/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import MessageUI
class cardetailss: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,MFMailComposeViewControllerDelegate {

    @IBOutlet var nameCar: UILabel!
    @IBOutlet var tableView: UITableView!
     var getcarsArr = NSArray()
    var getHot = String()
    var getBook = Double()
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var companyLogo: UIImageView!
    @IBOutlet var bookCarBtn: UIButton!
    @IBOutlet var lbl1: UILabel!
    
    @IBOutlet var lbl2: UILabel!
    
    var getDays2 = NSMutableArray()
    var getValuesArr2 = NSMutableArray()
     let calendar = NSCalendar.current
    var connection = webservices()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    var totalget = Double()
    @IBOutlet var acceptTxt: UnderlinedLabel!
    @IBOutlet var reservetodaytxt: UILabel!
    
    @IBOutlet var savequotebtn: UIButton!
    var getcarData = NSDictionary()
       let kHeaderSectionTag: Int = 6900;
        var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    var getIDCar = Int()
    var userData = UserDefaults()
    var cell =  WheelCell()
    var toggleBtns = false
    
    @IBOutlet var validtill: UILabel!
    var getDatesArr = NSMutableArray()
    var getDataDictGWt1 = NSDictionary()
    @IBOutlet var pagecontroller: UIPageControl!
    @IBOutlet var finalPrice: UILabel!
    var headerSection = Int()
    @IBOutlet var lastView: UIView!
    @IBOutlet var toggleBtn: UIButton!
    @IBOutlet var addressSupplier: UILabel!
    @IBOutlet var supplier_name: UILabel!
    @IBOutlet var img4: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var carscrollview: UIScrollView!
    @IBOutlet var scrollview: UIScrollView!
    var tapgesture = UITapGestureRecognizer()
   var arraySpeed = NSMutableArray()
   var getHeight = Float()
    var getBArr = NSMutableArray()
   var reservationCharges = Double()
    
    @IBOutlet var view1: UIView!
    @IBOutlet var mainView: UIView!
    var imageCell = ["Top speed.png","0-60 mph.png","Transmission.png","year.png"]
        var titleArr  = ["Top speed","0-60 MPH","Transmission","Year"]
    var getCurrencyRate = ""
    var currencyName = ""
       override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getCurrencyRate = self.userData.value(forKey: "getCurrencyRate") as! String
        
        currencyName = self.userData.value(forKey: "saveCurrency") as! String
        
        scrollview.frame.origin.y = view1.frame.size.height
        
        let imaged = UIImage(named: "blank-square.png")
        
        toggleBtn.setImage(imaged, for: .normal)
        
        acceptTxt.text = "I accept the terms and conditions"
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        
        layout.itemSize = CGSize(width: collectionView.frame.size.width/4 - 1, height:  75)
        
        layout.minimumInteritemSpacing = 0
        
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
       tableView.isScrollEnabled = false
        
        self.sectionNames = [ "Mileage/Kilometer", "Excess protection insurance", "Deposit at Counter","Any questions? Need to speak to us?" ];
        savequotebtn.layer.cornerRadius = self.savequotebtn.frame.size.height / 2
        
        savequotebtn.clipsToBounds = true
        
        bookCarBtn.layer.cornerRadius = self.bookCarBtn.frame.size.height / 2
        
        bookCarBtn.clipsToBounds = true
        
        self.tableView!.tableFooterView = UIView()
      
        getIDCar = userData.value(forKey: "idget") as! Int
       
        scrollview.delegate = self
        
        carsDetails()
        
        scrollview.frame = self.view.frame
        
        self.scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.lastView.frame.origin.y + self.lastView.frame.size.height + 20)
        
        if(!(userData.value(forKey: "getData") == nil))
        {
            
        getDataDictGWt1 =  userData.value(forKey: "getData") as! NSDictionary
            
        }
        

       // self.hudprogress.hide(animated: true)
      //  self.hudprogress.removeFromSuperViewOnHide = true
      //  self.Pagecontrol.numberOfPages = self.HomeImageTopslider.count
     //   self.Pagecontrol.currentPage = 0
        
        
        
    

    }
 
    
    

func configuredMailComposeViewController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
    
    mailComposerVC.setToRecipients(["1stoprentals@mail.com"])
    mailComposerVC.setSubject("1SR")
    mailComposerVC.setMessageBody("1SR", isHTML: false)
    
    return mailComposerVC
}

func showSendMailErrorAlert() {
    let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
    sendMailErrorAlert.show()
}

// MARK: MFMailComposeViewControllerDelegate Method
func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
}
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//
//        controller.dismiss(animated: true, completion: nil)
//    }

    @available(iOS 10.0, *)

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    UIApplication.shared.open(URL, options: [:])
      if(characterRange == NSMakeRange(129, 11))
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
      else{
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        return true
}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleBtnTap(_ sender: Any) {
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
    

    func carsDetails()
    {
        
  
    var param = [NSString: NSObject]()
    
    
    param = ["car_id":getIDCar as NSObject]
    
    print(param)
    //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
    
    print(param)
    
    IJProgressView.shared.showProgressView(view: self.view)
        if(!(userData.value(forKey: "emailSave") == nil))
        {
    connection.startConnectionWithSting2(getUrlString: "getcardetails", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
    
    if (self.connection.responseCode == 1){
    
    print(receivedData)
    
    if(!((receivedData.value(forKey: "message") == nil)))
    {
    if(receivedData.value(forKey: "message") as! String == "success")
    {
    
        IJProgressView.shared.hideProgressView()
    
        self.getcarData = receivedData.value(forKey: "data") as! NSDictionary
        self.reservationCharges = self.getcarData.value(forKey: "reservation_charges") as! Double
        
        let getcar_mileage = self.getcarData.value(forKey: "car_mileage")
        let getcar_excess = self.getcarData.value(forKey: "car_excess")
         let getcounter_deposit = self.getcarData.value(forKey: "counter_deposit")
        let top_speed = self.getcarData.value(forKey: "top_speed") as! String
        let miles = self.getcarData.value(forKey: "miles") as! String
        let transmission = self.getcarData.value(forKey: "transmission") as! String
        let year = self.getcarData.value(forKey: "year") as! String
        
        self.arraySpeed.add(top_speed)
        self.arraySpeed.add(miles)
        self.arraySpeed.add(transmission)
        self.arraySpeed.add(year)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
     let getStr = "Have a special request, need to make multiple bookings or even add an additional driver?\n\nThen Please call our friendly team on:01204777200\n\nOur call centre is open:Monday to sunday 9am-10pm\n\nOut of hours please email: 1stoprentals@mail.com .            "

//
//        let attributedString = NSMutableAttributedString(string: "I agree to the terms of serviceand privacy policyPLEASE NOTE: please translateterms of service and privacy policy as well, and leave the around your translations just as in the English version of this message.")
//        attributedString.addAttribute(nslink, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))

  
        

//        cell.lbl_name.attributedText = aAttrString
      
        self.sectionItems = [ ["\(getcar_mileage!)"],
                         ["\(getcar_excess!)"],
                         ["\(getcounter_deposit!)"],
                         ["\(getStr)"]
        ];
        
             let getsupplier_information = self.getcarData.value(forKey: "supplierinfo") as! NSDictionary
        
        self.supplier_name.text = getsupplier_information.value(forKey: "name") as! String
        
        self.addressSupplier.text = getsupplier_information.value(forKey: "address") as! String
        
        let getcompanyLogo =  self.getcarData.value(forKey:"company_logo")  as! String
        
        let stringAppend = "http://carz4hire.com/companylogo/"
        
        let imageCompany = "\(stringAppend)\(getcompanyLogo)"
        
        let fileUrl = NSURL(string: imageCompany)
        self.companyLogo.setImageWith(fileUrl! as URL)
        let getcarsImges = self.getcarData.value(forKey: "imagesinfo") as! NSArray
        
        for x in 0..<getcarsImges.count
        {
            let imageviewdata = UIImageView()
            imageviewdata.frame = CGRect(x: CGFloat(self.carscrollview.frame.size.width * CGFloat(x)), y: 0, width: self.carscrollview.frame.size.width, height: self.carscrollview.frame.size.height)
            imageviewdata.contentMode = .scaleAspectFit;
            
            if(x == 0)
            {
                let getindex = getcarsImges.object(at: 0)
                let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                let stringAppend2 = "http://carz4hire.com/carimages/"
                
                let imagecar = "\(stringAppend2)\(getcarLogo)"
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
                imageviewdata.setImageWith(fileUrl1! as URL)
            }
                
                
            else if(x == 1)
            {
                let getindex = getcarsImges.object(at: 1)
                let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                let stringAppend2 = "http://carz4hire.com/carimages/"
                
                let imagecar = "\(stringAppend2)\(getcarLogo)"
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
                imageviewdata.setImageWith(fileUrl1! as URL)
            }
                
            else if(x == 2)
            {
                let getindex = getcarsImges.object(at: 2)
                let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                let stringAppend2 = "http://carz4hire.com/carimages/"
                
                let imagecar = "\(stringAppend2)\(getcarLogo)"
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
                imageviewdata.setImageWith(fileUrl1! as URL)
            }
                
            else if(x == 3)
            {
                let getindex = getcarsImges.object(at: 3)
                let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                let stringAppend2 = "http://carz4hire.com/carimages/"
                
                let imagecar = "\(stringAppend2)\(getcarLogo)"
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
                imageviewdata.setImageWith(fileUrl1! as URL)
            }
            
            imageviewdata.contentMode = .scaleAspectFill
            imageviewdata.clipsToBounds = true
            self.carscrollview.addSubview(imageviewdata)
            self.carscrollview.isPagingEnabled = true
            
            
        }
        self.carscrollview.contentSize = CGSize(width: self.carscrollview.frame.size.width * CGFloat(getcarsImges.count), height: self.carscrollview.frame.size.height)
     
       let carName = self.getcarData.value(forKey:"cartitle") as! String
        self.nameCar.text = carName
     
        let getcarType = self.getcarData.value(forKey:"car_type") as! String
        if(getcarType == "Chauffeur")
        {
          
            self.lbl1.text = "Quotation will be send to you by email."
            self.lbl2.text = "An agent will call you to take payment."
            
          

              self.finalPrice.isHidden = false
          
            self.bookCarBtn.setTitle("Send Request", for: .normal)
            self.bookCarBtn.addTarget(self, action: #selector(self.sendRequest), for: .touchUpInside)
            
            if(!(self.userData.value(forKey: "getcompanyCost") == nil))
            {
                 self.savequotebtn.isHidden = false
               self.validtill.isHidden = true
                self.reservetodaytxt.isHidden = true
                self.reservetodaytxt.text = ""
//                let getIntd = self.userData.value(forKey: "getcompanyCost") as! Int
//                let getT = self.userData.value(forKey:"bookCharges") as! Int
//                let chargescom = getIntd - getT
//                print(" = rererer \(chargescom)")
                
             //   self.userData.set(chargescom, forKey: "compnyCharges")
            //    let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Double
                let companychargesg = self.getcarData.value(forKey:"company_charges") as! Double
                
                let getBo =  ((self.reservationCharges + bookingchargesg) * Double(Float(self.getCurrencyRate)!))
                
                self.userData.set(getBo, forKey: "bookCharges")
                
                
//                let getPercentage = (bookingchargesg * companychargesg ) / 100
               
          
//                let validto = gethotoffersData.value(forKey:"validto") as! String
//                let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
//                let getTime = validfrom.toDateTime1()
//                let gettime2 = validto.toDateTime1()
               // self.validtill.text = "\(getTime) - \(gettime2)"
            }
               
         
                   else if(!(self.userData.value(forKey: "saveQuotes") == nil))
            {
                self.savequotebtn.isHidden = true
            }
            
                        else if(!(self.userData.value(forKey: "upcoming") == nil))
            {
                self.savequotebtn.isHidden = true
        }
                else
            {
                
                let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Double
                let companychargesg = self.getcarData.value(forKey:"company_charges") as! Double * Double(Float(self.getCurrencyRate)!)
               
               // let getPercentage = (bookingchargesg * companychargesg ) / 100
              
                let getBo =  self.reservationCharges + bookingchargesg * Double(Float(self.getCurrencyRate)!)
                
                self.userData.set(getBo, forKey: "bookCharges")
                
                self.userData.set(companychargesg, forKey: "compnyCharges")
                 self.savequotebtn.isHidden = false
            }
//            if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
//            {
//                self.finalPrice.text = "Please call our reservations team to book this vehicle"
//                self.reservetodaytxt.text = ""
//            }
//            else
//            {
                self.finalPrice.text = "From \(self.currencyName)\(Double(Float(self.getCurrencyRate)!) * 99)"
            //}
        }
        else
        {
            var dateStr = self.getDataDictGWt1.value(forKey: "fromDate1")
            
            var dateStr2 = self.getDataDictGWt1.value(forKey: "fromDate2")
            print(dateStr2)
            print(dateStr)
            // Set date format
            var dateFmt = DateFormatter()
            
            dateFmt.timeZone = NSTimeZone.default
            
            dateFmt.dateFormat =  "yyyy/MM/dd"
            var dateFmt2 = DateFormatter()
            dateFmt2.timeZone = NSTimeZone.default
            //dateFmt.timeZone = NSTimeZone.default
            dateFmt2.dateFormat =  "yyyy/MM/dd"
            // Get NSDate for the given string
            var firstDate = dateFmt.date(from: dateStr as! String)
            var secondDate = dateFmt.date(from: dateStr2 as! String)
            
            print(firstDate!)
            if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
            {
                self.bookCarBtn.setTitle("Call Now", for: .normal)
                
                self.bookCarBtn.addTarget(self, action: #selector(self.callBtnTap), for: .touchUpInside)
            }
            else
            
            {
                self.bookCarBtn.setTitle("Book this car", for: .normal)
//                self.lbl1.text = "Full payment payable immediately on booking with 1SR"
//                self.lbl2.text = " Offer only valid for the dates listed above"
                self.bookCarBtn.addTarget(self, action: #selector(self.bookCars), for: .touchUpInside)
            }

            self.finalPrice.isHidden = false
            self.toggleBtn.isHidden = false
            self.acceptTxt.isHidden = false

            self.reservetodaytxt.isHidden = false
           // self.reservetodaytxt.text = "Reserve today with £20,4443"
     
            if(!(self.userData.value(forKey: "getcompanyCost") == nil))
            {
               
                self.validtill.isHidden = false
                self.reservetodaytxt.isHidden = true
                  self.reservetodaytxt.text = ""
                let getIntd = self.userData.value(forKey: "getcompanyCost") as! Double
                let getT = self.userData.value(forKey:"bookCharges") as! Double
                
                let chargescom = getIntd - getT
                print(" = rererer \(chargescom)")
                self.userData.set(chargescom, forKey: "compnyCharges")
         let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                   //  let bookingchargesg = self.getBook
                      let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Double  * Double(Float(self.getCurrencyRate)!)
                 let companychargesg = gethotoffersData.value(forKey:"companycharges") as! Double  * Double(Float(self.getCurrencyRate)!)
          
            
                
               // let getPercentage = self.getBook
             
                let getBo =  self.reservationCharges + bookingchargesg
                
                self.userData.set(companychargesg, forKey: "bookCharges")
                     // self.userData.set(getPercentage, forKey: "bookCharges")
                //self.userData.set(bookingchargesg, forKey: "bookCharges")
                self.userData.set(companychargesg, forKey: "compnyCharges")
                let validto = gethotoffersData.value(forKey:"validto") as! String
                   let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
                let getTime = validfrom.toDateTime1()
                let gettime2 = validto.toDateTime1()
                self.validtill.text = "\(getTime) - \(gettime2)"
               //  self.validtill.text = "434343"
                            if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                            {
                                self.finalPrice.text = "Please call our reservations team to book this vehicle"
                                self.reservetodaytxt.text = ""
                                self.lbl1.text = ""
                                self.lbl2.text = ""
                              
                        
                             
                            }
                            else
                            {
                                self.finalPrice.text = "Final Price: \(self.currencyName)\(companychargesg)"
                                
                                self.lbl1.text = "Full payment payable immediately on booking with 1SR"
                                   self.lbl2.text = " Offer only valid for the dates listed above"
                             
                }
  
             
                self.reservetodaytxt.isHidden = false
                self.savequotebtn.isHidden = true
                
               // self.reservetodaytxt.text = "Reserve today with £\(getT)"
            }
                
                else if(!(self.userData.value(forKey: "saveQuotes") == nil))
            {
//                self.validtill.isHidden = false
//                self.reservetodaytxt.isHidden = true
//                self.reservetodaytxt.text = ""

//                if(gethotoffersData == "")
//                {
//
//                }
                let geth = self.userData.value(forKey: "gethot") as! Int
                
                if(geth == 1)
                {
                    self.validtill.isHidden = false
                    self.reservetodaytxt.isHidden = true
                    self.reservetodaytxt.text = ""
                let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                let bookingchargesg = gethotoffersData.value(forKey:"bookingcharges") as! Double   * Double(Float(self.getCurrencyRate)!)
                let companychargesg = gethotoffersData.value(forKey:"companycharges") as! Double  * Double(Float(self.getCurrencyRate)!)
//                    let getPercentage = (bookingchargesg * companychargesg ) / 100
                    self.userData.set(bookingchargesg, forKey: "bookCharges")
               // self.userData.set(bookingchargesg, forKey: "bookCharges")
                self.userData.set(companychargesg, forKey: "compnyCharges")
                let validto = gethotoffersData.value(forKey:"validto") as! String
                let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
                let getTime = validfrom.toDateTime1()
                let gettime2 = validto.toDateTime1()
                self.validtill.text = "\(getTime) - \(gettime2)"
                    if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                    {
                        self.lbl2.text = ""
                        self.lbl1.text = ""
                    }
                    else
                    {
                    self.lbl1.text = "Full payment payable immediately on booking with 1SR"
                    self.lbl2.text = " Offer only valid for the dates listed above"
                    }
                //  self.validtill.text = "434343"
              
                }
                else
                {
                      self.validtill.isHidden = true
                  
             //       let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                    let bookingchargesg = self.getBook
                    let reservationP = self.userData.value(forKey: "strReservation") as! Double
                    let getReser = self.userData.value(forKey: "bookinc") as! Double
                     let getReser2 = self.userData.value(forKey: "bookinc") as! Double * Double(Float(self.getCurrencyRate)!)
                    //let bookingchargesg = self.userData.value(forKey: "bookCharges") as! Int
//                    let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Int
                    let companychargesg = self.userData.value(forKey:"getCompanyPrice") as! Double
                    self.reservetodaytxt.text = "Reserve today with \(self.currencyName)\(getReser2)"
                    
                    let ef = reservationP + bookingchargesg
//                    let getPercentage = (bookingchargesg * companychargesg ) / 100
                    self.userData.set(getReser, forKey: "bookCharges")
                  //  self.userData.set(bookingchargesg, forKey: "bookCharges")
                    self.userData.set(companychargesg, forKey: "compnyCharges")
//                    let validto = self.getcarData.value(forKey:"validto") as! String
//                    let validfrom = self.getcarData.value(forKey:"validfrom") as! String
//                    let getTime = validfrom.toDateTime1()
//                    let gettime2 = validto.toDateTime1()
//                    self.validtill.text = "\(getTime) - \(gettime2)"
                }
            
           self.reservetodaytxt.isHidden = false
                let getFinalPrice = self.userData.value(forKey: "getCompanyPrice") as! Double
                let getds = "\(getFinalPrice)"
                let getEncoded = getds.decodeEmoji
                let getTo = getFinalPrice * Double(Float(self.getCurrencyRate)!)
                if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                {
                    self.finalPrice.text = "Please call our reservations team to book this vehicle"
                    self.reservetodaytxt.text = ""
                    self.lbl1.text = ""
                    self.lbl2.text = ""
                }
                else
                {
                    self.finalPrice.text = "Final Price: \(self.currencyName)\(getTo)" as! String
                    self.lbl1.text = "Reservation fee will deducted from Final price."
                    self.lbl2.text = "Remainder of balance payable on the day of rental."
                    
                }
             
                self.savequotebtn.isHidden = true
            }
            else if(!(self.userData.value(forKey: "upcoming") == nil))
            {
                //                self.validtill.isHidden = false
                //                self.reservetodaytxt.isHidden = true
                //                self.reservetodaytxt.text = ""
                
                //                if(gethotoffersData == "")
                //                {
                //
                //                }
                let geth = self.userData.value(forKey: "gethot") as! Int
                
                if(geth == 1)
                {
                    self.validtill.isHidden = false
                    self.reservetodaytxt.isHidden = true
                    self.reservetodaytxt.text = ""
                    let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                    let bookingchargesg = gethotoffersData.value(forKey:"bookingcharges") as! Double * Double(Float(self.getCurrencyRate)!)
                  
                    
                    let companychargesg = gethotoffersData.value(forKey:"companycharges") as! Double * Double(Float(self.getCurrencyRate)!)
                  //  let getPercentage = (bookingchargesg * companychargesg ) / 100
                    let getBo =  self.reservationCharges + bookingchargesg
                    self.userData.set(getBo, forKey: "bookCharges")
                   // self.userData.set(bookingchargesg, forKey: "bookCharges")
                    self.userData.set(companychargesg, forKey: "compnyCharges")
                    let validto = gethotoffersData.value(forKey:"validto") as! String
                    let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
                    let getTime = validfrom.toDateTime1()
                    let gettime2 = validto.toDateTime1()
                    self.validtill.text = "\(getTime) - \(gettime2)"
                    if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                    {
                        self.lbl2.text = ""
                        self.lbl1.text = ""
                    }
                    else
                    {
                    
                    self.lbl1.text = "Full payment payable immediately on booking with 1SR"
                    self.lbl2.text = " Offer only valid for the dates listed above"
                    }
                     self.userData.set(companychargesg, forKey: "bookCharges")
                    //  self.validtill.text = "434343"
                    
                }
                else
                {
                    self.validtill.isHidden = true
                    if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                    {
                        self.lbl2.text = ""
                        self.lbl1.text = ""
                    }
                    else
                    {
                    self.lbl1.text = "Reservation fee will deducted from Final price."
                    self.lbl2.text = "Remainder of balance payable on the day of rental."
                    }
                    //       let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                    let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Double * Double(Float(self.getCurrencyRate)!)
                    let companychargesg = self.getcarData.value(forKey:"company_charges") as! Double * Double(Float(self.getCurrencyRate)!)
                 //   let getPercentage = (bookingchargesg * companychargesg ) / 100
                    let getBo =  self.reservationCharges + bookingchargesg
                    self.userData.set(getBo, forKey: "bookCharges")
                    
                   // self.userData.set(bookingchargesg, forKey: "bookCharges")
                    self.userData.set(companychargesg, forKey: "compnyCharges")
                    
                    self.reservetodaytxt.text = "Reserve today with \(self.currencyName)\(getBo)"
                    //                    let validto = self.getcarData.value(forKey:"validto") as! String
                    //                    let validfrom = self.getcarData.value(forKey:"validfrom") as! String
                    //                    let getTime = validfrom.toDateTime1()
                    //                    let gettime2 = validto.toDateTime1()
                    //                    self.validtill.text = "\(getTime) - \(gettime2)"
                }
                
                self.reservetodaytxt.isHidden = false
                let getFinalPrice = self.userData.value(forKey: "getCompanyPrice") as! Double
              //  let getEncoded = getFinalPrice.decodeEmoji
                if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                {
                    self.finalPrice.text = "Please call our reservations team to book this vehicle"
                    self.reservetodaytxt.text = ""
                }
                else
                {
                    self.finalPrice.text = "Final Price: \(self.currencyName)\(getFinalPrice)"
                    
                }
                
                
                
                self.savequotebtn.isHidden = true
                self.bookCarBtn.isUserInteractionEnabled = false
                self.toggleBtn.isHidden = true
                 self.acceptTxt.isHidden = true
                self.bookCarBtn.setTitle("Booked", for: .normal)
            }
            else
            {
                self.savequotebtn.isHidden = false
                 self.validtill.isHidden = true
        var date = firstDate! // first date
        let endDate = secondDate! // last date
        print(date)
        print(endDate)
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy/MM/dd"
        
        while date <= endDate {
            print(fmt.string(from: date))
            date = self.self.calendar.date(byAdding: .day, value: 1, to: date)!
            self.getDatesArr.add(fmt.string(from: date))
            print(date)
        }
        for i in 0..<self.getDatesArr.count
        {
            let ftDate = dateFmt.date(from: self.self.getDatesArr[i] as! String)
            let weekday = Calendar.current.component(.weekday, from: ftDate as! Date)
            
            print(weekday)
            
            let string = self.getDatesArr[i]
            
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale // save locale temporarily
       //     dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
          
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = dateFormatter.date(from: string as! String)!
            dateFormatter.dateFormat = "EEE"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            self.getDays2.add(dateString)
        }
        print(self.getDatesArr)
        print("getDays.count",self.getDays2.count)
        var monInt = Int()
        var tueInt = Int()
        var wedInt = Int()
        var thuInt = Int()
        var friInt = Int()
        var satInt = Int()
        var sunInt = Int()
        let getDaysString:String = self.getDays2.componentsJoined(by: ",")
                if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                {
                    self.finalPrice.text = "Please call our reservations team to book this vehicle"
                    self.reservetodaytxt.text = ""
         self.savequotebtn.isHidden = true
                    
                }
                else
                {
                    self.lbl1.text = "Reservation fee will deducted from Final price."
                    self.lbl2.text = "Remainder of balance payable on the day of rental."
                       self.savequotebtn.isHidden = false
                self.getValuesArr2.add(self.getcarData.value(forKey:"booking_charges")  as! Double)
           // self.userData.set(self.getcarData.value(forKey:"booking_charges"), forKey: "bookCharges")
                let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Double * Double(Float(self.getCurrencyRate)!)
                
                let companychargesg = self.getcarData.value(forKey:"company_charges") as! Double  * Double(Float(self.getCurrencyRate)!)
                
              
                 self.userData.set(self.getcarData.value(forKey:"company_charges"), forKey: "compnyCharges")
                
                
        print("klkl",self.getValuesArr2)
        var getArray = NSArray()
        getArray = self.getValuesArr2.mutableCopy() as! NSArray
                var getStost = self.userData.value(forKey: "getStrCell") as! String
                
                    let getA = getStost.replacingOccurrences(of: "\(self.currencyName)", with: "") as! String
                    
                    
                let getB = Double(getA)
                
                self.totalget = getB!
//        for element in getArray {
//            print("\(element) ")
//            total += element as! Int
//        }
//
                print(" =  \(self.totalget)")
        let getT = self.userData.value(forKey: "getStrCellBook")
         //   let getT = self.getcarData.value(forKey:"booking_charges") as! Int
                     let strReservation = self.userData.value(forKey: "strReservation") as! Double
                
                let getTotalBookP = getT as! String
                let book:Double? = Double(getTotalBookP)
                
//                let chargescom = total! - getT
//            print(" = rererer \(chargescom)")
//             self.userData.set(chargescom, forKey: "compnyCharges")
               // self.finalPrice.text = "Final Price: £\(total! + getTotalBookP)"
 
            
                
                let reser = strReservation + book!
              self.userData.set(reser, forKey: "bookCharges")
                    self.finalPrice.text = "Final Price: \(self.currencyName)\(self.totalget)"
                    self.reservetodaytxt.text = "Reserve today with \(self.currencyName)\(strReservation + book!) "
                    
                }
                
        }
            
        
        }
        
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
    
    self.carsDetails()
    
    
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
            connection.startConnectionWithSting(getUrlString: "getcardetails", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            
                            IJProgressView.shared.hideProgressView()
                            
                            self.getcarData = receivedData.value(forKey: "data") as! NSDictionary
                            let getcar_mileage = self.getcarData.value(forKey: "car_mileage")
                            let getcar_excess = self.getcarData.value(forKey: "car_excess")
                            let getcounter_deposit = self.getcarData.value(forKey: "counter_deposit")
                            let top_speed = self.getcarData.value(forKey: "top_speed") as! String
                            let miles = self.getcarData.value(forKey: "miles") as! String
                            let transmission = self.getcarData.value(forKey: "transmission") as! String
                            let year = self.getcarData.value(forKey: "year") as! String
                            
                            self.arraySpeed.add(top_speed)
                            self.arraySpeed.add(miles)
                            self.arraySpeed.add(transmission)
                            self.arraySpeed.add(year)
                            self.collectionView.delegate = self
                            self.collectionView.dataSource = self
                            self.collectionView.reloadData()
                            
                            self.sectionItems = [ ["\(getcounter_deposit!)"],
                                                  ["\(getcar_excess!)"],
                                                  ["\(getcounter_deposit!)"],
                                                  ["Have a special request, need to make multiple bookings or even add an additional driver?\n\nThen Please call our friendly team on:01204777200 ."]
                            ];
                            
                            let getsupplier_information = self.getcarData.value(forKey: "supplierinfo") as! NSDictionary
                            
                            self.supplier_name.text = getsupplier_information.value(forKey: "name") as! String
                            
                            self.addressSupplier.text = getsupplier_information.value(forKey: "address") as! String
                            
                            let getcompanyLogo =  self.getcarData.value(forKey:"company_logo")  as! String
                            let stringAppend = "http://carz4hire.com/companylogo"
                            
                            let imageCompany = "\(stringAppend)\(getcompanyLogo)"
                            let fileUrl = NSURL(string: imageCompany)
                            self.companyLogo.setImageWith(fileUrl as! URL)
                            let getcarsImges = self.getcarData.value(forKey: "imagesinfo") as! NSArray
                            
                            for x in 0..<getcarsImges.count
                            {
                                let imageviewdata = UIImageView()
                                imageviewdata.frame = CGRect(x: CGFloat(self.carscrollview.frame.size.width * CGFloat(x)), y: 0, width: self.carscrollview.frame.size.width, height: self.carscrollview.frame.size.height)
                                
                                if(x == 0)
                                {
                                    let getindex = getcarsImges.object(at: 0)
                                    let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                    let stringAppend2 = "http://carz4hire.com/carimages/"
                                    
                                    let imagecar = "\(stringAppend2)\(getcarLogo)"
                                    let fileUrl1 = NSURL(string: imagecar)
                                    print("fileUrl1",fileUrl1)
                                    imageviewdata.setImageWith(fileUrl1! as URL)
                                }
                                    
                                    
                                else if(x == 1)
                                {
                                    let getindex = getcarsImges.object(at: 1)
                                    let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                    let stringAppend2 = "http://carz4hire.com/carimages/"
                                    
                                    let imagecar = "\(stringAppend2)\(getcarLogo)"
                                    let fileUrl1 = NSURL(string: imagecar)
                                    print("fileUrl1",fileUrl1)
                                    imageviewdata.setImageWith(fileUrl1! as URL)
                                }
                                    
                                else if(x == 2)
                                {
                                    let getindex = getcarsImges.object(at: 2)
                                    let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                    let stringAppend2 = "http://carz4hire.com/carimages/"
                                    
                                    let imagecar = "\(stringAppend2)\(getcarLogo)"
                                    let fileUrl1 = NSURL(string: imagecar)
                                    print("fileUrl1",fileUrl1)
                                    imageviewdata.setImageWith(fileUrl1! as URL)
                                }
                                    
                                else if(x == 3)
                                {
                                    let getindex = getcarsImges.object(at: 3)
                                    let getcarLogo =  (getindex as AnyObject).value(forKey:"image")  as! String
                                    let stringAppend2 = "http://carz4hire.com/carimages/"
                                    
                                    let imagecar = "\(stringAppend2)\(getcarLogo)"
                                    let fileUrl1 = NSURL(string: imagecar)
                                    print("fileUrl1",fileUrl1)
                                    imageviewdata.setImageWith(fileUrl1! as URL)
                                }
                                
                                imageviewdata.contentMode = .scaleAspectFill
                                imageviewdata.clipsToBounds = true
                                self.carscrollview.addSubview(imageviewdata)
                                self.carscrollview.isPagingEnabled = true
                                
                                
                            }
                            self.carscrollview.contentSize = CGSize(width: self.carscrollview.frame.size.width * 4, height: self.carscrollview.frame.size.height)
                            
                            
                            var dateStr = self.getDataDictGWt1.value(forKey: "fromDate1")
                            
                            var dateStr2 = self.getDataDictGWt1.value(forKey: "fromDate2")
                            print(dateStr2)
                            print(dateStr)
                            // Set date format
                            var dateFmt = DateFormatter()
                            
                            dateFmt.timeZone = NSTimeZone.default
                            
                            dateFmt.dateFormat =  "yyyy/MM/dd"
                            var dateFmt2 = DateFormatter()
                            dateFmt2.timeZone = NSTimeZone.default
                            //dateFmt.timeZone = NSTimeZone.default
                            dateFmt2.dateFormat =  "yyyy/MM/dd"
                            // Get NSDate for the given string
                            var firstDate = dateFmt.date(from: dateStr as! String)
                            var secondDate = dateFmt.date(from: dateStr2 as! String)
                            
                            print(firstDate!)
                            
                            
                            let getcarType = self.getcarData.value(forKey:"car_type") as! String
                            if(getcarType == "Chauffeur")
                            {
                                
                                self.lbl1.text = "Quotation will be send to you by email."
                                self.lbl2.text = "An agent will call you to take payment."
                                self.finalPrice.text = "From \(self.currencyName)\(Double(Float(self.getCurrencyRate)!) * 99)"
                                
                                self.finalPrice.isHidden = false
                                
                                self.bookCarBtn.setTitle("Send Request", for: .normal)
                                self.bookCarBtn.addTarget(self, action: #selector(self.sendRequest), for: .touchUpInside)
                                
                                if(!(self.userData.value(forKey: "getcompanyCost") == nil))
                                {
                                    self.validtill.isHidden = true
                                    self.reservetodaytxt.isHidden = true
                                    self.reservetodaytxt.text = ""
                                    let getIntd = self.userData.value(forKey: "getcompanyCost") as! Double
                                    let bookingchargesg = self.userData.value(forKey:"bookCharges") as! Double
                                    let getBo =  self.reservationCharges + bookingchargesg
                                
                                    self.userData.set(getBo, forKey: "bookCharges")
                                    let getT = self.userData.value(forKey:"bookCharges") as! Double
                                    let chargescom = getIntd - getT
                                    print(" = rererer \(chargescom)")
                                    self.userData.set(chargescom, forKey: "compnyCharges")
                                    let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                                    
                                    //                let validto = gethotoffersData.value(forKey:"validto") as! String
                                    //                let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
                                    //                let getTime = validfrom.toDateTime1()
                                    //                let gettime2 = validto.toDateTime1()
                                    // self.validtill.text = "\(getTime) - \(gettime2)"
                                }
                            }
                            else
                            {
                                
                                self.finalPrice.isHidden = false
                                self.lbl1.text = "Reservation fee will deducted from Final price."
                                self.lbl2.text = "Remainder of balance payable on the day of rental."
                                self.reservetodaytxt.isHidden = false
//                                self.reservetodaytxt.text = "Reserve today with £20,4443"
                                
                                if(!(self.userData.value(forKey: "getcompanyCost") == nil))
                                {
                                    self.validtill.isHidden = false
                                    self.reservetodaytxt.isHidden = true
                                    self.reservetodaytxt.text = ""
                                    let getIntd = self.userData.value(forKey: "getcompanyCost") as! Double
                                    let getT = self.userData.value(forKey:"bookCharges") as! Double
                                    
                                    let chargescom = getIntd - getT
                                    print(" = rererer \(chargescom)")
                                    self.userData.set(chargescom, forKey: "compnyCharges")
                                    let gethotoffersData = self.getcarData.value(forKey:"hot_offer") as! NSDictionary
                                    
                                    let validto = gethotoffersData.value(forKey:"validto") as! String
                                    let validfrom = gethotoffersData.value(forKey:"validfrom") as! String
                                    let getTime = validfrom.toDateTime1()
                                    let gettime2 = validto.toDateTime1()
                                    self.validtill.text = "\(getTime) - \(gettime2)"
                                    if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                                    {
                                        self.finalPrice.text = "Please call our reservations team to book this vehicle"
                                        self.reservetodaytxt.text = ""
                                    }
                                    else
                                    {
                                           self.finalPrice.text = "Final Price: \(self.currencyName)\(chargescom)"
                                        
                                    }
                                    //  self.validtill.text = "434343"
                                 
                                }
                                else
                                {
                                    self.validtill.isHidden = true
                                    var date = firstDate! // first date
                                    let endDate = secondDate! // last date
                                    print(date)
                                    print(endDate)
                                    // Formatter for printing the date, adjust it according to your needs:
                                    let fmt = DateFormatter()
                                    fmt.dateFormat = "yyyy/MM/dd"
                                    
                                    while date <= endDate {
                                        print(fmt.string(from: date))
                                        date = self.self.calendar.date(byAdding: .day, value: 1, to: date)!
                                        self.getDatesArr.add(fmt.string(from: date))
                                        print(date)
                                    }
                                    for i in 0..<self.getDatesArr.count
                                    {
                                        let ftDate = dateFmt.date(from: self.self.getDatesArr[i] as! String)
                                        let weekday = Calendar.current.component(.weekday, from: ftDate as! Date)
                                        
                                        print(weekday)
                                        
                                        let string = self.getDatesArr[i]
                                        
                                        let dateFormatter = DateFormatter()
                                        let tempLocale = dateFormatter.locale // save locale temporarily
                                   //     dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
                                       
                                        dateFormatter.dateFormat = "yyyy/MM/dd"
                                        let date = dateFormatter.date(from: string as! String)!
                                        dateFormatter.dateFormat = "EEE"
                                        dateFormatter.locale = tempLocale // reset the locale
                                        let dateString = dateFormatter.string(from: date)
                                        print("EXACT_DATE : \(dateString)")
                                        self.getDays2.add(dateString)
                                    }
                                    print(self.getDatesArr)
                                    print("getDays.count",self.getDays2.count)
                                    var monInt = Int()
                                    var tueInt = Int()
                                    var wedInt = Int()
                                    var thuInt = Int()
                                    var friInt = Int()
                                    var satInt = Int()
                                    var sunInt = Int()
                                    let getDaysString:String = self.getDays2.componentsJoined(by: ",")
                                    
                                    
                                    let bookingchargesg = self.getcarData.value(forKey:"booking_charges") as! Double * Double(Float(self.getCurrencyRate)!)
                                    
                                    let companychargesg = self.getcarData.value(forKey:"company_charges") as! Double * Double(Float(self.getCurrencyRate)!)
                                 //   let getPercentage = (bookingchargesg * companychargesg ) / 100
                                   
                                    let getBo =  self.reservationCharges + bookingchargesg
                                    
                                    self.userData.set(getBo, forKey: "bookCharges")
                                  
                                    
                                    self.getValuesArr2.add(bookingchargesg  as! Double)
                                    //self.userData.set(self.getcarData.value(forKey:"booking_charges"), forKey: "bookCharges")
                                    self.reservetodaytxt.text = "Reserve today with \(self.currencyName)\(bookingchargesg)"
                                    print("klkl",self.getValuesArr2)
                                    var getArray = NSArray()
                                    getArray = self.getValuesArr2.mutableCopy() as! NSArray
                                    var getStost = self.userData.value(forKey: "getStrCell") as! String
                                    let getA = getStost.replacingOccurrences(of: "\(self.currencyName)", with: "") as! String
                                    let getB = Double(getA)
                                    
                                    var total = getB
                                    //        for element in getArray {
                                    //            print("\(element) ")
                                    //            total += element as! Int
                                    //        }
                                    //
                                    print(" =  \(total)")
                                    
                                    let getT = self.getcarData.value(forKey:"booking_charges") as! Double * Double(Float(self.getCurrencyRate)!)
                                    let chargescom = total! - getT
                                    print(" = rererer \(chargescom)")
                                    self.userData.set(chargescom, forKey: "compnyCharges")
                                    
                                    if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                                    {
                                        self.finalPrice.text = "Please call our reservations team to book this vehicle"
                                        self.reservetodaytxt.text = ""
                                    }
                                    else
                                    {
                                        self.finalPrice.text = "Final Price: \(self.currencyName)\(total!)"
                                        
                                    }
                                 
                                }
                                if(self.getcarData.value(forKey:"display_price") as! Int == 1 )
                                {
                                    self.bookCarBtn.setTitle("Call Now", for: .normal)
                                    self.bookCarBtn.addTarget(self, action: #selector(self.callBtnTap), for: .touchUpInside)
                                }
                                else
                                {
                                     self.bookCarBtn.setTitle("Book this car", for: .normal)
                                          self.bookCarBtn.addTarget(self, action: #selector(self.bookCars), for: .touchUpInside)
                                }
                          
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
                    
                    
                    
                    
                }
                else{
                    
                    print(receivedData)
                    
                    
                    let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.carsDetails()
                        
                        
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
    @IBAction func callNowBtnTap(_ sender: Any) {
    }
    func callBtnTap()
    {
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
    func bookCars()
    {
      
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
         
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendDetails") as! sendDetailsViewController
            vc.payment = "payments"
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Login to BOOK the car", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                
                self.navigationController?.pushViewController(vc!, animated: false)
                //                IJProgressView.shared.hideProgressView()
                //
                //                self.saveQuote()
                
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                
                IJProgressView.shared.hideProgressView()
            }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    }
    
    func sendRequest(){
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
            
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendrequest1")
        
        self.navigationController?.pushViewController(vc!, animated: false)
        }
        else
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Login to save the quote", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                
                self.navigationController?.pushViewController(vc!, animated: true)
                //                IJProgressView.shared.hideProgressView()
                //
                //                self.saveQuote()
                
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                
                IJProgressView.shared.hideProgressView()
            }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        getValuesArr2.removeAllObjects()
        self.userData.set(finalPrice.text!, forKey: "FinalPriceToShow")
        self.userData.set(reservetodaytxt.text!, forKey: "ReservePriceToShow")
        
    }
    
    @IBAction func bckBtn(_ sender: Any) {
        
 //  self.navigationController?.popViewController(animated: false)
        if(!(self.userData.value(forKey: "getcompanyCost") == nil))
        {
            
            self.navigationController?.popViewController(animated: true)
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "hot")
//
//            self.navigationController?.pushViewController(vc!, animated: true)
            

        }
      else  if(!(self.userData.value(forKey: "saveQuotes") == nil))
        {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mybookings") as! mybookingsViewController
            vc.getSeg = "seg"
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        else  if(!(self.userData.value(forKey: "upcoming") == nil))
        {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mybookings")
            
            self.navigationController?.pushViewController(vc!, animated: true)
            
            
        }
        else
        {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailcar")
//
//            self.navigationController?.pushViewController(vc!, animated: true)
        navigationController?.popViewController(animated: true)
        }
        
     //   self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @IBAction func saveQuote(_ sender: Any) {
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
        saveQuote()
        }
    }
    @IBAction func bookCar(_ sender: Any) {
        
        // bookShow()
    }
    func saveQuote()
    {
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            
        var param = [NSString: NSObject]()
        getDataDictGWt1 =  userData.value(forKey: "getData") as! NSDictionary


        let dateStr = getDataDictGWt1.value(forKey: "fromDate1")

        let dateStr2 = getDataDictGWt1.value(forKey: "fromDate2")

        let timeStr = getDataDictGWt1.value(forKey: "fromtime1")

        let timeStr2 = getDataDictGWt1.value(forKey: "fromtime1")
            
            let getLocation = getDataDictGWt1.value(forKey: "location") as! String
            
            let encodedString = getLocation.encodeEmoji
             //  let encodedString2 = finalPrice.text!.encodeEmoji
            let getPrice = finalPrice.text!
            let ge:NSArray = getPrice.components(separatedBy: "\(currencyName)") as NSArray
            var getHot = String()
            if(!(userData.value(forKey: "getcompanyCost") == nil))
            {
                getHot = "1"
            }
            else
            {
                getHot = ""
            }
            let ds = ge[1] as! String
            
            let dsew = Double(ds)
            
             let getT = self.userData.value(forKey:"bookCharges") as! Double
            
            let getGe1 = dsew! - getT
  
            let companyC = self.userData.value(forKey:"compnyCharges")
            
            param = ["car_id":getIDCar as NSObject,"from":"\(dateStr!) \(timeStr!)"  as NSObject,"to":"\(dateStr2!) \(timeStr2!)" as NSObject,"location":"\(encodedString!)" as NSObject,"bookingcharges":getT / Double(Float(self.getCurrencyRate)!) as NSObject,"companycharges":totalget / Double(Float(self.getCurrencyRate)!) as! NSObject,"is_offer":getHot as! NSObject]
            
            
                print(param)
            
        //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]

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
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Car added in quote", preferredStyle: .alert)
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
        else
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Login to save the quote", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                
                self.navigationController?.pushViewController(vc!, animated: false)
//                IJProgressView.shared.hideProgressView()
//
//                self.saveQuote()
                
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                
                IJProgressView.shared.hideProgressView()
            }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
     return 4
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "wheel", for: indexPath) as? WheelCell)!
        
        cell.wheels.text = arraySpeed[indexPath.row] as! String
            cell.img.image = UIImage(named: imageCell[indexPath.row])
        cell.titleLbl.text = titleArr[indexPath.row]
        
            return cell
        
        
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
        if(expandedSectionHeaderNumber == 3)
        {
            
            cell.txt.isUserInteractionEnabled = true
        
        let linkAttributes = [
            NSLinkAttributeName: NSURL(string: "")!,
            NSForegroundColorAttributeName: UIColor.blue
            ] as [String : Any]
            
            let linkAttributes2 = [
                NSLinkAttributeName: NSURL(string: "")!,
                NSForegroundColorAttributeName: UIColor.blue
                ] as [String : Any]

        let attributedString = NSMutableAttributedString(string: "Have a special request, need to make multiple bookings or even add an additional driver?\n\nThen Please call our friendly team on: 01204777200\n\nOur call centre is open:Monday to sunday 9am-10pm\n\nOut of hours please email: 1stoprentals@mail.com .            ")
      
        // Set the 'click here' substring to be the link
            
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(129, 11))
      
            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: 1.0, range: NSRange.init(location: 129, length: 11))
            
            attributedString.setAttributes(linkAttributes2, range: NSMakeRange(219, 23))

            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: 1.0, range: NSRange.init(location: 220, length: 22))
          
        let lab = UILabel()

        lab.attributedText = attributedString
            
        let st = lab.attributedText
              cell.label.attributedText = attributedString
        cell.txt.attributedText = attributedString
            cell.txt.font = UIFont.systemFont(ofSize: 15)
            cell.label.font = UIFont.systemFont(ofSize: 15)
            cell.txt.frame.size.height = cell.label.optimalHeight + 30
        tableView.rowHeight = cell.txt.frame.size.height + 10
                 cell.txt.frame.origin.y = 5
            print(expandedSectionHeaderNumber)
        }
        
        else
        {
            cell.txt.frame.size.height = 0
            cell.txt.frame.origin.y = 5
             cell.label.text = section[indexPath.row] as? String
            cell.txt.text = section[indexPath.row] as? String
            cell.txt.font = UIFont.systemFont(ofSize: 15)
            cell.label.font = UIFont.systemFont(ofSize: 15)
//            if(cell.label.optimalHeight < 40)
//            {
//                cell.txt.frame.size.height = 40
//            }
//            else
//            {
            cell.txt.frame.size.height = cell.label.optimalHeight + 30
        //    }
//            cell.viewLine.isHidden = false
          tableView.rowHeight = cell.txt.frame.size.height + 10
            
            print(expandedSectionHeaderNumber)
        }
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
       tableView.frame.size.height = 220
        lastView.frame.origin.y = tableView.frame.size.height + tableView.frame.origin.y + 10
        
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.lastView.frame.origin.y + self.lastView.frame.size.height + 20)
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
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        
        let sectionData = self.sectionItems[section] as! NSArray
        
         let getData = sectionData[0] as! String
        
        print(getData)
        let getHeights = UILabel()
        
        getHeights.text = getData
        let getTotalHeight = getHeights.optimalHeight
        tableView.frame.size.height = getTotalHeight + 250 + 10
        
        lastView.frame.origin.y = tableView.frame.size.height + tableView.frame.origin.y + 10
        
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.lastView.frame.origin.y + self.lastView.frame.size.height + 20)
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
    

    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

extension String{
    var encodeEmoji: String? {
        let encodedStr = NSString(cString: self.cString(using: String.Encoding.nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue)
        return encodedStr as? String
    }
    
    var decodeEmoji: String {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if data != nil {
            let valueUniCode = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue) as? String
            if valueUniCode != nil {
                return valueUniCode!
            } else {
                return self
            }
        } else {
            return self
        }
    }
}
extension UILabel {
    var optimalWidth : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: self.frame.height))
            
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            
            return label.frame.width
        }
    }
    
    var optimalHeight : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width,height: CGFloat.greatestFiniteMagnitude))
            
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            
            label.sizeToFit()
            
            return label.frame.height
        }
    }
    
}
extension String
{
    func toDateTime1() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"//this your string date format
        let date = dateFormatter.date(from: self)
    
        dateFormatter.dateFormat = "dd/MM/yyyy"///this is you want to convert format
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    func toDateTime2() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"//this your string date format
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"///this is you want to convert format
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
}
