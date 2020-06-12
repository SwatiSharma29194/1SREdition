//
//  detailcarViewController.swift
//  Carz4Hire
//
//  Created by user on 3/16/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class detailcarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var getcarsArr = NSArray()
    var carInfo2 = NSMutableArray()
    var carInfo3 = NSArray()
    @IBOutlet var carsAvailable: UILabel!
    @IBOutlet var filterTxt: UITextField!
    var getDataDict1 = NSDictionary()
    var getTypeDeals = String()
    var connection = webservices()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    var getDatesArr = NSMutableArray()
    var userData = UserDefaults()
    var getDays = NSMutableArray()
    var getValuesArr = NSMutableArray()
    var stringSeven = String()
    var bb = NSDictionary()
    var getBookingArr = NSMutableArray()
    var totalBooking = Double()
    @IBOutlet var tableview: UITableView!
  var filterTap = false
    var  getCurrencyRate = ""
    var currencyName = ""
    var filterArr = ["Filter by","Economy","Prestige","Performance","Supercar","Chauffeur"]
    
    @IBOutlet var filterTblView: UITableView!
    @IBOutlet var searchView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
        getCurrencyRate = self.userData.value(forKey: "getCurrencyRate") as! String
        
        currencyName = self.userData.value(forKey: "saveCurrency") as! String
        
        
        print(getCurrencyRate)
        searchCars()
        
