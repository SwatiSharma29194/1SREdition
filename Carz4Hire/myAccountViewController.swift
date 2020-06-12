//
//  myAccountViewController.swift
//  Carz4Hire
//
//  Created by user on 3/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class myAccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var paymentView: UIView!
    var userData = UserDefaults()
    let connection = webservices()
    var message = ""
    var getidDelete = Int()
var driverArr = NSArray()
 
    var scroll2 = UIScrollView()
  
        var getDataCards = NSArray()

    @IBOutlet var accountView: UIView!
    @IBOutlet var segmentC: UISegmentedControl!
    @IBOutlet var paymentTbl: UITableView!
   var getTypeSeg = String()
    var fileNamesArr = NSMutableArray()
 
    @IBOutlet var driverTbl: UITableView!

   
    @IBOutlet var driverView: UIView!
    var imageTap = String()
    var getCardData = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        driverView.isHidden = true
        paymentView.isHidden = true
            accountView.isHidden = false
        paymentTbl.delegate = self
        paymentTbl.dataSource = self
        driverTbl.delegate = self
        driverTbl.dataSource = self
        if(!(userData.value(forKey: "getTypeSeg") == nil))
        {
        if(userData.value(forKey: "getTypeSeg")as! String == "card")
        {
            driverView.isHidden = true
            paymentView.isHidden = false
            accountView.isHidden = true
            segmentC.selectedSegmentIndex = 2
            getCardsS()
        }
            
           else if(userData.value(forKey: "getTypeSeg")as! String == "DriverAdd")
            {
                driverView.isHidden = false
                paymentView.isHidden = true
                accountView.isHidden = true
                segmentC.selectedSegmentIndex = 1
                getDrivers()
            }
        }
            
       
        
        else{
            driverView.isHidden = true
            paymentView.isHidden = true
            accountView.isHidden = false
             segmentC.selectedSegmentIndex = 0
        }
  //   scrollView.frame.size = self.view.frame.size
//        viewMessage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: savechanges.frame.size.height + savechanges.frame.origin.y + 20)

