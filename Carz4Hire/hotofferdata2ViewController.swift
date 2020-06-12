//
//  hotofferdata2ViewController.swift
//  Carz4Hire
//
//  Created by user on 4/20/18.
//  Copyright © 2018 user. All rights reserved.
//


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

    class hotofferdata2ViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,GMSAutocompleteViewControllerDelegate {
        @IBOutlet var driverTxt: UITextField!
        @IBOutlet var driverView: UIView!
var getCarId = Int()
        var dateG1 = Date()
        
        @IBOutlet var datebtn2: UIButton!
        @IBOutlet var datebtn1: UIButton!
        var dateG2 = Date()
        var getResultsArr = NSMutableArray()
        var connection = webservices()
        let validation:Validation = Validation.validationManager() as! Validation
        var message = String()
        var getDriverint = String()
        @IBOutlet var time2: UILabel!
          var placesClient: GMSPlacesClient!
        var result2 = NSArray()
        var getNames = String()
        var driverAge = String()
        @IBOutlet var tableView: UITableView!
        @IBOutlet var locationTxt: UITextField!
        @IBOutlet var switchBtnon: UISwitch!
        @IBOutlet var day2: UILabel!
        @IBOutlet var date2: UILabel!
        @IBOutlet var time1: UILabel!
        @IBOutlet var day1: UILabel!
        @IBOutlet var date: UILabel!
     
        @IBOutlet var pickupLocationView: UIView!
        var pickerView = UIDatePicker()
        var userData = UserDefaults()
        var toolBar = UIToolbar()
        var typePicker = String()
        var lati = CLLocationDegrees()
        var longi = CLLocationDegrees()
        let locationManager = CLLocationManager()
       
        var mapView = GMSMapView()
        var locationLat = NSDictionary()
        var dateFormat2 = String()
        var combineData = NSDictionary()
        var dateFormat = String( )
        var dateFormatTime = String()
        var dateFormatTime2 = String()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
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
            
//            dropoffLocationView.layer.cornerRadius = 5
//
//            dropoffLocationView.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
//            dropoffLocationView.clipsToBounds = true
//            dropoffLocationView.layer.borderWidth = 1
     //       let dates = Calendar.current.date(byAdding: .year, value: 0, to: Date())
//            userData.set(getvalidtodate, forKey: "getValidTo")
//            userData.set(getvalidfromdate, forKey: "getValidFrom")
       
            //        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
           
             let datescurrent = Calendar.current.date(byAdding: .hour, value: 2, to: Date())
            let dateFormatter = DateFormatter()
            let dateFormatter2 = DateFormatter()
            let tempLocale = dateFormatter.locale
            let tempLocale2 = dateFormatter2.locale
//            dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//            dateFormatter2.timeZone = NSTimeZone(name: "UTC")! as TimeZone
            // save locale temporarily
            let getStrDates = userData.value(forKey: "getValidFrom") as! String
               let getStrDatesFrom = userData.value(forKey: "getValidTo") as! String
            
            if(!(getStrDates == ""))
            {
                datebtn1.isHidden = true
                datebtn2.isHidden = true
//             let dates = dateFormatter.date(from: getStrDates as! String)
//            let dates = dateFormatter.date(from: getStrDates) as! Date
       
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
            // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter2.dateFormat = "yyyy-MM-dd"
             var dates = dateFormatter.date(from: getStrDates as! String)
                  print(dates)
                    let dateString5 = dateFormatter.string(from: dates!)
            var dates2 = dateFormatter.date(from: getStrDatesFrom as! String)
                   let dateString8 = dateFormatter.string(from: dates2!)
            print(dates)
            
            //   let date = dateFormatter.date(from: dates as! String)!
            dateFormatter.dateFormat = "EEE | MMM"
            dateFormatter2.dateFormat = "dd"
            dateFormatter.locale = tempLocale // reset the locale
            dateFormatter2.locale = tempLocale2
            let dateString = dateFormatter.string(from: dates!)
             let dateStringg = dateFormatter.string(from: dates2!)
            
            let dateString2 = dateFormatter2.string(from: dates!)
              let dateString2g = dateFormatter2.string(from: dates2!)
            print("EXACT_DATE : \(dateString)")
            
            let dateFormatter3 = DateFormatter()
            let dateFormatter4 = DateFormatter()
            let tempLocale3 = dateFormatter3.locale
            let tempLocale4 = dateFormatter4.locale
            // save locale temporarily
//                dateFormatter3.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//                dateFormatter4.timeZone = NSTimeZone(name: "UTC")! as TimeZone
                
//            dateFormatter3.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatter4.locale = Locale(identifier: "en_US_POSIX")
            // set locale to reliable US_POSIX
            dateFormatter3.dateFormat = "HH:mm"
            dateFormatter4.dateFormat = "HH:mm"
            let dateString6 = dateFormatter3.string(from: datescurrent!)
               let dateString7 = dateFormatter3.string(from: datescurrent!)
            //   let date = dateFormatter.date(from: dates as! String)!
            dateFormatter3.dateFormat = "hh:mm a"
            dateFormatter4.dateFormat = "hh:mm a"
            dateFormatter3.locale = tempLocale3
            dateFormatter4.locale = tempLocale4 // reset the locale
            let dateString3 = dateFormatter3.string(from: datescurrent!)
            let dateString4 = dateFormatter4.string(from: datescurrent!)
            print("EXACT_DATE : \(dateString)")
            
            //          dateFormatter.dateFormat = "dd/MM/yyyy"
            date.text = "\(dateString2)"
            date2.text = "\(dateString2g)"
            time1.text = "Time:\(dateString3)"
            time2.text = "Time:\(dateString4)"
            dateFormat = dateString5
            dateFormat2 = dateString8
            dateFormatTime  = dateString6
            dateFormatTime2  = dateString7
                
           userData.set(dates, forKey: "minimumDate")
         userData.set(dates2, forKey: "maximum")
            //        let today = Date()
            //        let weekday = Calendar.current.component(.weekday, from: today)
            //        let month = Calendar.current.component(.month, from: today)
            //        let datess = Calendar.current.component(.day, from: today)
            //
            //        date.text = "\(datess)"
            day1.text = "\(dateString)"
            day2.text = "\(dateStringg)"
             dateFormat = dateString5
             dateFormat2 = dateString8
            dateFormatTime  = dateString6
             dateFormatTime2  = dateString7
            //
            //        date2.text = "\(datess)"
            //        day2.text = "\(Calendar.current.shortMonthSymbols[month-1]) \(datess)"
            //        date.text = Calendar.current.weekdaySymbols[weekday-1]
            //        day1.text = "\(Calendar.current.shortMonthSymbols[month-1]) \(datess)"
            //
            //        date2.text = Calendar.current.weekdaySymbols[weekday-1]
            //        day2.text = "\(Calendar.current.shortMonthSymbols[month-1]) \(datess)"
            }
            
            else
            {
                datebtn1.isHidden = false
                datebtn2.isHidden = false
                let dates = Calendar.current.date(byAdding: .hour, value: 2, to: Date())
                //        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
                print(dates)
                
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let tempLocale = dateFormatter.locale
                let tempLocale2 = dateFormatter2.locale
                
                // save locale temporarily
//                dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//                dateFormatter2.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//                dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
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
//                dateFormatter3.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//                dateFormatter4.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//                dateFormatter3.locale = Locale(identifier: "en_US_POSIX")
//                dateFormatter4.locale = Locale(identifier: "en_US_POSIX")
                // set locale to reliable US_POSIX
                dateFormatter3.dateFormat = "HH:mm"
                dateFormatter4.dateFormat = "HH:mm"
                let dateString6 = dateFormatter3.string(from: dates!)
                //   let date = dateFormatter.date(from: dates as! String)!
                dateFormatter3.dateFormat = "hh:mm a"
                dateFormatter4.dateFormat = "hh:mm a"
                dateFormatter3.locale = tempLocale3
                dateFormatter4.locale = tempLocale4 // reset the locale
                let dateString3 = dateFormatter3.string(from: dates!)
                let dateString4 = dateFormatter4.string(from: dates!)
                print("EXACT_DATE : \(dateString)")
                
                //          dateFormatter.dateFormat = "dd/MM/yyyy"
                date.text = "\(dateString2)"
                date2.text = "\(dateString2)"
                time1.text = "Time:\(dateString3)"
                time2.text = "Time:\(dateString4)"
                dateFormat = dateString5
                dateFormat2 = dateString5
                dateFormatTime  = dateString6
                dateFormatTime2  = dateString6
                day1.text = "\(dateString)"
                      day2.text = "\(dateString)"
            }
            // Do any additional setup after loading the
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
        //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        getNames = (result2.object(at: indexPath.row) as AnyObject).value(forKey: "place_id") as! String
        //        let getNAmePlace = (result2.object(at: indexPath.row) as AnyObject).value(forKey: "description")
        //        locationTxt.text! = getNAmePlace as! String
        //         getLatLngForaddress()
        //    }
        
        @IBAction func searchBtnTap(_ sender: Any) {
            
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
                    combineData = ["fromDate1":dateFormat ,"fromtime1":dateFormatTime,"fromDate2":dateFormat2,"fromtime2":dateFormatTime2,"latitude":latitide!,"longitude":lomgitude!,"type":"all","age":getDriverint,"location":locationTxt.text!]
                    
                    let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail") as! cardetailss
                    
                    userData.set(combineData, forKey: "getData")
            
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                }
            }
        }
