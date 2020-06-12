  //
//  bookingViewController.swift
//  Carz4Hire
//
//  Created by user on 3/1/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import AFNetworking
import BraintreeDropIn
import Braintree
  var placesClient: GMSPlacesClient!
class bookingViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,GMSAutocompleteViewControllerDelegate {
    @IBOutlet var driverTxt: UITextField!
    @IBOutlet var driverView: UIView!
    @IBOutlet var sideViewHome: UIView!
var getResultsArr = NSMutableArray()
    var connection = webservices()
    var strG = "";
    var getCountryName = NSArray()
    
        let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
          var getDriverint = String()
    @IBOutlet var time2: UILabel!
  var result2 = NSArray()
    var getRecivedData = NSArray()
    var dateFormatDate = NSDate()
    var dateFormatDate2 = NSDate()
    var getNames = String()
    var dateFormatterType = String()
    var dateFormatterType2 = String()
    var driverAge = "yes"
    @IBOutlet var tableView: UITableView!
    @IBOutlet var locationTxt: UITextField!
    @IBOutlet var switchBtnon: UISwitch!
    @IBOutlet var day2: UILabel!
    @IBOutlet var date2: UILabel!
    @IBOutlet var time1: UILabel!
    @IBOutlet var day1: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var viewline: UIView!
    @IBOutlet var createaccountbtn: UIButton!
    @IBOutlet var signinBtn: UIButton!
    @IBOutlet var logoutImg: UIImageView!
    @IBOutlet var logoutLbl: UILabel!
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var pickupLocationView: UIView!
     var pickerView = UIDatePicker()
    var userData = UserDefaults()
       var toolBar = UIToolbar()
    var typePicker = String()
    var lati = CLLocationDegrees()
    var longi = CLLocationDegrees()
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var mapView = GMSMapView()
     var locationLat = NSDictionary()
    var dateFormat2 = String()
   var combineData = NSDictionary()
    var dateFormat = String( )
    var dateFormatTime = String()
      var dateFormatTime2 = String()
    var cityName = String()
    var getCountryCode = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
    self.getLocationsAddress()
        tableView.delegate = self
        tableView.dataSource = self
           placesClient = GMSPlacesClient.shared()
             tableView.isHidden = true
        locationTxt.delegate = self
             //  placeAutoComplete()
         driverView.isHidden = true
               driverView.layer.cornerRadius = 5
        
        driverView.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        driverView.clipsToBounds = true
        driverView.layer.borderWidth = 1
        
        pickupLocationView.layer.cornerRadius = 5
        pickupLocationView.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        pickupLocationView.clipsToBounds = true
        pickupLocationView.layer.borderWidth = 1
        
//        dropoffLocationView.layer.cornerRadius = 5
//
//        dropoffLocationView.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
//        dropoffLocationView.clipsToBounds = true
//        dropoffLocationView.layer.borderWidth = 1
        dateFormatDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) as! NSDate
    let dates = Calendar.current.date(byAdding: .hour, value: 2, to: Date())
//        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        print(dates)
        
        let dateFormatter = DateFormatter()
          let dateFormatter2 = DateFormatter()
        let tempLocale = dateFormatter.locale
                let tempLocale2 = dateFormatter2.locale
        // save locale temporarily
//         dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//        dateFormatter2.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
        // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
          dateFormatter2.dateFormat = "yyyy-MM-dd"
        let dateString5 = dateFormatter.string(from: dates!)
     //   let date = dateFormatter.date(from: dates as! String)!
        dateFormatter.dateFormat = "EEE | MMM"
              dateFormatter2.dateFormat = "dd"
        dateFormatter.locale = tempLocale // reset the locale
           dateFormatter2.locale = tempLocale2
        let dateString = dateFormatter.string(from: dates!)
            let dateString2 = dateFormatter2.string(from: dates!)
        print("EXACT_DATE : \(dateString)")
        
        let dateFormatter3 = DateFormatter()
        let dateFormatter4 = DateFormatter()
        let tempLocale3 = dateFormatter3.locale
        let tempLocale4 = dateFormatter4.locale
        // save locale temporarily
