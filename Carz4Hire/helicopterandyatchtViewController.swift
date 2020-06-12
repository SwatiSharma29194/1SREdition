//
//  helicopterandyatchtViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 19/11/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class helicopterandyatchtViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var getcarsArr = NSArray()
    var carInfoget2 = NSMutableArray()
    var bb = NSDictionary()
    var filterArr = ["Filter by","Helicopter","Yacht"]
    @IBOutlet var novehicle: UILabel!
    
    @IBOutlet var filterTxt: UITextField!
    @IBOutlet var filterTbl: UITableView!
    var carInfoget3 = NSArray()
    var connection = webservices()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    @IBOutlet var searchView: UIView!
    var filterTap = false
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 5
        searchView.clipsToBounds = true
        filterTbl.delegate = self
        filterTbl.dataSource = self
        self.searchCars()
        // Do any additional setup after loading the view.
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
    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == filterTbl)
        {
            return filterArr.count
        }
        else
        {
             return carInfoget2.count
        }
       
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == filterTbl)
        {
            if(filterArr[indexPath.row] == "Filter by")
            {
                filterTxt.text = ""
            }
            else
            {
                filterTxt.text = filterArr[indexPath.row] as! String
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
            vc.typeList = "helicopter"
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == filterTbl)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! carz4hireTableViewCell
            
            cell.filterType.text  = filterArr[indexPath.row] as! String
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
                let stringAppend2 = "http://carz4hire.com/helicopterimages/"
                
                let imagecar = "\(stringAppend2)\(getcarLogo)"
                let fileUrl1 = NSURL(string: imagecar)
                print("fileUrl1",fileUrl1)
                cell.carImage.setImageWith(fileUrl1! as URL)
                
            }
            return cell
        }
    
        
    }
    func searchCars(){
        var param = [NSString: NSObject]()
        
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        // param ["user_email"]  = emailUser.text! as NSObject
        param = ["type":"helicopter" as NSObject,"search_key":filterTxt.text! as NSObject]
        
        
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
                            self.novehicle.isHidden = false
                        }
                        else
                        {
                            self.tableView.isHidden = false
                            self.novehicle.isHidden = true
                        self.bb = receivedData.value(forKey: "data") as! NSDictionary
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
        
        
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        // param ["user_email"]  = emailUser.text! as NSObject
        
        let nextUrl = bb.value(forKey: "next_page_url") as! String
        var newUrl = nextUrl.components(separatedBy: "?")
            var param = [NSString: NSObject]()
        param = ["type":"helicopter" as NSObject,"search_key":filterTxt.text! as NSObject]
        
        
        connection.startConnectionWithSting2(getUrlString: "getallvehicle?\(newUrl[1])" as NSString, method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
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
