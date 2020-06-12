//
//  minibusandcoachesViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 19/11/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class minibusandcoachesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GMSAutocompleteViewControllerDelegate,GMSMapViewDelegate {
    var getNames = String()
  
    @IBOutlet var view3: UIView!
    @IBOutlet var veiew1: UIView!
    @IBOutlet var googleMap: UIView!
    
    @IBOutlet var seedealsbtn: UIButton!
    var getcarsArr = NSArray()
    let marker = GMSMarker()
var carInfoget2 = NSMutableArray()
     var bb = NSDictionary()
    @IBOutlet var noVEhicle: UILabel!
    @IBOutlet var locatonView: UIView!
    
    @IBOutlet var viewLocationf: UIView!
    @IBOutlet var filterTbl: UITableView!
    @IBOutlet var filterTxt: UITextField!
    
    @IBOutlet var searchTxt: UITextField!
    @IBOutlet var filterView: UIView!
    var carInfoget3 = NSArray()
    var connection = webservices()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    var mapView = GMSMapView()
    var locationLat = NSDictionary()
    var userData = UserDefaults()
    @IBOutlet var tableView: UITableView!
    var filterTblArr = ["Filter by","Minibus","Coach","Van"]
  var  filterTap = false
    var cityNameMinibus = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLocationsMin()
        filterView.layer.borderColor = UIColor.lightGray.cgColor
        filterView.layer.borderWidth = 1
        filterView.layer.cornerRadius = 5
        filterView.clipsToBounds = true
        
        locatonView.layer.borderColor = UIColor.lightGray.cgColor
        locatonView.layer.borderWidth = 1
        locatonView.layer.cornerRadius = 5
        locatonView.clipsToBounds = true
  self.locationLat = ["lat":"","lng":""]
        //self.searchCars()
        
   

    //  marker.position = CLLocationCoordinate2D(latitude:latitude_origin, longitude: longitude_origin)
    
    

  
    mapView.settings.setAllGesturesEnabled(true)
        // Do any additional setup after loading the view.
    }
    func getLocationsMin()
    {
           IJProgressView.shared.showProgressView(view: self.view)
          var param = [NSString: NSObject]()
        param = ["":""  as! NSObject]
   
        
        print(param)
        connection.startConnectionWithSting2(getUrlString: "getalllocations", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                   IJProgressView.shared.hideProgressView()
                        
                        
                        
                        let getDataArr = receivedData.value(forKey: "data") as! NSArray
                        
                        if(getDataArr.count == 0)
                        {
                            
                        }
                        else
                        {
                            let getLatitudes = getDataArr.value(forKey: "latitude") as! NSArray
                            
                            let getLongitude = getDataArr.value(forKey: "longitude") as! NSArray
                            
                            
                            if(getLatitudes.count > 0)
                            {
                                let lat1 = getLatitudes.object(at: 0) as! String
                                
                                let lng1 = getLongitude.object(at: 0) as! String
                                
                                let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat1)!, longitude: CLLocationDegrees(lng1)!, zoom: 6.0)
                                self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                            }
                            else
                            {
                                let camera = GMSCameraPosition.camera(withLatitude: 55.3781, longitude: 3.4360, zoom: 5.0)
                                self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                            }
                            
                            
                         //   mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                            
                            self.mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.googleMap.frame.size.height)
                            
                            self.googleMap.addSubview(self.mapView)
                            