//        dateFormatter3.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//        dateFormatter4.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    
        
        

//        dateFormatter3.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter4.locale = Locale(identifier: "en_US_POSIX")
        // set locale to reliable US_POSIX
        dateFormatter3.dateFormat = "HH:mm"
        dateFormatter4.dateFormat = "HH:mm"
         let dateString6 = dateFormatter3.string(from: dates!)
        //   let date = dateFormatter.date(from: dates as! String)!
        dateFormatter3.dateFormat = "hh:mm a"
        dateFormatter4.dateFormat = "hh:mm a"
        dateFormatter3.locale = tempLocale3
        dateFormatter3.timeZone = NSTimeZone.local
         dateFormatter4.timeZone = NSTimeZone.local
           dateFormatter4.locale = tempLocale4 // reset the locale
        let dateString3 = dateFormatter3.string(from: dates!)
        let dateString4 = dateFormatter4.string(from: dates!)
        print("EXACT_DATE : \(dateString)")
   userData.set(dates, forKey: "minimumDate")
       
        //          dateFormatter.dateFormat = "dd/MM/yyyy"
             date.text = "\(dateString2)"
        date2.text = "\(dateString2)"
        time1.text = "Time:\(dateString3)"
        time2.text = "Time:\(dateString4)"
         dateFormat = "\(dateString5)"
        dateFormat2 = dateString5
        dateFormatTime  = dateString6
        dateFormatTime2  = dateString6
        self.updateToken()
//        let today = Date()
//        let weekday = Calendar.current.component(.weekday, from: today)
//        let month = Calendar.current.component(.month, from: today)
//        let datess = Calendar.current.component(.day, from: today)
//
//        date.text = "\(datess)"
       day1.text = "\(dateString)"
            day2.text = "\(dateString)"
        
     getCurrency()
        let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJkMDM5ZTU5Yjg0ZTVmNTM5ZWYxY2IyNjZiOWZiZTVlOWQ3MTAxMzNiODQwNTQ5MDY0Y2UxY2E0MzI4MTAwZGY1fGNyZWF0ZWRfYXQ9MjAxOS0wMy0xNVQwNTowNjoyNi41MjI3MzU0MzMrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="

    //    self.fetchClientToken()
//self.showDropIn(clientTokenOrTokenizationKey: clientToken)
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                
                print(result.paymentOptionType)
                print(result.paymentMethod as Any)
                print(result.paymentIcon)
                print(result.paymentDescription)
                
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
                
            }
      //      controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    func postNonceToServer(paymentMethodNonce: String) {
        // Update URL with your server
        let paymentURL = URL(string: "https://your-server.example.com/payment-methods")!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(paymentMethodNonce)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            }.resume()
    }