//print(self.viewMessage.frame.size.height + self.viewMessage.frame.origin.y)
    


        
       
        // Do any additional setup after loading the view.
    }
    func getCardsS()
    {
        
        
        
        IJProgressView.shared.showProgressView(view: self.view)
        connection.startConnectionWithStringGetType2(getUrlString: "getcards", outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.getDataCards = receivedData.value(forKey: "data") as! NSArray
                        
                  //self.getCardData = self.getDataCards.mutableCopy() as! NSMutableArray
                        
                        
                        print("fdfdfd",self.getDataCards.count)
                        
                        for i in 0..<self.getDataCards.count
                            
                        {
                            
                            let getCardDetails = self.getDataCards.object(at: i) as! NSDictionary
                            let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
                            if(!(getcards.value(forKey: "sources") == nil))
                            {
                                
                                self.getCardData.add(self.getDataCards.object(at: i))
                                
                            }
                            
                            
                           
                        }
                        
                        print("fdfdfd",self.getCardData.count)
                        
                        if(self.getCardData.count == 0)
                        {
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "No card is added . Add new card", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                
                                
                            }
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else
                        {
                            self.paymentTbl.delegate = self
                            self.paymentTbl.dataSource = self
                            self.paymentTbl.reloadData()
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
                    
                    self.getCardsS()
                    
                    
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
    @IBAction func myBookingsBtnTap(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mybookings") as! mybookingsViewController
        
       vc.bookTap = "Yes"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDrivers()
    {
        
        
        
        IJProgressView.shared.showProgressView(view: self.view)
        connection.startConnectionWithStringGetType2(getUrlString: "getdriverdetails", outputBlock: { (receivedData) in
       
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.driverArr = receivedData.value(forKey: "data") as! NSArray
                        
                        //self.getCardData = self.getDataCards.mutableCopy() as! NSMutableArray

                        
                        print("fdfdfd",self.driverArr.count)
                        
                    
                        
                        if(self.driverArr.count == 0)
                        {
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "No driver is added . Add new driver", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                
                                
                            }
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else
                        {
                            self.driverTbl.delegate = self
                            self.driverTbl.dataSource = self
                            self.driverTbl.reloadData()
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
                    
                    self.getDrivers()
                    
                    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == paymentTbl)
        {
        return getCardData.count
        }
        else
        {
            return driverArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   if(tableView == paymentTbl)
   {
        let cell = paymentTbl.dequeueReusableCell(withIdentifier: "paymentTbl", for: indexPath) as! carz4hireTableViewCell
        let getCardDetails = getCardData.object(at: indexPath.row) as! NSDictionary
        let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
  
        let getSources = getcards.value(forKey: "sources") as! NSDictionary
        
        let getdata = getSources.value(forKey: "data") as! NSArray
        let dataArray  = getdata.object(at: 0) as! NSDictionary
        
        cell.cardnumberpayment.text = "*********\(dataArray.value(forKey: "last4")!)"
        cell.cardTypePayment.text = "\(dataArray.value(forKey: "brand")!)"
        if(!(dataArray.value(forKey: "name") is NSNull))
        {
           cell.nameCardHolder.text = "\(dataArray.value(forKey: "name")!)"
        }
        else{
             cell.nameCardHolder.text = ""
        }
           cell.expirydatePayment.text = "\(dataArray.value(forKey: "exp_year")!)"
        return cell
        }
        
        else
   {
    let cell = driverTbl.dequeueReusableCell(withIdentifier: "driverView", for: indexPath) as! carz4hireTableViewCell
    let getDriverdetail = driverArr.object(at: indexPath.row) as! NSDictionary
    cell.deleteDriver.tag = indexPath.row
    cell.deleteDriver.addTarget(self, action: #selector(self.deleteBtn), for: .touchUpInside)
    cell.namedriver.text = getDriverdetail.value(forKey: "first_name") as? String
    cell.locationdriver.text = getDriverdetail.value(forKey: "location") as! String
    
        cell.phonedriver.text = getDriverdetail.value(forKey: "phone_number") as! String
    
        cell.emaildriver.text = getDriverdetail.value(forKey: "email") as! String
    
    
//    let getCardDetails = getCardData.object(at: indexPath.row) as! NSDictionary
//    let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
//
//    let getSources = getcards.value(forKey: "sources") as! NSDictionary
//
//    let getdata = getSources.value(forKey: "data") as! NSArray
//    let dataArray  = getdata.object(at: 0) as! NSDictionary
//
//    cell.cardnumberpayment.text = "*********\(dataArray.value(forKey: "last4")!)"
//    cell.cardTypePayment.text = "\(dataArray.value(forKey: "brand")!)"
//    if(!(dataArray.value(forKey: "name") is NSNull))
//    {
//        cell.nameCardHolder.text = "\(dataArray.value(forKey: "name")!)"
//    }
//    else{
//        cell.nameCardHolder.text = ""
//    }
//    cell.expirydatePayment.text = "\(dataArray.value(forKey: "exp_year")!)"
    return cell
        }
    }
    





    @IBAction func backBtnTap(_ sender: Any) {
        
       // self.navigationController?.popViewController(animated: false)
    }

    @IBAction func tapSeg(_ sender: UISegmentedControl) {
        
        if(segmentC.selectedSegmentIndex == 0)
        
        {
            driverView.isHidden = true
            paymentView.isHidden = true
            accountView.isHidden = false
        }
        else if(segmentC.selectedSegmentIndex == 1)
        {
          
       getDrivers()
            
            driverView.isHidden = false
            paymentView.isHidden = true
             accountView.isHidden = true
        }
        else{
            driverView.isHidden = true
            paymentView.isHidden = false
            accountView.isHidden = true
            
            getCardsS()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func deleteBtn(sender:UIButton){
        
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
           let getDriverdetail = driverArr.object(at: indexPath.row) as! NSDictionary
     
        // let getReceiverInfo = getOb.value(forKey:"receiverinfo") as! NSDictionary
        
        getidDelete = getDriverdetail.value(forKey:"id") as! Int
        
        deleteDrivers()
    }
    func deleteDrivers()
    {
        IJProgressView.shared.showProgressView(view: self.view)
        
        var param = [NSString: NSObject]()
        
        
        param = ["id":getidDelete as NSObject]
        
        IJProgressView.shared.showProgressView(view: self.view)
        //   connection.startConnectionWithStringGetType2(getUrlString: "getallquotes", outputBlock: { (receivedData) in
        connection.startConnectionWithSting2(getUrlString: "deletedriver", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
           
            //        connection.startConnectionWithStringGetType2(getUrlString: "deletequote" as NSString, outputBlock: { (receivedData) in
            if (self.connection.responseCode == 1){
                print(receivedData)
                if(!(receivedData.value(forKey: "message") == nil))
                {
                    if(receivedData.value(forKey: "message") as! String == "Success")
                    {
                        IJProgressView.shared.hideProgressView()
                        //     let getDict = receivedData.value(forKey: "data") as! NSDictionary
                        self.getDrivers()
                        
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
                    
                    self.deleteDrivers()
                    
                    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == paymentTbl)
        {
            
            let getCardDetails = getCardData.object(at: indexPath.row) as! NSDictionary
            let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
            
            let getSources = getcards.value(forKey: "sources") as! NSDictionary
            
            let getdata = getSources.value(forKey: "data") as! NSArray
            let dataArray  = getdata.object(at: 0) as! NSDictionary
            var getcardnumber = String()
            var getcardtype = String()
            var getname = String()
            var getexpyear = String()
            if(!(dataArray.value(forKey: "last4") is NSNull))
            {
             getcardnumber = "*********\(dataArray.value(forKey: "last4")!)"
            }
            else
            {
                 getcardnumber = ""
            }
            if(!(dataArray.value(forKey: "brand") is NSNull))
            {
                getcardtype = "\(dataArray.value(forKey: "brand")!)"
            }
            else
            {
                getcardtype = ""
            }
            if(!(dataArray.value(forKey: "name") is NSNull))
            {
                getname = "*********\(dataArray.value(forKey: "name")!)"
            }
            else
            {
                getname = ""
            }
   
            if(!(dataArray.value(forKey: "exp_year") is NSNull))
            {
                getexpyear = "\(dataArray.value(forKey: "exp_year")!)"
            }
            else
            {
                getexpyear = ""
            }
         let getcardId = getCardDetails.value(forKey: "card_id") as! Int
            
            let getDict:NSDictionary  = ["getcardnumber":getcardnumber,"getcardtype":getcardtype,"getname":getname,"getexpyear":getexpyear,"getcardId":getcardId]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cardDetails") as! cardDetailsViewController
            
            vc.getDictc = getDict
        
        self.navigationController?.pushViewController(vc, animated: false)
        }
        
        else{
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "adddriver") as! adddriverViewController
          
                     vc.getAdd = "adddriver0"
            
            let getDriverdetail = driverArr.object(at: indexPath.row) as! NSDictionary
            
            vc.namet = getDriverdetail.value(forKey: "first_name") as! String
             vc.locationT = getDriverdetail.value(forKey: "location") as! String
            
            vc.phoneT = getDriverdetail.value(forKey: "phone_number") as! String
            
            vc.emailT = getDriverdetail.value(forKey: "email") as! String
            
            vc.titleT = getDriverdetail.value(forKey: "title") as! String
            
               vc.id = getDriverdetail.value(forKey: "id") as! Int
            
                 vc.imageget1 = getDriverdetail.value(forKey: "licence_front") as! String
            
                    vc.imageget2 = getDriverdetail.value(forKey: "licence_back") as! String
            vc.imageget3 = getDriverdetail.value(forKey: "address_proof") as! String
                        vc.insuranceN = getDriverdetail.value(forKey: "insurance_number") as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        if(tableView == driverTblView)
//        {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "driverDetails")
//
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
    }
    @IBAction func AddDriver(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "adddriver") as! adddriverViewController
        vc.getAdd = "adddriver2"

        userData.set("DriverAdd", forKey: "getTypeSeg")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fileNamesArr.removeAllObjects()
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