//                            self.mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.size.height)
//
//                            self.view.addSubview(self.mapView)
                            //  marker.position = CLLocationCoordinate2D(latitude:latitude_origin, longitude: longitude_origin)
                            for i in 0..<getLatitudes.count {
                                
                                let markers = GMSMarker()
                                
                                let lat1 = getLatitudes.object(at: i) as! String
                                
                                let lng1 = getLongitude.object(at: i) as! String
                                
                                markers.position = CLLocationCoordinate2D(latitude:CLLocationDegrees(lat1)!, longitude: CLLocationDegrees(lng1)!)
                                
                                //markers.icon = UIImage(named: "location-marker copy")
                                // markers.title = originDestData.object(at: i) as! String
                                
                                
                                markers.map = self.mapView
                                
                            }
                            //        marker.icon = UIImage(named: "location-marker.png")
                         
                            self.mapView.delegate = self
                            self.mapView.settings.setAllGesturesEnabled(true)
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! locationViewController
//
//
//
//                            self.userData.setValue(getLatitudes, forKey: "getLatitudes")
//                            self.userData.setValue(getLongitude, forKey: "getLongitude")
                    //        self.navigationController?.pushViewController(vc, animated: false)
                            
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
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func openLocationView(_ sender: Any) {
        viewLocationf.isHidden = false
    }
    @IBAction func backBtnData(_ sender: Any) {
        viewLocationf.isHidden = false
         view3.isHidden = true
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        print("sf,\(place.placeID)")
        
        getNames = "\(place.placeID)"
        searchTxt.text = "\(place.formattedAddress!)"
        getLatLngForaddress()
       
        dismiss(animated: true, completion: nil)
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
                        self.cityNameMinibus = pm.locality!
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                }
        })
        
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
                        let markers = GMSMarker()
                        
                        let lat1 = "\(latitudeCor)"
                        
                        let lng1 = "\(longitudeCor)"
                         self.getAddressFromLatLon(pdblLatitude: "\(latitudeCor)", withLongitude: "\(longitudeCor)")
                        markers.position = CLLocationCoordinate2D(latitude:CLLocationDegrees(lat1)!, longitude: CLLocationDegrees(lng1)!)
                        
                        markers.map = self.mapView