//    func fetchClientToken() {
//        // TODO: Switch this URL to your own authenticated API
//        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
//        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
//        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
//
//        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
//            // TODO: Handle errors
//            let clientToken = String(data: data!, encoding: String.Encoding.utf8)
//
//            print(clientToken)
//            // As an example, you may wish to present Drop-in at this point.
//            // Continue to the next section to learn more...
//            }.resume()
//
//    }
    func getLocationsAddress()
    {
        IJProgressView.shared.showProgressView(view: self.view)
       
connection.startConnectionWithStringGetType2(getUrlString: "getallavailablecountries", outputBlock: { (receivedData) in
    

//        connection.startConnectionWithSting2(getUrlString: "getalllocations", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
        
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                        IJProgressView.shared.hideProgressView()
                        self.getRecivedData = receivedData.value(forKey: "data") as! NSArray
                        
                        self.getCountryCode = self.getRecivedData.value(forKey: "code") as! NSArray
                        
                        self.getCountryName = self.getRecivedData.value(forKey: "country") as! NSArray
                        
//                        for i in 0..<getRecivedData.count
//                        {
//                            
//
//                        }
                      
                        
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
                    
                    self.getLocationsAddress()
                    
                    
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

    func updateToken()
    {
        var param = [NSString: NSObject]()
        
        if(!(userData.value(forKey: "tokenn") == nil))
        {
        param = ["devicetoken":userData.value(forKey: "tokenn") as! NSObject]
        }
        
        print(param)
        
        
        connection.startConnectionWithSting2(getUrlString: "updatetoken", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "status") != nil)))
                {
                    if(receivedData.value(forKey: "status") as! Bool == false)
                    {
                        
                    }
                        
                        
                    else{
                        
                        
                        
                        
                        let alert = UIAlertController(title: "Vcab", message: "Connection Error", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        
                        
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        //  print(message)
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
            }
                
                
                //                    if((receivedData.value(forKey: "status") as! Int) == 0){
                //
                //
                //                    }
            else{
                
                
                let alert = UIAlertController(title: "Vcab", message: "Connection Error", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                
                
                self.present(alert, animated: true, completion: nil)
                
                
                
                //  print(message)
                
                
            }
            
        })
        
        
    }
    
    @IBAction func calBtnTap(_ sender: Any) {
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
    func serverToLocal(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: date)
        
        return localDate
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    @IBAction func mybooking(_ sender: Any) {
        
        userData.removeObject(forKey: "getSeg")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mybookings")
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return result2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "googleCell", for: indexPath) as! carz4hireTableViewCell
        let getName = (result2.object(at: indexPath.row) as AnyObject).value(forKey: "description")
        
        cell.location.text = getName as! String
        return cell
        
    }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                        self.cityName = pm.locality!
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                        self.userData.set(pm.country!, forKey: "setCountry")
                        
                        self.getCountryCode = self.getRecivedData.value(forKey: "code") as! NSArray
                        
                        self.getCountryName = self.getRecivedData.value(forKey: "country") as! NSArray
                       
                       
                            
                        var dtr = ""
                        for i in 0..<self.getCountryCode.count
                        {
                            if((self.getCountryCode.object(at: i) as! String) == pm.country)
                            {
                                dtr = (self.getCountryCode.object(at: i) as! String)
                            }
                           
                        }
                        for i in 0..<self.getCountryName.count
                        {
                            if((self.getCountryName.object(at: i) as! String) == pm.country)
                            {
                                dtr = (self.getCountryName.object(at: i) as! String)
                            }
                            
                        }
                        if(dtr == pm.country)
                        {
                            
                        }
                        else
                        
                        {
                            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: "Coming soon for your location", preferredStyle: UIAlertControllerStyle.alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            
                            
                            
                            self.present(alert, animated: true, completion: nil)
                        }
//                        if(pm.country == "UK" || pm.country == "United Kingdom")
//                        {
//
//
//
//                        }
//
//                        else
//
//                        {
//                            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: "Coming soon for your location", preferredStyle: UIAlertControllerStyle.alert)
//
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//
//
//                            self.present(alert, animated: true, completion: nil)
//                        }
                        
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                }
        })
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        getNames = (result2.object(at: indexPath.row) as AnyObject).value(forKey: "place_id") as! String
//        let getNAmePlace = (result2.objectsea(at: indexPath.row) as AnyObject).value(forKey: "description")
//        locationTxt.text! = getNAmePlace as! String
//         getLatLngForaddress()
//    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
            }
        }
        return nil
    }
    func getCurrency()
    {
        
    
        
        
        let url1="https://free.currencyconverterapi.com/api/v6/convert?q=GBP_\(userData.value(forKey: "saveCurrency")!)&compact=ultra&apiKey=ebc993a57ad8a483f6e4"
        
        let url = URL(string:url1)!
        let request = NSMutableURLRequest(url: url)

        //  request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      
        
        request.httpMethod="GET"
        
       // request.httpBody = post5.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler:  {
            data, response, error in
            
            // handle the data of the successful response here
            
            DispatchQueue.main.async(execute: {
                IJProgressView.shared.hideProgressView()
            });
            // let dataString = String(data: data!, encoding: String.Encoding.utf8)
            
            if(data != nil){
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                //
                
                //
                let dict = self.convertToDictionary(text: dataString!) as! NSDictionary
                
                print(dict)
                let getCurrency = dict.value(forKey: "GBP_\(self.userData.value(forKey: "saveCurrency")!)")
                print(getCurrency!)
                self.userData.set("\(getCurrency!)", forKey: "getCurrencyRate")
                
                DispatchQueue.main.async(execute: {
                    IJProgressView.shared.hideProgressView()
                });
                
                
           
                        //sedan-car-model.png
                        
                
                
            }
            //            DispatchQueue.main.async(execute: {
            //
            //
            //
            //
            //
            //
            //
            //            })
        })
        
        
        task.resume()
    }
    
    func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    @IBAction func searchBtnTap(_ sender: Any) {
      
   
//        let calendar = NSCalendar.current
//
//        // Replace the hour (time) of both dates with 00:00
//        let date111 = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) as! NSDate
//
//        let date222 = dateFormatDate
//
//        print(date111)
//        print(date222)
//
//        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
////        dateFormatter.timeZone = NSTimeZone(name: "UTC") as! TimeZone
//        let datess = dateFormatDate // create   date from string
//        let datess2 = dateFormatDate2
////        // change to a readable time format and change to local time zone
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.timeZone = NSTimeZone.local
//        let timeStamp = dateFormatter.string(from: datess as Date)
//        let timeStampD = dateFormatter.date(from: timeStamp)
//        // let timeStampD = dateFormatter.date(from: timeStamp as Date)
//
//
//        let timeStamp2 = dateFormatter.string(from: datess2 as Date)
//      let timeStampD2 = dateFormatter.date(from: timeStamp2)
//
////       // self.UTCToLocal(date: dateFormatTime)
////        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date222 as Date)
////
//        let components2 = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date111 as Date)
////
//         let components3 = calendar.dateComponents([.minute], from: datess2 as Date)
//        print(components.hour)
//        print(components2.hour)
//
        
//       let components = calendar.dateComponents([.minute], from: date111, to: datess2)
        
//        let dtrrt = calendar.dateComponents([.minute], from: date111, to: datess2)
//        var date12 = Date()
//        var date22 = Date()
//        date12 = timeStampD2 as! Date
//        date22 = timeStampD as! Date
//        if date12 == date22
//        {
//            print("The two dates are the same")
//
//        }
//        else if date12 > date22
//        {
//            print("Date A is earlier than date B")
//        }
//        else if date12 < date22
//        {
//
//            message = "Invalid dates entered Please Check and Try Again."
//
//                                let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
////                                pickerView.removeFromSuperview()
////
////                                toolBar.removeFromSuperview()
////
//                                self.present(alert, animated: true, completion: nil)
//
//        }
//        switch datess.compare(datess2 as Date) {
//
//        case .orderedAscending:
//            print("Date A is earlier than date B")
//        case .orderedSame:
//            print("Date A is later than date B")
//        case .orderedDescending:
//            print("The two dates are the same")
//        }
        
      
        if(driverAge ==  "no")
        {
            getDriverint = driverTxt.text!
        }
        else
        {
            getDriverint = "21"
        }
  if(locationTxt.text == "")
  {
    message = "Please enter a location"
    
    let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    
    
    self.present(alert, animated: true, completion: nil)
        }
    
    
//        else if(components3.minute! < components2.minute!)
//        {
//          
//            message = "Please enter the 2 hours more than the current time"
//
//            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//
//
//            self.present(alert, animated: true, completion: nil)
//            }


        
    
//  else if((components3.day! < components2.day!))
//  {
//    message = "Start date is less than end date"
//
//    let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//
//
//    self.present(alert, animated: true, completion: nil)
//  }
    
//   else if((components3.day! < components2.day!))
//    {
//        message = "Start date is less than end date"
//
//        let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//
//
//        self.present(alert, animated: true, completion: nil)
//    }
    
  
  

    
  else if (date.text == "Date" || date2.text == "Date")
  {
    message = "Enter both dates"
    
    let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    
    
    self.present(alert, animated: true, completion: nil)
  }
  else if (time1.text == "Time" || time2.text == "Time")
  {
    message = "Please enter both times"
    
    let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    
    
    self.present(alert, animated: true, completion: nil)
  }
    
    

    
     else  if(getDriverint == "")
        {
            
            if(driverAge ==  "no")
            {
            message = "Please enter the age of driver"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
        }
    
    }
        else
  {
    
    
    
    
   if(driverAge ==  "no")
   {
         getDriverint = driverTxt.text!
    }
    
        let getInt = Int(getDriverint)
        if(getInt! < 21 || getInt! > 70)
        {
            message = "No cars available: Age requirement not met"
            
            let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            
            
            self.present(alert, animated: true, completion: nil)
        }
    
        
    //    combineData = ["fromDate1":"2018-01-01" ,"fromtime1":"19:30","fromDate2":"2018-01-09","fromtime2":"21:34","latitude":self.locationLat.value(forKey: "lat")!,"longitude":self.locationLat.value(forKey: "lng")!,"type":"all","age":getDriverint]
    else
     {
    if(driverAge ==  "yes")
    {
        
        getDriverint = "21"
        
    }
        let latitide = self.locationLat.value(forKey: "lat")
        let lomgitude = self.locationLat.value(forKey: "lng")
        print(getDriverint)
          print(latitide)
          print(latitide)
    combineData = ["fromDate1":dateFormat ,"fromtime1":dateFormatTime,"fromDate2":dateFormat2,"fromtime2":dateFormatTime2,"latitude":latitide!,"longitude":lomgitude!,"type":"all","age":getDriverint,"location":locationTxt.text!,"city":cityName]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "checkingViewController") as! checkingViewController
        
        vc.getDictData = combineData
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
        }
    }
        
     
        
       
    }
    
    func getLatLngForaddress() {

        IJProgressView.shared.showProgressView(view: self.view)

        
        
        


        let string1 = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(getNames)&key=AIzaSyAbSssFTOk07W0HCgh8PNSwC5uiNZylXlM"

        let string22 = string1.addingPercentEscapes(using: String.Encoding.utf8)!

        let url = URL(string: string22)
        print(url)

        if url != nil{

            let request = NSMutableURLRequest(url: url!)

            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let operation = AFHTTPRequestOperation(request: request as! URLRequest)
            operation.responseSerializer = AFJSONResponseSerializer()


            operation.setCompletionBlockWithSuccess({
                (AFHTTPRequestOperation, responseObject) -> Void in


          
                if let result = responseObject as? NSDictionary {

                    let result2:NSDictionary = (result.value(forKey: "result") as? NSDictionary)!
                        let geometry = result2.value(forKey: "geometry") as! NSDictionary
                        if let location = geometry.value(forKey: "location") as? NSDictionary {
                                                               let latitudeCor = location.value(forKey: "lat") as! CLLocationDegrees
                                                               let longitudeCor = location.value(forKey: "lng") as! CLLocationDegrees
                            
                                                            self.locationLat = ["lat":"\(latitudeCor)","lng":"\(longitudeCor)"]
                            print(self.locationLat)
                         IJProgressView.shared.hideProgressView()
                            self.tableView.isHidden = true
self.getAddressFromLatLon(pdblLatitude: "\(latitudeCor)", withLongitude: "\(longitudeCor)")
                    }
                }


          })
  

            operation.start()

        }
    }
    func getAddress(){
        
        print("lati",lati)
        
        print("longi",longi)
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        var str = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(locationTxt.text!)&location=65.434343,65.23445&radius=500&language=en&key=AIzaSyAbSssFTOk07W0HCgh8PNSwC5uiNZylXlM"
        str = str.replacingOccurrences(of: " ", with: "%20")
        let string22 = str.addingPercentEscapes(using: String.Encoding.utf8)!

        print(str)
        let url = URL(string: string22)
        
        
        print(url!)
        
        let data = try? Data(contentsOf: url!)
        
        if data != nil {
            
            
            
            let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            IJProgressView.shared.hideProgressView()
            if let result = json["predictions"] as? NSArray {
                
                 IJProgressView.shared.hideProgressView()
                print(result)
                
                if result.count != 0{
                    result2 = result
                    tableView.isHidden = false
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                
                    
                    
                    
                    //
                }
                
            }
            
            
            //                        if result.count == 0{
            //
            //                        self.alert.showAlert("Afrikk", subTitle: "No location found" , style: AlertStyle.Error)
            //                        }
        }
        //        }else{
        //
        //
        //            IJProgressView.shared.hideProgressView()
        //        }
        //
        //
        //
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        print("sf,\(place.placeID)")
        
       getNames = "\(place.placeID)"
        locationTxt.text = "\(place.formattedAddress!)"
        getLatLngForaddress()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pickupLocationBtn(_ sender: Any) {
//        let autocompleteController = GMSAutocompleteViewController()
//        autocompleteController.delegate = self
//        let filter = GMSAutocompleteFilter()
//        filter.country = "AU"
//        autocompleteController.autocompleteFilter = filter
//        present(autocompleteController, animated: true, completion: nil)
        let autocompletecontroller = GMSAutocompleteViewController()
        autocompletecontroller.delegate = self
//        let filter = GMSAutocompleteFilter()
//        filter.type = .establishment  //suitable filter type
//
//        filter.country =  "USA"
        
    
     
         //appropriate country code
//        autocompletecontroller.setComponentRestrictions(
//            {'country': ['us', 'pr', 'vi', 'gu', 'mp']});
        
        //autocompletecontroller.autocompleteFilter = filter
        
//        let filter2 = GMSAutocompleteFilter()
//        filter2.type = .establishment  //suitable filter type
//
//        filter2.country =  "UK"
//
//        autocompletecontroller.autocompleteFilter = filter2
        
        self.present(autocompletecontroller, animated: true, completion: nil)
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//
//        if(locationTxt.text == "")
//        {
//            tableView.isHidden = true
//        }
//
//        else{
//
//                IJProgressView.shared.showProgressView(view: self.view)
//            getAddress()
//
//        }
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//
//
//        if(locationTxt.text == "")
//        {
//            tableView.isHidden = true
//        }
//
//        else{
//                getAddress()
//
//        }
//
//
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     //   placeAutoComplete()
        return true
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        placeAutoComplete()
//        return true
//    }
    
//    func placeAutoComplete() {
//        let filter = GMSAutocompleteFilter()
//       // filter.type = .address
//
//        placesClient.autocompleteQuery("s",bounds: nil, filter: filter, callback: {(results, error) -> Void in
//            if let error = error {
//                print("Autocomplete error \(error)")
//                return
//            }
//            if let results = results {
//                for result in results {
//
//                    getResultsArr.add(result.attributedFullText)
//                    print("Result \(result.attributedFullText)")
//                }
//            }
//        })
//
//    }
    

    

    
    // Turn the network activity indicator on and off again.
   
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location = locations.last
//
//        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
//
//     //   self.mapView.animate(to: camera)
//        //        marker.icon = UIImage(named: "radioOff")
//        //         self.marker.position =  CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!)
//        //   marker.map = mapView
//
////        lati = (location?.coordinate.latitude)!
////        longi = (location?.coordinate.longitude)!
//
//        //Finally stop updating location otherwise it will come again and again in this delegate
//      //  self.locationManager.stopUpdatingLocation()
//
//    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//
//            // 4
//            locationManager.startUpdatingLocation()
//
//            //5
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
//        }
//    }
    @IBAction func myaccounttap(_ sender: Any) {
        
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "myaccount")
            
        userData.removeObject(forKey: "getTypeSeg")
            
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "login")
            
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }

    func dropDownList(){
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        //         toolBar.removeFromSuperview()
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            //            pickerView = UIDatePicker(frame: CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300))
            
            pickerView = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 300, width: self.view.frame.size.width, height: 300))
            
            
        }
        else
        {
            
            //            pickerView = UIDatePicker(frame: CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150))
            pickerView = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 150, width: self.view.frame.size.width, height: 150))
            
            
        }
        
        
        
        
   
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        
        

        
        //pickerView.addTarget(self, action: #selector(shiViewController.datePickerValueChanged(_:)), for: UIControlEvents.ValueChanged)
        
        pickerView.addTarget(self, action: #selector(bookingViewController .datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        
        //  pickerView.addTarget(self, action: Selector(("datePickerValueChanged(_:)")), for: UIControlEvents.valueChanged)
        pickerView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        //        toolBar = UIToolbar(frame: CGRectMake(0, self.pickerView.frame.origin.y - 30, self.view.frame.size.width, 30))
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.pickerView.frame.origin.y - 30, width: self.view.frame.size.width, height: 30))
        toolBar.barStyle = UIBarStyle.default
        
        toolBar.isTranslucent = true
        
        toolBar.tintColor = UIColor.blue
        
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action:#selector(bookingViewController.donePicker))
        
        //        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(JobRequestViewController.donePicker))
        
        doneButton.tintColor = UIColor.black
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action:#selector(bookingViewController.canclePicker))
        
        //        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(JobRequestViewController.canclePicker))
        //
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(pickerView)
        
        self.view.addSubview(toolBar)