//                     let dateFormatter = DateFormatter()
//
//
//
//

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
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            present(autocompleteController, animated: true, completion: nil)
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
   
            //
            cancelButton.tintColor = UIColor.black
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            
            toolBar.isUserInteractionEnabled = true
            
            self.view.addSubview(pickerView)
            
            self.view.addSubview(toolBar)
            
            if(typePicker == "time1" || typePicker == "time2" )
            {
                
                
                pickerView.datePickerMode = .time
                
            }
            else{
                if(typePicker == "date1")
                {
                    let getStrDates = userData.value(forKey: "getValidFrom") as! String
                    //                        let getStrDatesFrom = userData.value(forKey: "getValidTo") as! String
//
                    if(!(getStrDates == ""))
                    {
                        self.pickerView.minimumDate = userData.value(forKey: "minimumDate") as? Date
                        self.pickerView.maximumDate = userData.value(forKey: "maximum") as? Date
                    }
                    else
                    {
                        
                    }
                    
                }
                    
                else
                {
                    if(!(userData.value(forKey: "minimumDate") == nil))
                    {
                        let getStrDates = userData.value(forKey: "getValidFrom") as! String
                        //                        let getStrDatesFrom = userData.value(forKey: "getValidTo") as! String
                        //
                        if(!(getStrDates == ""))
                        {
                            self.pickerView.minimumDate = userData.value(forKey: "minimumDate") as? Date
                            self.pickerView.maximumDate = userData.value(forKey: "maximum") as? Date
                        }
                        else
                        {
                            self.pickerView.minimumDate = userData.value(forKey: "minimumDate") as? Date
                          
                        }
                       
                    }
                        
                    else{
                        
                        
//                        message = "Enter the from date First"
//
//                        let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//                        pickerView.removeFromSuperview()
//
//                        toolBar.removeFromSuperview()
//
//                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                pickerView.datePickerMode = UIDatePickerMode.date
            }
            
        }
        func donePicker() {
            
            
            
            pickerView.removeFromSuperview()
            
            toolBar.removeFromSuperview()
            
            
        }
        
        func canclePicker() {
            
            
            pickerView.removeFromSuperview()
            
            toolBar.removeFromSuperview()
            
            
        }
        
        
        func datePickerValueChanged(sender:UIDatePicker) {
            
            
            
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
                                  // dateG2 = sender.date as Date
                    
                    date.text = dateFormatter.string(from: sender.date)
                    day1.text = dateFormatter2.string(from: sender.date)
                     userData.set(sender.date, forKey: "minimumDate")
//                    if dateG1 == sender.date
//                    {
//
//                    }
//                    else if dateG1 > sender.date
//                    {
//                        message = "Start date should always be less than end date"
//
//                        let alert = UIAlertController(title: "1 STOP CAR RENTALS", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//
//
//                        self.present(alert, animated: true, completion: nil)
//
//                    }
//                    else if dateG1 < sender.date
//                    {
//
//                   }
                    //day1.text = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: sender.date)]
                }
                else
                {
                 
                    //  let date2 = Date().addingTimeInterval(100)
                  //   userData.set(sender.date, forKey: "maximum")
          
                    dateFormatter3.dateFormat = "yyyy/MM/dd"
                    dateFormat2 = dateFormatter3.string(from: sender.date)
                    
                    date2.text = dateFormatter.string(from: sender.date)
                    day2.text = dateFormatter2.string(from: sender.date)
                     dateG2 = sender.date as Date
//

                }
                
            }
            
            
            
            // weekday
            // dobTxt.text = dateFormatter.string(from: sender.date)
            
            
            
        }
        
        @IBAction func timeBtnTap(_ sender: Any) {
            typePicker = "time1"
            
            pickerView.removeFromSuperview()
            
            toolBar.removeFromSuperview()
            
            dropDownList()
            
        }
        @IBAction func backBtnTap(_ sender: Any) {
            
            self.navigationController?.popViewController(animated: true)
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
            
            driverAge = "yes"
          
        }
        
//        @IBAction func backBtn(_ sender: Any) {
//            
//            self.navigationController?.popViewController(animated: false)
//        }
        
        @IBAction func switchBtnTap(_ sender: UISwitch) {
            
            if(switchBtnon.isOn)
            {
                driverView.isHidden = true
                driverAge = "yes"
            }
                
            else{
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
        
    
        override func viewWillDisappear(_ animated: Bool) {
            userData.removeObject(forKey: "minimumDate")
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