//                        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees("\(latitudeCor)")!, longitude: CLLocationDegrees("\(longitudeCor)")!, zoom: 6.0)
//
//                        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//                        print(self.locationLat)
                        
                        IJProgressView.shared.hideProgressView()
                        
                    }
                }
                
                
            })
            
            
            operation.start()
            
        }
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    

    @IBAction func filterBtnTap(_ sender: Any) {
        if(filterTap == false)
        {
            filterTap = true
            filterTbl.isHidden = false
            filterTbl.reloadData()
        }
            
        else
        {
            filterTap = false
            filterTbl.isHidden = true
        }
    }

    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == filterTbl)
        {
            return filterTblArr.count
        }
        else
        {
        return carInfoget2.count
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        present(autocompleteController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if(tableView == filterTbl)
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! carz4hireTableViewCell
        
        cell.filterType.text  = filterTblArr[indexPath.row] as! String
        cell.selectionStyle = .none;
        return cell
        
        }
        else
    {
        let getType = carInfoget2.object(at: indexPath.row) as! NSDictionary
        
        
        //    carInfoget2.removeAllObjects()
      
  

    
            tableView.rowHeight = 146
            let cell = tableView.dequeueReusableCell(withIdentifier: "celldetailmini", for: indexPath) as! carz4hireTableViewCell
            cell.cartitlename.text = getType.value(forKey:"title") as! String
            let getcartypes = getType.value(forKey:"type") as? String

     
            let getc = getcartypes?.uppercased()
        
            cell.economy.text = getc
        
            cell.age.text =  "\(getType.value(forKey:"total_passengers")!) Passengers"
        
            cell.locationlist.text = getType.value(forKey:"location") as! String
        
            cell.payment.text = getType.value(forKey:"payment_type") as! String
        
            let getcompanyLogo =  getType.value(forKey:"company_logo")  as! String
            let stringAppend = "http://carz4hire.com/companylogo/"
            
            let imageCompany = "\(stringAppend)\(getcompanyLogo)"
            let fileUrl = NSURL(string: imageCompany)
            cell.companyLogo.setImageWith(fileUrl as! URL)
            if(!(getType.value(forKey:"default_bus") is NSNull))
            {
                let getcarLogo =  getType.value(forKey:"default_bus")  as! String
                let stringAppend2 = "http://carz4hire.com/busimages/"
                
                let imagecar = "\(stringAppend2)\(getcarLogo)"
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
                cell.carImage.setImageWith(fileUrl1! as URL)
                
            }
            return cell
            
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == filterTbl)
        {
            if(filterTblArr[indexPath.row] == "Filter by")
            {
                filterTxt.text = ""
            }
            else
            {
            filterTxt.text = filterTblArr[indexPath.row] as! String
            }
            filterTbl.isHidden = true
            filterTap = false
            searchCars()
        }
        else
        {
            let getType = carInfoget2.object(at: indexPath.row) as! NSDictionary
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "busdetails") as! detailsViewController
            vc.getIdBus =  getType.value(forKey:"id") as! Int
            vc.typeList = "bus"
            userData.set(getType.value(forKey:"id"), forKey: "idget")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(tableView == tableView)
        {
            if(carInfoget2.count - 1 == indexPath.row){
                
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
    @IBAction func seeDeals(_ sender: Any) {
        if(searchTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Add some location", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
        self.searchCars()
        self.viewLocationf.isHidden = true
        }
    }
    func searchCars(){
          var param = [NSString: NSObject]()
       
          self.view3.isHidden = false
        IJProgressView.shared.showProgressView(view: self.view)
        
        // param ["user_email"]  = emailUser.text! as NSObject
        print(locationLat.value(forKey: "lat")!)
        print(locationLat.value(forKey: "lng")!)
        param = ["type":"minibus" as NSObject,"search_key":filterTxt.text! as NSObject,"latitude":locationLat.value(forKey: "lat")! as! NSObject,"longitude":locationLat.value(forKey: "lng")! as! NSObject,"city":cityNameMinibus] as! [NSString : NSObject]
        
  
       connection.startConnectionWithSting2(getUrlString: "getallvehicle", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
        
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                        IJProgressView.shared.hideProgressView()
                        
                        let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                        
                        self.getcarsArr = getDataDict.value(forKey: "data") as! NSArray
                        
                        if(self.getcarsArr.count == 0)
                        {
                            self.tableView.isHidden = true
                            self.noVEhicle.isHidden = false

                            
                        }
                        else
                        {
                          
                            self.bb = receivedData.value(forKey: "data") as! NSDictionary
                            self.tableView.isHidden = false
                            self.noVEhicle.isHidden = true
                         
                            self.carInfoget2 = self.getcarsArr.mutableCopy() as! NSMutableArray
                        
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                            self.tableView.reloadData()
                            
                            if(self.getcarsArr.count > 0)
                            {
                                let index = IndexPath(row: 0, section: 0)
                                
                                // use your index number or Indexpath
                                self.tableView.scrollToRow(at: index,at: .top, animated: false)
                            }
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
    
    func searchCars2(){
        
        
         var param = [NSString: NSObject]()
        IJProgressView.shared.showProgressView(view: self.view)
        
        // param ["user_email"]  = emailUser.text! as NSObject
        
        let nextUrl = bb.value(forKey: "next_page_url") as! String
        var newUrl = nextUrl.components(separatedBy: "?")
        param = ["type":"minibus" as NSObject,"search_key":filterTxt.text! as NSObject,"latitude":locationLat.value(forKey: "lat") as! NSObject,"longitude":locationLat.value(forKey: "lng") as! NSObject,"city":cityNameMinibus] as! [NSString : NSObject]
        
        
        connection.startConnectionWithSting2(getUrlString: "getallvehicle?\(newUrl[1])" as NSString, method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
//        connection.startConnectionWithStringGetType2(getUrlString: "gethotoffers?\(newUrl[1])" as NSString, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                        IJProgressView.shared.hideProgressView()
                        
                        let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                        self.bb  = receivedData.value(forKey: "data") as! NSDictionary
                        
                        self.carInfoget3 = getDataDict.value(forKey: "data") as! NSArray
                        self.carInfoget2.addObjects(from: self.carInfoget3 as! [Any])
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
