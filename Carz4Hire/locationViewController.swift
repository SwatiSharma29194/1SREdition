//
//  locationViewController.swift
//  Carz4Hire
//
//  Created by user on 3/7/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import GoogleMaps
class locationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GMSMapViewDelegate {
    @IBOutlet var viewMap: UIView!
    var getData = NSDictionary()
    var mapView = GMSMapView()
       let marker = GMSMarker()
    var longitude_origin:Double = 43.54454
    var  latitudeArr = NSArray()
    
    @IBOutlet var closedeals: UIButton!
    @IBOutlet var alldelals: UIButton!
    var longitudeArr = NSArray()
    var latitude_origin:Double = 32.67766
    var lati = CLLocationDegrees()
    var longi = CLLocationDegrees()
    var userData = UserDefaults()
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(latitudeArr)
        closedeals.layer.cornerRadius = self.closedeals.frame.size.height / 2
        
        closedeals.clipsToBounds = true
        alldelals.layer.cornerRadius = self.alldelals.frame.size.height / 2
        
        alldelals.clipsToBounds = true
     
        closedeals.setTitle("See deals close to you in \(userData.value(forKey: "setCountry")!)", for: .normal)
        alldelals.setTitle("See all available deals in \(userData.value(forKey: "setCountry")!)", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func viewWillAppear(_ animated: Bool) {
        getData = userData.value(forKey: "getDictData") as! NSDictionary
if(!(userData.value(forKey: "getLatitudes")  == nil))
{
        latitudeArr = userData.value(forKey: "getLatitudes") as! NSArray
        }
        
        if(!(userData.value(forKey: "getLongitude") == nil))
        {
        longitudeArr = userData.value(forKey: "getLongitude") as! NSArray
        }
        userData.setValue(getData, forKey: "getData")
        print(getData)
        if(latitudeArr.count > 0)
        {
        let lat1 = latitudeArr.object(at: 0) as! String
        
        let lng1 = longitudeArr.object(at: 0) as! String
        
                let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat1)!, longitude: CLLocationDegrees(lng1)!, zoom: 6.0)
               mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        }
        else
        {
        let camera = GMSCameraPosition.camera(withLatitude: 55.3781, longitude: 3.4360, zoom: 5.0)
               mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        }
       
     
        
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewMap.frame.size.height)
        
        viewMap.addSubview(mapView)
        //  marker.position = CLLocationCoordinate2D(latitude:latitude_origin, longitude: longitude_origin)
        for i in 0..<latitudeArr.count {
            
            let markers = GMSMarker()
            
            let lat1 = latitudeArr.object(at: i) as! String
            
            let lng1 = longitudeArr.object(at: i) as! String
            
            markers.position = CLLocationCoordinate2D(latitude:CLLocationDegrees(lat1)!, longitude: CLLocationDegrees(lng1)!)
            
            //markers.icon = UIImage(named: "location-marker copy")
            // markers.title = originDestData.object(at: i) as! String
            
            
            markers.map = mapView
            
        }
        //        marker.icon = UIImage(named: "location-marker.png")
        let attr = NSDictionary(object: UIFont(name: "Lato-Medium", size: 12.0)!, forKey: NSFontAttributeName as NSCopying)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
        mapView.delegate = self
        mapView.settings.setAllGesturesEnabled(true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "cardDetail")
        
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeDeals(_ sender: Any) {
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailcar") as! detailcarViewController
        getData = userData.value(forKey: "getData") as! NSDictionary
        vc.getDataDict1 = getData
        print(vc.getDataDict1)
        vc.getTypeDeals = "close"
        userData.set("close", forKey: "close")
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func allDetails(_ sender: Any) {
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailcar") as! detailcarViewController
        getData = userData.value(forKey: "getData") as! NSDictionary
        vc.getDataDict1 = getData
        vc.getTypeDeals = "All"
        userData.set("All", forKey: "close")
        self.navigationController?.pushViewController(vc, animated: false)
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
