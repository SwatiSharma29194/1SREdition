//
//  sendDetailsViewController.swift
//  Carz4Hire
//
//  Created by user on 3/12/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Stripe


class sendDetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STPAddCardViewControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    var imageTap = String()
    var driverArr = NSArray()
    var getCardData = NSMutableArray()
    @IBOutlet var previousCard: UIButton!
    @IBOutlet var addnewCard: UIButton!
    var payment = String()
    var connection = webservices()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    var driverID = Int()
    var saveToken = String()
    var fileName = String()
    var bookCars = String()
    var getDataCards = NSArray()
    @IBOutlet var insurancenumber: UITextField!
    var userData = UserDefaults()
    var fileNamesArr = NSMutableArray()
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var paymentview: UIView!
    @IBOutlet var insuranceView: UIView!
    var cardID = Int()
    var getDataDictGWt1 = NSDictionary()
    var saveImage = NSMutableArray()
    
    @IBOutlet var bookingC: UILabel!
    @IBOutlet var payView: UIView!
    @IBOutlet var driverTbl: UITableView!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cardVie: UIView!
    
    var getCurrencyRate = ""
    var currencyName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addnewCard.layer.cornerRadius = self.addnewCard.frame.size.height / 2
        getDrivers()
        addnewCard.clipsToBounds = true
        previousCard.layer.cornerRadius = self.previousCard.frame.size.height / 2
        
        getCurrencyRate = self.userData.value(forKey: "getCurrencyRate") as! String
        
        currencyName = self.userData.value(forKey: "saveCurrency") as! String
        
        if(payment == "payments")
        {
            paymentview.isHidden = false
        }
        else
        {
            paymentview.isHidden = false
            //            paymentview.isHidden = true
            //    insuranceView.layer.borderColor = UIColor.lightGray.cgColor
            //        insuranceView.layer.borderWidth = 1
            //
            //        insuranceView.layer.cornerRadius = 5
            //
            //        insuranceView.clipsToBounds = true
            
        }
        // Do any additional setup after loading th+e view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  (!(userData.value(forKey: "bookCharges") == nil))
        {
            if(!(self.userData.value(forKey: "getcompanyCost") == nil))
            {
                
                let bookingCarhes = userData.value(forKey: "bookCharges") as! Double
                
                bookingC.text = " Full payment of \(currencyName)\(bookingCarhes * Double(Float(self.getCurrencyRate)!)) will be debited from your account. \nNo payment will be due at rental desk."
                
            }
            else
            {
                let bookingCarhes = userData.value(forKey: "bookCharges") as! Double
                
                bookingC.text = "Only the reservation fee of \(currencyName)\(bookingCarhes  * Double(Float(self.getCurrencyRate)!)) will be debited from your account. \nRemaining balance will be payable at the rental desk."
                
            }
            
        }
    }
    @IBAction func ADDDRIVER(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "adddriver") as! adddriverViewController
        vc.getAdd = "adddriver"
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
                            self.payView.isHidden = true
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "No driver is added . Add new driver", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                
                                
                            }
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else
                        {
                            
                            //   self.payView.isHidden = false
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
        if(tableView == driverTbl)
        {
            return driverArr.count
            
        }
        else
        {
            return getCardData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == driverTbl)
        {
            let cell = driverTbl.dequeueReusableCell(withIdentifier: "driverView", for: indexPath) as! carz4hireTableViewCell
            let getDriverdetail = driverArr.object(at: indexPath.row) as! NSDictionary
            
            cell.namedriver.text = getDriverdetail.value(forKey: "first_name") as? String
            cell.locationdriver.text = getDriverdetail.value(forKey: "location") as! String
            
            cell.phonedriver.text = getDriverdetail.value(forKey: "phone_number") as! String
            
            cell.emaildriver.text = getDriverdetail.value(forKey: "email") as! String
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! carz4hireTableViewCell
            let getCardDetails = getCardData.object(at: indexPath.row) as! NSDictionary
            let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
            
            let getSources = getcards.value(forKey: "sources") as! NSDictionary
            
            let getdata = getSources.value(forKey: "data") as! NSArray
            let dataArray  = getdata.object(at: 0) as! NSDictionary
            
            cell.cardNumber.text = "*********\(dataArray.value(forKey: "last4")!)"
            cell.card_type.text = "\(dataArray.value(forKey: "brand")!)"
            
            return cell
        }
        
        
        
    }
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return getCardData.count
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! carz4hireTableViewCell
    //        let getCardDetails = getCardData.object(at: indexPath.row) as! NSDictionary
    //        let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
    //
    //        let getSources = getcards.value(forKey: "sources") as! NSDictionary
    //
    //        let getdata = getSources.value(forKey: "data") as! NSArray
    //        let dataArray  = getdata.object(at: 0) as! NSDictionary
    //
    //        cell.cardNumber.text = "*********\(dataArray.value(forKey: "last4")!)"
    //        cell.card_type.text = "\(dataArray.value(forKey: "brand")!)"
    //
    //        return cell
    //
    //    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == driverTbl)
        {
            payView.isHidden = false
            
            let getDriverdetail = driverArr.object(at: indexPath.row) as! NSDictionary
            
            let getID = getDriverdetail.value(forKey: "id") as? Int
            driverID = getID!
            userData.set(getID, forKey: "getIDs")
        }
            
        else
            
        {
            let getCardDetails = getCardData.object(at: indexPath.row) as! NSDictionary
            
            cardID = getCardDetails.value(forKey: "card_id") as! Int
        }
    }
    
    func getCards()
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
                        //    self.getCardData = self.getDataCards.mutableCopy() as! NSMutableArray
                        print("fdfdfd",self.getDataCards)
                        for i in 0..<self.getDataCards.count
                            
                        {
                            
                            let getCardDetails = self.getDataCards.object(at: i) as! NSDictionary
                            let getcards = getCardDetails.value(forKey: "card") as! NSDictionary
                            if(!(getcards.value(forKey: "sources") == nil))
                            {
                                
                                self.getCardData.add(self.getDataCards.object(at: i))
                                
                            }
                            
                            
                            
                        }
                        
                        print("fdfdfd",self.getCardData)
                        
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
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                            self.tableView.reloadData()
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
                    
                    self.getCards()
                    
                    
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
    @IBAction func usePreviousCard(_ sender: Any) {
        cardVie.isHidden = false
        getCards()
    }
    @IBAction func image3Tap(_ sender: Any) {
        imageTap = "3"
        let alertController = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Take Photo", style: .default, handler: { (action) -> Void in
            
            let ImagePicker = UIImagePickerController()
            ImagePicker.allowsEditing = true
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(ImagePicker, animated: true, completion: nil)
            
        })
        
        let  edit = UIAlertAction(title: "Upload from gallery", style: .default, handler: { (action) -> Void in
            
            
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            ImagePicker.allowsEditing = true
            self.present(ImagePicker, animated: true, completion: nil)
            
        })
        
        
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(deleteButton)
        
        alertController.addAction(edit)
        
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func image2Tap(_ sender: Any) {
        imageTap = "2"
        let alertController = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Take Photo", style: .default, handler: { (action) -> Void in
            
            let ImagePicker = UIImagePickerController()
            ImagePicker.allowsEditing = true
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(ImagePicker, animated: true, completion: nil)
            
            
        })
        
        
        
        let  edit = UIAlertAction(title: "Upload from gallery", style: .default, handler: { (action) -> Void in
            
            
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            ImagePicker.allowsEditing = true
            self.present(ImagePicker, animated: true, completion: nil)
            
        })
        
        
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(deleteButton)
        
        alertController.addAction(edit)
        
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func image1Tap(_ sender: UIButton) {
        imageTap = "1"
        let alertController = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Take Photo", style: .default, handler: { (action) -> Void in
            
            let ImagePicker = UIImagePickerController()
            ImagePicker.allowsEditing = true
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(ImagePicker, animated: true, completion: nil)
            
            
        })
        
        
        
        let  edit = UIAlertAction(title: "Upload from gallery", style: .default, handler: { (action) -> Void in
            
            
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            ImagePicker.allowsEditing = true
            self.present(ImagePicker, animated: true, completion: nil)
            
        })
        
        
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(deleteButton)
        
        alertController.addAction(edit)
        
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func randomStringWithLength (_ len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
            
        }
        
        return randomString
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let pickedImageEdited = info[UIImagePickerControllerEditedImage] as? UIImage ?? UIImage()
            if(imageTap == "3")
            {
                image3.image = pickedImageEdited
            }
            if(imageTap == "2")
            {
                image2.image = pickedImageEdited
            }
            if(imageTap == "1")
            {
                image1.image = pickedImageEdited
            }
            
        }
        else{
            
            print("Something went wrong")
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func submitBtn(_ sender: Any) {
        
        bookCars = "card"
        bookCar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCards(_ sender: Any) {
        cardVie.isHidden = true
        handleAddPaymentMethodButtonTapped()
    }
    
    @IBAction func submitbtnTap(_ sender: Any) {
        
        bookCars = "cards"
        if(image1.image == nil)
        {
            
            
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Please upload the front image of your licence", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                //  IJProgressView.shared.hideProgressView()
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        if(image2.image == nil)
        {
            
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Please upload the back image of your licence", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                //  IJProgressView.shared.hideProgressView()
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if(image3.image == nil)
        {
            
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Please upload the your address proof", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                //  IJProgressView.shared.hideProgressView()
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
            
        else{
            if(!(image1.image == nil && image1.image == nil && image1.image == nil))
            {
                let data = UIImageJPEGRepresentation(image1.image! , 0.5)! as NSData
                let data1 = UIImageJPEGRepresentation(image2.image! , 0.5)! as NSData
                let data2 = UIImageJPEGRepresentation(image3.image! , 0.5)! as NSData
                saveImage.add(data)
                saveImage.add(data1)
                saveImage.add(data2)
                for i in 0..<3
                {
                    print("dfdfdfd",i)
                    
                    fileName = randomStringWithLength(Int(arc4random_uniform(10)) + 1) as String
                    let getStr = "\(fileName).png"
                    fileNamesArr.add(getStr)
                }
            }
            self.userData.set("have", forKey: "licence")
            handleAddPaymentMethodButtonTapped()
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
    
    
    
    @IBAction func backbtntap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    // MARK: handleAddPaymentMethodButtonTapped
    func bookCar()
    {
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            
            var param = [NSString: NSObject]()
            getDataDictGWt1 =  userData.value(forKey: "getData") as! NSDictionary
            
            
            let dateStr = getDataDictGWt1.value(forKey: "fromDate1")
            
            let dateStr2 = getDataDictGWt1.value(forKey: "fromDate2")
            
            let timeStr = getDataDictGWt1.value(forKey: "fromtime1")
            
            let timeStr2 = getDataDictGWt1.value(forKey: "fromtime2")
            
            let getLocation = getDataDictGWt1.value(forKey: "location") as! String
            
            let encodedString = getLocation.encodeEmoji
            
            let compnycharges = userData.value(forKey: "compnyCharges") as! Double
            
            let bookingCarhes = userData.value(forKey: "bookCharges") as! Double
            
            let getCar_id = userData.value(forKey: "idget") as! Int
            var getIdQuote = Int()
            if(!(userData.value(forKey: "savequoteIdget") == nil))
                
                
            {
                getIdQuote = userData.value(forKey: "savequoteIdget") as! Int
            }
            else
            {
                getIdQuote = 0
            }
            
            var getHot = String()
            if(!(userData.value(forKey: "getcompanyCost") == nil))
            {
                getHot = "1"
            }
                
            else
            {
                getHot = ""
            }
            if(bookCars == "card")
            {
                param = ["car_id":getCar_id as NSObject,"from":"\(dateStr!) \(timeStr!)"  as NSObject,"to":"\(dateStr2!) \(timeStr2!)" as NSObject,"location":"\(encodedString!)" as NSObject,"amount":"\(bookingCarhes)" as NSObject,"card_id":"\(cardID)" as NSObject,"companycharges":"\(compnycharges)" as NSObject,"insurance_number":insurancenumber.text! as NSObject,"offer_status":getHot as NSObject,"driver_id":driverID as NSObject,"quote_id":getIdQuote as! NSObject,"currency_price":userData.value(forKey: "FinalPriceToShow") as! NSObject,"currency_reserved_price ":userData.value(forKey: "ReservePriceToShow") as! NSObject]
                
            }
            else{
                param = ["car_id":getCar_id as NSObject,"from":"\(dateStr!) \(timeStr!)"  as NSObject,"to":"\(dateStr2!) \(timeStr2!)" as NSObject,"location":"\(encodedString!)" as NSObject,"amount":"\(bookingCarhes)" as NSObject,"stripetoken":"\(saveToken)" as NSObject,"companycharges":"\(compnycharges)" as NSObject,"insurance_number":insurancenumber.text! as NSObject as NSObject,"offer_status":getHot as NSObject as NSObject,"driver_id":driverID as NSObject,"quote_id":getIdQuote as! NSObject ,"currency_price":userData.value(forKey: "FinalPriceToShow") as! NSObject,"currency_reserved_price ":userData.value(forKey: "ReservePriceToShow") as! NSObject]
            }
            
            print(param)
            //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
            
            print(param)
            
            IJProgressView.shared.showProgressView(view: self.view)
            connection.sendImagesArray(imageData: saveImage, fileName: fileNamesArr, imageparm: "images[]", getUrlString: "bookcar", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                //            connection.startConnectionWithSting2(getUrlString: "bookcar", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            
                            IJProgressView.shared.hideProgressView()
                            self.userData.removeObject(forKey: "getcompanyCost")
                            self.userData.removeObject(forKey: "saveQuotes")
                            self.userData.removeObject(forKey: "savequoteIdget")
                            self.userData.removeObject(forKey: "upcoming")
                            //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "thanksPage")
                            //                        self.navigationController?.pushViewController(vc!, animated: true)
                            
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Your car is booked", preferredStyle: .alert)
                            self.dismiss(animated: true)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "thanksPage")
                                
                                self.navigationController?.pushViewController(vc!, animated: false)
                                
                                
                                
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
                                self.dismiss(animated: true)
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
                        
                        self.bookCar()
                        
                        
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
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Login for book the car", preferredStyle: .alert)
            
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
    func handleAddPaymentMethodButtonTapped() {
        // Setup add card view controller
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        
        // Present add card view controller
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true)
    }
    
    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        // Dismiss add card view controller
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
        saveToken = String (describing: token)
        print(token)
        
        bookCar()
        
        //        submitTokenToBackend(token, completion: { (error: Error?) in
        //            if let error = error {
        //                // Show error in add card view controller
        //                completion(error)
        //            }
        //            else {
        //                // Notify add card view controller that token creation was handled successfully
        //                completion(nil)
        //
        //                // Dismiss add card view controller
        //                dismiss(animated: true)
        //            }
        //        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