//        let nsdateFromString = String.toDate(dateString: selectedValue, dateFormat: "MM/dd/yyyy")
//
//        // Replace the hour (time) of both dates with 00:00
//        let date1 = calendar.startOfDay(for: 23/01/1994)
//        let date2 = calendar.startOfDay(for: 26/01/1994)
//
//        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
      
        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 5
        searchView.clipsToBounds = true
        filterTblView.delegate  = self
        filterTblView.dataSource = self
        
        let calendar = NSCalendar.current
        getDataDict1 =  userData.value(forKey: "getData") as! NSDictionary
        tableview.delegate = self
        tableview.dataSource = self
        
        var dateStr = getDataDict1.value(forKey: "fromDate1")
        var dateStr2 = getDataDict1.value(forKey: "fromDate2")
        var getStr3 = getDataDict1.value(forKey: "fromtime1")
        var getStr4 = getDataDict1.value(forKey: "fromtime2")
        var getTo1 = "\(dateStr) \(getStr3)"
        var getTo2 = "\(dateStr2) \(getStr4)"
        print(getTo2)
        print(getTo1)
        // Set date format
        var dateFmt = DateFormatter()
        
        dateFmt.timeZone = NSTimeZone.local
        
        dateFmt.dateFormat =  "yyyy/MM/dd HH:mm"
        var dateFmt2 = DateFormatter()
        dateFmt2.timeZone = NSTimeZone.local
        //dateFmt.timeZone = NSTimeZone.default
        dateFmt2.dateFormat =  "yyyy/MM/dd HH:mm"
        // Get NSDate for the given string
        var sd = "\(dateStr!) \(getStr3!)"
        var sd1 = "\(dateStr2!) \(getStr4!)"
        let tempLocale = dateFmt2.locale
        dateFmt2.locale = tempLocale
        var firstDate = dateFmt2.date(from: sd as! String)
        var secondDate = dateFmt2.date(from: sd1 as! String)
        
        
        // let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        
        //        let components = calendar.dateComponents([], from: date1, to: date2)
        //        print(components.day)
        
        
        var datess = firstDate! // first date
        let endDate = secondDate! // last date
        print(datess)
        print(endDate)
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy/MM/dd HH:mm"
        
        let components = calendar.dateComponents([.minute], from: datess, to: endDate)
        
        print("componentscomponents",components.minute!)
        var getCOuntTOtal = Int()
        if(components.minute!<1440)
        {
            getCOuntTOtal = 1
        }
            
        else
        {
            
            let getMod = components.minute!
            if(getMod % 1440 == 0)
            {
                
                getCOuntTOtal = getMod / 1440
            }
                
            else
            {
                let gf = getMod / 1440
                
                getCOuntTOtal = gf + 1
            }
            
            
        }
        
        print("getCOunt",getCOuntTOtal)
        while datess <= endDate {
            print(fmt.string(from: datess))
            getDatesArr.add(fmt.string(from: datess))
            datess = calendar.date(byAdding: .day, value: 1, to: datess)!
            
            print(datess)
        }
        for i in 0..<getCOuntTOtal
        {
            let ftDate = dateFmt.date(from: getDatesArr[i] as! String)
            let weekday = Calendar.current.component(.weekday, from: ftDate as! Date)
            
            print(weekday)
            
            let string = getDatesArr[i]
            
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale // save locale temporarily
            //   dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.timeZone = NSTimeZone.local
            
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            let date = dateFormatter.date(from: string as! String)!
            dateFormatter.dateFormat = "EEE"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            getDays.add(dateString)
        }
        print(getDatesArr)
    }
    func openMap(destLat: String, destLong: String){
        
        let url = NSURL(string: "comgooglemaps://?daddr=\(destLat),\(destLong)&nav=1")
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as! URL, options: ["" : ""], completionHandler: { (_ check: Bool) in
                print("YES YES")
                if(check == true){
                    //Already Installed
                    print("Yes App Exist")
                    
                }
                else if let itunesUrl = NSURL(string: "https://itunes.apple.com/us/app/google-maps-gps-navigation/id585027354?mt=8"), UIApplication.shared.canOpenURL(itunesUrl as URL) {
                    UIApplication.shared.openURL(itunesUrl as URL)
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    func searchCars(){
  
         IJProgressView.shared.showProgressView(view: self.view)
        
        // param ["user_email"]  = emailUser.text! as NSObject
        var param = [NSString: NSObject]()
        
        
        print(getDataDict1.value(forKey: "type"))
        print(getDataDict1.value(forKey: "latitude"))
        print(getDataDict1.value(forKey: "longitude"))
        print(getDataDict1.value(forKey: "age"))
        let getAll = userData.value(forKey: "close")
        getTypeDeals = getAll as! String
        var stringType = String()
        var getLatitudes = ""
        var getLongitudes = ""
        if(getTypeDeals == "All")
        {
            stringType = "all"
            getLatitudes = ""
            getLongitudes = ""
        }
        else{
              stringType = "nearby"
            getLongitudes = getDataDict1.value(forKey: "latitude") as! String
            getLatitudes = getDataDict1.value(forKey: "longitude") as! String
        }
        //   param = ["type":getDictData.value(forKey: "type") as! NSObject,"from":"\(getDictData.value(forKey: "fromDate1")!) \(getDictData.value(forKey: "fromtime1")!)" as NSObject,"to":"\(String(describing: getDictData.value(forKey: "fromDate2")!)) \(getDictData.value(forKey: "fromtime2")!)" as NSObject,"latitude":getDictData.value(forKey: "latitude")  as! NSObject,"longitude":getDictData.value(forKey: "longitude") as! NSObject,"age":getDictData.value(forKey: "age") as! NSObject]
        
        param = ["type":stringType as NSObject,"from":"\(getDataDict1.value(forKey: "fromDate1")!) \(getDataDict1.value(forKey: "fromtime1")!)" as NSObject,"to":"\(String(describing: getDataDict1.value(forKey: "fromDate2")!)) \(getDataDict1.value(forKey: "fromtime2")!)" as NSObject,"latitude":getDataDict1.value(forKey: "latitude")  as! NSObject,"longitude":getDataDict1.value(forKey: "longitude") as! NSObject,"age":getDataDict1.value(forKey: "age") as! NSObject,"car_type":filterTxt.text! as! NSObject,"city":getDataDict1.value(forKey: "city")] as! [NSString : NSObject]
        
        //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
        
        print(param)
        
        
        
        connection.startConnectionWithSting(getUrlString: "getavailablecars", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                          IJProgressView.shared.hideProgressView()
                        
                        let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                        self.bb = receivedData.value(forKey: "data") as! NSDictionary
                        self.getcarsArr = getDataDict.value(forKey: "data") as! NSArray
                        
                           self.carInfo2 = self.getcarsArr.mutableCopy() as! NSMutableArray
                        
                        if(self.carInfo2.count == 0)
                        {
                            self.carsAvailable.isHidden = false
                            self.tableview.isHidden = true
                        }
                        else
                        {
                            self.carsAvailable.isHidden = true
                             self.tableview.isHidden = false
                            DispatchQueue.main.async( execute: {
                                self.tableview.delegate = self
                                self.tableview.dataSource = self
                                self.tableview.reloadData()
                                
                                let index = IndexPath(row: 0, section: 0)
                                
                                // use your index number or Indexpath
                                self.tableview.scrollToRow(at: index,at: .top, animated: false)
                                
                            });
              
                        }
                 
//                        let getLatitudes = getDataArr.value(forKey: "latitude") as! NSArray
//
//                        let getLongitude = getDataArr.value(forKey: "longitude") as! NSArray
//
//
//
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! locationViewController
//
//                        vc.latitudeArr = getLatitudes
//
//                        vc.longitudeArr = getLongitude
//
//                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                        
                        
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
                        self.present(alertController, animated: false, completion: nil)
                        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(tableView == tableview)
        {
        if(carInfo2.count - 1 == indexPath.row){
            
            let nextUrl = bb.value(forKey: "next_page_url")
            print("nexturl",nextUrl)
            if(nextUrl is NSNull){
                
            }
                
            else{
                
//                incrementPages = incrementPages + 1
                
                searchCars2()
                
                
           
            }
        }
        }
    }
    func searchCars2(){
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        // param ["user_email"]  = emailUser.text! as NSObject
        var param = [NSString: NSObject]()
        
        
        print(getDataDict1.value(forKey: "type"))
        print(getDataDict1.value(forKey: "latitude"))
        print(getDataDict1.value(forKey: "longitude"))
        print(getDataDict1.value(forKey: "age"))
        let getAll = userData.value(forKey: "close")
        getTypeDeals = getAll as! String
        var stringType = String()
        
        if(getTypeDeals == "All")
        {
            stringType = "all"
        }
        else{
            stringType = "nearby"
        }
        //   param = ["type":getDictData.value(forKey: "type") as! NSObject,"from":"\(getDictData.value(forKey: "fromDate1")!) \(getDictData.value(forKey: "fromtime1")!)" as NSObject,"to":"\(String(describing: getDictData.value(forKey: "fromDate2")!)) \(getDictData.value(forKey: "fromtime2")!)" as NSObject,"latitude":getDictData.value(forKey: "latitude")  as! NSObject,"longitude":getDictData.value(forKey: "longitude") as! NSObject,"age":getDictData.value(forKey: "age") as! NSObject]
        
        param = ["type":stringType as NSObject,"from":"\(getDataDict1.value(forKey: "fromDate1")!) \(getDataDict1.value(forKey: "fromtime1")!)" as NSObject,"to":"\(String(describing: getDataDict1.value(forKey: "fromDate2")!)) \(getDataDict1.value(forKey: "fromtime2")!)" as NSObject,"latitude":getDataDict1.value(forKey: "latitude")  as! NSObject,"longitude":getDataDict1.value(forKey: "longitude") as! NSObject,"age":getDataDict1.value(forKey: "age") as! NSObject,"car_type":filterTxt.text! as! NSObject,"city":getDataDict1.value(forKey: "city")] as! [NSString : NSObject]
        
        //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
        
        print(param)
        
        
      
        IJProgressView.shared.showProgressView(view: self.view)
        let nextUrl = bb.value(forKey: "next_page_url") as! String
        var newUrl = nextUrl.components(separatedBy: "?")
        connection.startConnectionWithSting(getUrlString: "getavailablecars?\(newUrl[1])" as NSString, method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
//        connection.startConnectionWithSting(getUrlString: "getavailablecars", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                        IJProgressView.shared.hideProgressView()
                           self.bb = receivedData.value(forKey: "data") as! NSDictionary
                        let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                        
                        self.carInfo3 = getDataDict.value(forKey: "data") as! NSArray
//                        if(self.carInfo3.count == 0)
//                        {
//                            self.carsAvailable.isHidden = false
//                        }
//                        else
//                        {
//                            self.carsAvailable.isHidden = true
//
//                        }
                        self.carInfo2.addObjects(from: self.carInfo3 as! [Any])
                        
                        print(self.carInfo2.count)
                        self.tableview.delegate = self
                        self.tableview.dataSource = self
                        self.tableview.reloadData()
                        //                        let getLatitudes = getDataArr.value(forKey: "latitude") as! NSArray
                        //
                        //                        let getLongitude = getDataArr.value(forKey: "longitude") as! NSArray
                        //
                        //
                        //
                        //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! locationViewController
                        //
                        //                        vc.latitudeArr = getLatitudes
                        //
                        //                        vc.longitudeArr = getLongitude
                        //
                        //                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                        
                        
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
                        self.present(alertController, animated: false, completion: nil)
                        
                        
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
                    
                    self.searchCars2()
                    
                    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == filterTblView)
        {
            return filterArr.count
        }
        else
        {
        return carInfo2.count
        }
    }

    @IBAction func filterBtnTap(_ sender: Any) {
        
        if(filterTap == false)
        {
            filterTap = true
            filterTblView.isHidden = false
          filterTblView.reloadData()
        }
        
        else
        {
            filterTap = false
            filterTblView.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getValuesArr.removeAllObjects()
        getValuesArr = []
        getBookingArr.removeAllObjects()
        getBookingArr = []
        if(tableView == filterTblView)
        {
               let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! carz4hireTableViewCell
            
            cell.filterType.text  = filterArr[indexPath.row] as! String
            cell.selectionStyle = .none;

            return cell
        }
        else
        {
            
            getValuesArr.removeAllObjects()
            getValuesArr = []
            getBookingArr.removeAllObjects()
            getBookingArr = []
        let getData = carInfo2.object(at: indexPath.row) as! NSDictionary
     
        let getcarType = getData.value(forKey:"car_type") as! String
        if(getcarType == "Chauffeur")
        {
            
            tableView.rowHeight = 137
            let cell = tableView.dequeueReusableCell(withIdentifier: "celldetail2", for: indexPath) as! carz4hireTableViewCell
              cell.selectionStyle = .none;
            cell.cartitlename.text = (getData.value(forKey:"cartitle") as! String)
            
            let getstrCapital = getData.value(forKey:"car_type") as? String
            
            let egtc = getstrCapital?.uppercased()
            
            cell.economy.text =  egtc as? String
            
         cell.payment.text = getData.value(forKey:"payment_type") as! String
            
         cell.locationlist.text = getData.value(forKey:"location") as? String
            print("getDays.count",getDays.count)
let getCu = Double(Float(getCurrencyRate)!) * 99.00
            let x = getCu
            let y = Double(round(100*x)/100)
            print(y)
            
            cell.moneyCar.text = "From \(currencyName)\(y)"
            
            let getcompanyLogo =  getData.value(forKey:"company_logo")  as! String
            
            let stringAppend = "http://carz4hire.com/companylogo/"
            
            let imageCompany = "\(stringAppend)\(getcompanyLogo)"
            
                  let fileUrl = NSURL(string: imageCompany)
            
            //cell.companyLogo.setImageWith(fileUrl as! URL)
              cell.companyLogo.sd_setImage(with: URL(string: imageCompany))
           if(!(getData.value(forKey:"default_car") is NSNull))
           {
            let getcarLogo =  getData.value(forKey:"default_car")  as! String
            let stringAppend2 = "http://carz4hire.com/carimages/"
            
            let imagecar = "\(stringAppend2)\(getcarLogo)"
          let fileUrl1 = NSURL(string: imagecar)
            print("fileUrl1",fileUrl1)
       //     cell.carImage.setImageWith(fileUrl1! as URL)
              cell.carImage.sd_setImage(with: URL(string: imagecar))
            
            }
            
           
//             cell.driver.text = getData.value(forKey:"driver_uniform") as! String

            return cell
        }
        else
        {
//            monInt = 0
//             tueInt = 0
//             wedInt = 0
//             thuInt = 0
//             friInt = 0
//            satInt = 0
//            sunInt = 0
            
            var monInt = Int()
            var tueInt = Int()
            var wedInt = Int()
            var thuInt = Int()
            var friInt = Int()
            var satInt = Int()
            var sunInt = Int()
            tableView.rowHeight = 137
            let cell = tableView.dequeueReusableCell(withIdentifier: "celldetail", for: indexPath) as! carz4hireTableViewCell
              cell.selectionStyle = .none;
            cell.cartitlename.text = getData.value(forKey:"cartitle") as! String
//                  cell.economy.text =  getData.value(forKey:"car_type") as! String
            
            cell.cartitlename.text = (getData.value(forKey:"cartitle") as! String)
            let getstrCapital = getData.value(forKey:"car_type") as? String
            let egtc = getstrCapital?.uppercased()
            cell.economy.text =  egtc as? String
            cell.age.text =  "\(getData.value(forKey:"driver_age")!)+"
            cell.locationlist.text = getData.value(forKey:"location") as! String
            cell.payment.text = getData.value(forKey:"payment_type") as! String
            
            print("getDays.count",getDays.count)
            
            let getDaysString:String = getDays.componentsJoined(by: ",")
            
            for i in 0..<getDays.count{
                
                if(getDays[i] as! String == "Mon")
                {
                    
                    monInt = monInt + 1
                    // getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                }
                
                if(getDays[i] as! String == "Tue")
                {
                    tueInt = tueInt + 1
                    //     getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                }
                if(getDays[i] as! String == "Wed")
                {
                    wedInt = wedInt + 1
                    //  getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                }
                if(getDays[i] as! String == "Thu")
                {
                    thuInt = thuInt + 1
                    // getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                }
                if(getDays[i] as! String == "Fri")
                {
                    friInt = friInt + 1
                    //    getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
                }
                if(getDays[i] as! String == "Sat")
                {
                    satInt = satInt + 1
                    // getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
                }
                if(getDays[i] as! String == "Sun")
                {
                    sunInt = sunInt + 1
                    //  getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
                }
                
                
                
            }
            
            var getNumberDays:NSDictionary = ["Monday":monInt,"Tuesday":tueInt,"wednesday":wedInt,"thursday":thuInt,"friday":friInt,"saturday":satInt,"Sunday":sunInt]
            
            print("getNumberDays",getNumberDays)
            let getNumberData = getNumberDays.value(forKey: "Monday") as! Int
            
            
            //            if(getDays.count == 0)
            //            {
            //                   for i in 0..<getNumberData
            //                   {
            //                    getValuesArr.add(getData.value(forKey:"wekly charges")  as! Int)
            //                }
            //            }
            //            else{
            
            let getModulus = getDays.count % 7
            
            print("getModulus",getModulus)
//            if(getDays.count >= 7)
//            {
       if((getModulus == 0))
       {
        let getModulus22 = getDays.count / 7
            for i in 0..<getModulus22
            {
                print("numberofweeks",getModulus)
                getValuesArr.add(getData.value(forKey:"full_week_charges")  as! Int)
                getBookingArr.add(getData.value(forKey:"fullweek_charges")  as! Int)
            }
            }
                
    if(!(getModulus == 0))
                
       {
        let gtet = getDays.count / 7
        for i in 0..<gtet
        {
            print("numberofweeks",getModulus)
            getValuesArr.add(getData.value(forKey:"full_week_charges")  as! Int)
            getBookingArr.add(getData.value(forKey:"fullweek_charges")  as! Int)
        }
            
            let getModulussd:Int = getDays.count % 7
            
            
            print("getModulussd",getModulussd)
            for i in 0..<monInt - gtet
            {
                if(!(getNumberDays.value(forKey: "Monday") as! Int == 0))
                {
                    getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                    getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
                }
            }
            for i in 0..<tueInt - gtet
            {
                if(!(getNumberDays.value(forKey: "Tuesday") as! Int == 0))
                {
                    getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                    getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
                    
                }
            }
            for i in 0..<wedInt - gtet
            {
                if(!(getNumberDays.value(forKey: "wednesday") as! Int == 0))
                {
                    getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                    getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
                    
                }
            }
            for i in 0..<thuInt - gtet
            {
                if(!(getNumberDays.value(forKey: "thursday") as! Int == 0))
                {
                    getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
                    getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
                    
                }
            }
        
        if((!(getNumberDays.value(forKey: "friday") as! Int - gtet == 0)) && (!(getNumberDays.value(forKey: "saturday") as! Int - gtet == 0)) && (!(getNumberDays.value(forKey: "Sunday") as! Int - gtet == 0)))
        {
            if(getNumberDays.value(forKey: "friday") as! Int == getNumberDays.value(forKey: "saturday")as! Int) && (getNumberDays.value(forKey: "saturday") as! Int == getNumberDays.value(forKey: "Sunday") as! Int) && (getNumberDays.value(forKey: "Sunday") as! Int == getNumberDays.value(forKey: "friday")as! Int)
            {
                getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
                getBookingArr.add(getData.value(forKey:"weekend_charges")  as! Int)
            }
            else
            {
                for i in 0..<friInt - gtet
                {
                    if(!(getNumberDays.value(forKey: "friday") as! Int == 0))
                    {
                        //getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
                        
                        
                        
                        
                        getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
                        
                        getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
                        
                        
                    }
                }
                for i in 0..<satInt - gtet
                {
                    if(!(getNumberDays.value(forKey: "saturday") as! Int == 0))
                    {
                        
                        
                        getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
                        
                        getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
                        
                    }
                }
                for i in 0..<sunInt - gtet
                {
                    if(!(getNumberDays.value(forKey: "Sunday") as! Int == 0))
                    {
                        
                        
                        getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
                        
                        getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
                    }
                    //  }
                    
                }
            }
        }
        else{
            for i in 0..<friInt - gtet
            {
                if(!(getNumberDays.value(forKey: "friday") as! Int == 0))
                {
                    //getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
                    
               
                        
                   
                        getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
                        
                        getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
                    
                    
                }
            }
            for i in 0..<satInt - gtet
            {
                if(!(getNumberDays.value(forKey: "saturday") as! Int == 0))
                {
                    
                  
                        getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
                        
                        getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
                    
                }
            }
            for i in 0..<sunInt - gtet
            {
                if(!(getNumberDays.value(forKey: "Sunday") as! Int == 0))
                {
                    
                   
                        getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
                        
                        getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
                    }
                    //  }
                
            }
        
        }
            }
//            }
//            else
//       {
//
//            let getModulussd:Int = getDays.count % 7
//
//
//            print("getModulussd",getModulussd)
//            for i in 0..<monInt
//            {
//            if(!(getNumberDays.value(forKey: "Monday") as! Int == 0))
//            {
//                getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
//                 getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
//            }
//            }
//            for i in 0..<tueInt
//            {
//            if(!(getNumberDays.value(forKey: "Tuesday") as! Int == 0))
//            {
//                getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
//                  getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
//
//            }
//            }
//            for i in 0..<wedInt
//            {
//            if(!(getNumberDays.value(forKey: "wednesday") as! Int == 0))
//            {
//                getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
//                  getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
//
//            }
//            }
//            for i in 0..<thuInt
//            {
//            if(!(getNumberDays.value(forKey: "thursday") as! Int == 0))
//            {
//                getValuesArr.add(getData.value(forKey:"company_charges")  as! Int)
//                  getBookingArr.add(getData.value(forKey:"booking_charges")  as! Int)
//
//            }
//            }
//            for i in 0..<friInt
//            {
//            if(!(getNumberDays.value(forKey: "friday") as! Int == 0))
//            {
//                //getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
//
//                if(getNumberDays.value(forKey: "friday") as! Int == getNumberDays.value(forKey: "saturday")as! Int) && (getNumberDays.value(forKey: "saturday") as! Int == getNumberDays.value(forKey: "Sunday") as! Int) && (getNumberDays.value(forKey: "Sunday") as! Int == getNumberDays.value(forKey: "friday")as! Int)
//                {
//                    getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
//                    getBookingArr.add(getData.value(forKey:"weekend_charges")  as! Int)
//                }
//
//                else
//
//                {
//                    getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
//
//                    getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
//                }
//
//            }
//            }
//            for i in 0..<satInt
//            {
//            if(!(getNumberDays.value(forKey: "saturday") as! Int == 0))
//            {
//
//                if(getNumberDays.value(forKey: "friday") as! Int == getNumberDays.value(forKey: "saturday")as! Int) && (getNumberDays.value(forKey: "saturday") as! Int == getNumberDays.value(forKey: "Sunday") as! Int) && (getNumberDays.value(forKey: "Sunday") as! Int == getNumberDays.value(forKey: "friday")as! Int)
//                {
//                    getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
//                    getBookingArr.add(getData.value(forKey:"weekend_charges")  as! Int)
//                }
//
//                else
//
//                {
//                    getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
//
//                    getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
//                }
//            }
//            }
//            for i in 0..<sunInt
//            {
//            if(!(getNumberDays.value(forKey: "Sunday") as! Int == 0))
//            {
//
//                if(getNumberDays.value(forKey: "friday") as! Int == getNumberDays.value(forKey: "saturday")as! Int) && (getNumberDays.value(forKey: "saturday") as! Int == getNumberDays.value(forKey: "Sunday") as! Int) && (getNumberDays.value(forKey: "Sunday") as! Int == getNumberDays.value(forKey: "friday")as! Int)
//                {
//                    getValuesArr.add(getData.value(forKey:"company_weekend_charges")  as! Int)
//                    getBookingArr.add(getData.value(forKey:"weekend_charges")  as! Int)
//                }
//
//                else
//
//                {
//                    getBookingArr.add(getData.value(forKey:"weekendday_charges")  as! Int)
//
//                    getValuesArr.add(getData.value(forKey:"company_weekend_day_charges")  as! Int)
//                }
//                //  }
//            }
//            }
           // }
            
            print("klkl",getValuesArr)
            var getArray = NSArray()
            getArray = getValuesArr.mutableCopy() as! NSArray
        
          var tt = 0.00
            var total = 0.00
            for element in getArray {
                print("\(element) ")
                tt += Double(element as! Int)
            }
            
            print(Float(getCurrencyRate)!)
            total = Double((Float(getCurrencyRate)!) * Float(tt))
             totalBooking = 0.00
            for element in getBookingArr {
                print("\(element) ")
                totalBooking += Double(element as! Int)
            }
            print(" =  \(total)")
            
            
            
            if(getData.value(forKey:"display_price") as! Int == 1 )
            {
                cell.moneyCar.isHidden = true
                cell.phoneIcon.isHidden = false
            }
            else
            {
                cell.moneyCar.isHidden = false
                cell.phoneIcon.isHidden = true
                let x = total
                let y = Double(round(100*x)/100)
                print(y)
                
               
                cell.moneyCar.text = "\(currencyName)\(y)"
            }
            
                      cell.strReservation = getData.value(forKey:"reservation_charges") as! Int
            
            cell.strBooking = "\(totalBooking)"
            
            let getcompanyLogo =  getData.value(forKey:"company_logo")  as! String
            
            let stringAppend = "http://carz4hire.com/companylogo/"
            
            let imageCompany = "\(stringAppend)\(getcompanyLogo)"
            
            let fileUrl = NSURL(string: imageCompany)
            
         //   cell.companyLogo.setImageWith(fileUrl as! URL)
            
            cell.companyLogo.sd_setImage(with: URL(string: imageCompany))
            
            if(!(getData.value(forKey:"default_car") is NSNull))
                
            {
                
            let getcarLogo =  getData.value(forKey:"default_car")  as! String
                
            let stringAppend2 = "http://carz4hire.com/carimages/"
            
            let imagecar = "\(stringAppend2)\(getcarLogo)"
                
            let fileUrl1 = NSURL(string: imagecar)
                
            print("fileUrl1",fileUrl1)
                
        //    cell.carImage.setImageWith(fileUrl1! as URL)
                  cell.carImage.sd_setImage(with: URL(string: imagecar))
            }
            
            else
            {
                let imagecar = ""
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
             //   cell.carImage.setImageWith(fileUrl1! as URL)
                  cell.carImage.sd_setImage(with: URL(string: imagecar))
            }
//            let getBooking = getData.value(forKey:"booking_charges") as! Int
//               let getPercentage = (getBooking * total ) / 100
            
            cell.moneyCar.tag = indexPath.row
     
             return cell
          
        }
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
             if(tableView == filterTblView)
             {
                if(filterArr[indexPath.row] == "Filter by")
                {
                    filterTxt.text = ""
                }
                else
                {
                filterTxt.text = filterArr[indexPath.row] as! String
                }
                filterTblView.isHidden = true
                filterTap = false
                 searchCars()
        }
                
        else
             {
                  self.userData.removeObject(forKey: "getcompanyCost")
                self.userData.removeObject(forKey: "saveQuotes")
                
                userData.removeObject(forKey: "savequoteIdget")
                
                
                self.userData.removeObject(forKey: "upcoming")
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail") as! cardetailss
           let getData                                                                                                                                                                                                                                                                                                                                                                         = carInfo2.object(at: indexPath.row) as! NSDictionary
           let idget = (getData.value(forKey:"id") as! Int)
                let cell = tableView.cellForRow(at: indexPath) as! carz4hireTableViewCell
         let getStrCell = cell.moneyCar.text
            userData.set(getStrCell, forKey: "getStrCell")
                
               
                let getStrCellBook = cell.strBooking
                userData.set(getStrCellBook, forKey: "getStrCellBook")
                print(getStrCell)
                userData.set(idget, forKey: "idget")
                let strReservation = cell.strReservation
                userData.set(strReservation, forKey: "strReservation")
           

//
                vc.getBook = Double(totalBooking)
                self.navigationController?.pushViewController(vc, animated: false)
//        }
    }
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
    override func viewWillDisappear(_ animated: Bool) {
        getDays.removeAllObjects()
        getValuesArr.removeAllObjects()
        getDays = []
    }
}