//        self.pickerView.minimumDate =  Calendar.current.date(byAdding: .hour, value: 2, to: Date())
        if(typePicker == "time1" || typePicker == "time2" )
        {
//              self.pickerView.minimumDate =  Calendar.current.date(byAdding: .hour, value: 2, to: Date())
            
            pickerView.datePickerMode = .time
            
        }
        else{
            if(typePicker == "date1")
            {
             //   self.pickerView.minimumDate =  Calendar.current.date(byAdding: .hour, value: 2, to: Date())
            
            }
                
            else
            {
                if(!(userData.value(forKey: "minimumDate") == nil))
                {
                    self.pickerView.minimumDate = userData.value(forKey: "minimumDate") as? Date



                }

                else{


                   if (strG == "getS")
                   {
                    
                    
                    message = "Invalid dates entered Please Check and Try Again."

                    let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

                    pickerView.removeFromSuperview()

                    toolBar.removeFromSuperview()

                    self.present(alert, animated: true, completion: nil)
                }
                    else
                   {
               
                    
                    }
                    
                }
            }
            
            pickerView.datePickerMode = UIDatePickerMode.date
        }
        
    }
    func donePicker() {
        
        dateFormatterType = "\(dateFormatDate) \(dateFormatTime)"
        dateFormatterType2 = "\(dateFormatDate2) \(dateFormatTime2)"
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        strG = "getS";
        
    }
    
    func canclePicker() {
        
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        var dateG = Date()
        let dateFormatter = DateFormatter()
         dateFormatter.dateStyle = .medium
      let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .medium
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateStyle = .medium
//          dateFormatter.dateFormat = "dd/MM/yyyy"
//        date.text = dateFormatter.string(from: sender.date)

       
        if(typePicker == "time1" || typePicker == "time2" )
        {
            
          dateFormatter.dateFormat = "hh:mm a"
//            let dateFormatter3 = dateFormatter
//
//
//            //                dateFormatter3.dateStyle = .medium
//            dateFormatTime = dateFormatter3.string(from: sender.date)
            
          
            if(typePicker == "time1")
                
            {
                
                dateFormatter3.dateFormat = "HH:mm"
                dateFormatTime = dateFormatter3.string(from: sender.date)
            time1.text = "Time:\(dateFormatter.string(from: sender.date))"
                
            }
                
            else
            {
                time2.text = "Time:\(dateFormatter.string(from: sender.date))"
                
                dateFormatter3.dateFormat = "HH:mm"
                
                dateFormatTime2 = dateFormatter3.string(from: sender.date)
               
                
            }
        }
        else{
         
       
    dateFormatter.dateFormat = "dd"
             dateFormatter2.dateFormat = "EEE | MMM"
            if(typePicker == "date1")
            {
                          dateFormatter3.dateFormat = "yyyy/MM/dd"
                        dateFormat = dateFormatter3.string(from: sender.date)
              dateFormatDate = sender.date as NSDate

                date.text = dateFormatter.string(from: sender.date)
                day1.text = dateFormatter2.string(from: sender.date)
                userData.set(sender.date, forKey: "minimumDate")
                //day1.text = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: sender.date)]
            }
            else
            {
                
                dateFormatter3.dateFormat = "yyyy/MM/dd"
                dateFormat2 = dateFormatter3.string(from: sender.date)
             
                date2.text = dateFormatter.string(from: sender.date)
                day2.text = dateFormatter2.string(from: sender.date)
                
               dateFormatDate2 = sender.date as NSDate
            }
         
        }
        
       dateFormatterType = "\(dateFormatDate) \(dateFormatTime)"
         dateFormatterType2 = "\(dateFormatDate2) \(dateFormatTime2)"
        
       // weekday
       // dobTxt.text = dateFormatter.string(from: sender.date)
        
        
        
    }

    @IBAction func timeBtnTap(_ sender: Any) {
        typePicker = "time1"
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        dropDownList()
        
    }
    @IBAction func timeBtnTap2(_ sender: Any) {
         typePicker = "time2"
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        dropDownList()
    }
    @IBAction func dateBtnTap(_ sender: Any) {
        
       
         typePicker = "date1"
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        dropDownList()

    }
    
    @IBAction func datebtntap2(_ sender: Any) {
         typePicker = "date2"
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        dropDownList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            viewline.isHidden =  true
            createaccountbtn.isHidden =  true
            signinBtn.isHidden = true
            logoutImg.isHidden = false
            logoutLbl.isHidden = false
            logoutBtn.isHidden = false
         
            
        }
        else{
            viewline.isHidden = false
            createaccountbtn.isHidden = false
            signinBtn.isHidden = false
            logoutImg.isHidden = true
            logoutLbl.isHidden = true
            logoutBtn.isHidden = true
            
        }

    }

    
    @IBAction func switchBtnTap(_ sender: UISwitch) {
        
        if(switchBtnon.isOn)
        {
            driverView.isHidden = true
            
            driverAge = "yes"
        }
        
        else
        {
            
            driverView.isHidden = false
            
            driverAge = "no"
            
        }
    }
    @IBOutlet var dropoffLocationView: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func btntt(_ sender: Any) {
        
        var basketTopFrame: CGRect = sideViewHome.frame
        basketTopFrame.origin.x = -950
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {() -> Void in
            self.sideViewHome.frame = basketTopFrame
        }, completion: {(_ finished: Bool) -> Void in
            self.sideViewHome.isHidden = true;
        })

    }
    override func viewWillDisappear(_ animated: Bool) {
        userData.removeObject(forKey: "minimumDate")
    }
    @IBAction func logoutBtnTap(_ sender: Any) {
            self.userData.set("havenot", forKey: "licence")
        userData.removeObject(forKey: "emailSave")
         userData.removeObject(forKey: "emailSave")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func menuBtn(_ sender: Any) {
        
        self.sideViewHome.isHidden = false;
        
        var napkinBottomFrame: CGRect = sideViewHome.frame
        napkinBottomFrame.origin.x = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
            self.sideViewHome.frame = napkinBottomFrame
        }, completion: {(_ finished: Bool) -> Void in
            /*done*/
            
        })

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
