//
//  adddriverViewController.swift
//  Carz4Hire
//
//  Created by user on 4/26/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import AVFoundation
class adddriverViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var getAdd = String()
    var id = Int()
    @IBOutlet var emailTxt: UITextField!
        var fileNamesArr = NSMutableArray()
        var fileNamesArr2 = NSMutableArray()
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var savechanges: UIButton!
    @IBOutlet var insurance_number: UITextField!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var titleTxt: UITextField!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var locationTxt: UITextField!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var nameTxt: UITextField!
    var userData = UserDefaults()
    var connection = webservices()
    var imageTap = String()
    var message = ""
       var getDataArr = NSMutableArray()
     var getDataArr2 = NSMutableArray()
     var fileName = String()
  var namet =  String()
    var titleT = String()
     var locationT =  String()
     var phoneT =  String()
     var emailT =  String()
     var imageget1 =  String()
     var imageget2 =  String()
      var imageget3 =  String()
        var insuranceN =  String()

    override func viewDidLoad() {
        super.viewDidLoad()
        if((getAdd == "adddriver") || getAdd == "adddriver2")
        {
            titleTxt.text = ""
            nameTxt.text = ""
            phoneTxt.text = ""
            locationTxt.text = ""
            emailTxt.text = ""
            insurance_number.text = ""
            image1.image = UIImage(named:"driving-license.png")
             image2.image = UIImage(named:"driving-license.png")
             image3.image = UIImage(named:"driving-license.png")
        }
        
        else
        {
            titleTxt.text = titleT
            nameTxt.text = namet
            phoneTxt.text = phoneT
            locationTxt.text = locationT
            emailTxt.text = emailT
            insurance_number.text = insuranceN
            let imageLicence = "http://carz4hire.com/documentproofs/"
            self.image1.setImageWith(NSURL(string:"\(imageLicence)\(imageget1)") as! URL)
            self.image2.setImageWith(NSURL(string:"\(imageLicence)\(imageget2)") as! URL)
            self.image3.setImageWith(NSURL(string:"\(imageLicence)\(imageget3)") as! URL)
//            image2.image = UIImage(named:"\(imageLicence)\(imageget2)")
//            image3.image = UIImage(named:"\(imageLicence)\(imageget3)")
        }
//   scro.0llView.contentSize = CGSize(width: self.view.frame.size.width, height: savechanges.frame.origin.y + savechanges.frame.size.height + 10 + scrollView.frame.size.height - savechanges.frame.origin.y + savechanges.frame.size.height + 20)
        //scrollView.frame = self.view.frame
        scrollView.contentSize.height = savechanges.frame.origin.y + savechanges.frame.size.height + 10
        
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
            // Already Authorized
        } else {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    
                 
                    // User granted
                } else {
                    let locationAlert = UIAlertController(title: "1 STOP RENTALS", message: "Camera is not enabled. Do you want to go to settings menu?", preferredStyle: UIAlertControllerStyle.alert)
                    
                    locationAlert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                        
                        UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
                        
                    }))
                    
                    locationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in}))
                    
                    self.present(locationAlert, animated: true, completion: nil)
                    // User Rejected
                }
            })
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func saveChanges(){
        
        // param ["user_email"]  = emailUser.text! as NSObject
        var param = [NSString: NSObject](  )
        
        
        
        
        if(!(image1.image == nil && image1.image == nil && image1.image == nil))
        {
            let data = UIImageJPEGRepresentation(image1.image! , 0.5)! as NSData
            let data1 = UIImageJPEGRepresentation(image2.image! , 0.5)! as NSData
            let data2 = UIImageJPEGRepresentation(image3.image! , 0.5)! as NSData
            getDataArr2.add(data)
            getDataArr2.add(data1)
            getDataArr2.add(data2)
            print("getDataArr",getDataArr2.count)
            
            // param ["user_email"]  = emailUser.text! as NSObject
            for i in 0..<3
            {
                print("dfdfdfd",i)
                
                fileName = randomStringWithLength(Int(arc4random_uniform(10)) + 1) as String
                let getStr = "\(fileName).png"
                fileNamesArr2.add(getStr)
            }
            print("fileName",fileName)
            
            print("fileName",fileNamesArr2.count)
        }
        
        if((image1.image == nil && image1.image == nil && image1.image == nil))
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Add the back and front picture of licence . Also add your address proof", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                IJProgressView.shared.hideProgressView()
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
            
        else{
            
            IJProgressView.shared.showProgressView(view: self.view)
            param = ["email":emailTxt.text! as NSObject,"first_name":nameTxt.text! as NSObject,"title":titleTxt.text! as NSObject,"phone_number":phoneTxt.text! as! NSObject,"location":locationTxt.text! as! NSObject,"insurance_number":insurance_number.text! as! NSObject,"id":id as! NSObject]
            
            print(param)
            //connection.startConnectionWithSting2(getUrlString: "updateprofile", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            connection.sendImagesArray(imageData: getDataArr2, fileName: fileNamesArr2, imageparm: "images[]", getUrlString: "addeditdriver", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
                            
                            self.userData.set("have", forKey: "licence")
                            IJProgressView.shared.hideProgressView()
                            let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                            self.emailTxt.text = getDataDict.value(forKey: "email") as! String
                            self.titleTxt.text = getDataDict.value(forKey: "title") as! String
                            self.nameTxt.text = getDataDict.value(forKey: "first_name") as! String
                            self.phoneTxt.text = getDataDict.value(forKey: "phone_number") as! String
                            self.locationTxt.text = getDataDict.value(forKey: "location") as! String
                            self.insurance_number.text = getDataDict.value(forKey: "insurance_number") as! String
                            let getimage1 = "http://carz4hire.com/documentproofs/"
                            let geti1 = getDataDict.value(forKey: "licence_front") as! String
                            let geti2 = getDataDict.value(forKey: "licence_back") as! String
                            let geti3 = getDataDict.value(forKey: "address_proof") as! String
                            self.image1.setImageWith(NSURL(string:"\(getimage1)\(geti1)")! as URL)
                            self.image2.setImageWith(NSURL(string:"\(getimage1)\(geti2)") as! URL)
                            self.image3.setImageWith(NSURL(string:"\(getimage1)\(geti3)") as! URL)
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Driver Profile updated", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                                if(self.getAdd == "adddriver")
                                {
//                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendDetails")
//
//                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                              else  if(self.getAdd == "adddriver2")
                                {
                                                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "myaccount")
                                    
                                                                        self.navigationController?.pushViewController(vc!, animated: true)
                                }
                                else  if(self.getAdd == "adddriver0")
                                {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "myaccount")
                                    
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                                    
                                else
                                {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendDetails")
                                    
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                                
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
                    else{
                        
                        
                        
                        
                        
                        //  print(message)
                        
                        
                        
                        
                    }
                    
                }
                else{
                    
                    print(receivedData)
                    
                    
                    let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.saveChanges()
                        
                        
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
    
    func addDriver(){
        
        // param ["user_email"]  = emailUser.text! as NSObject
        var param = [NSString: NSObject]()
        
        
        if(!(image1.image == nil && image1.image == nil && image1.image == nil))
        {
            let data = UIImageJPEGRepresentation(image1.image! , 0.5)! as NSData
            let data1 = UIImageJPEGRepresentation(image2.image! , 0.5)! as NSData
            let data2 = UIImageJPEGRepresentation(image3.image! , 0.5)! as NSData
            getDataArr.add(data)
            getDataArr.add(data1)
            getDataArr.add(data2)
            print("getDataArr",getDataArr.count)
            
            // param ["user_email"]  = emailUser.text! as NSObject
            for i in 0..<3
            {
                print("dfdfdfd",i)
                
                fileName = randomStringWithLength(Int(arc4random_uniform(10)) + 1) as String
                let getStr = "\(fileName).png"
                fileNamesArr.add(getStr)
            }
            print("fileName",fileName)
            
            print("fileName",fileNamesArr.count)
        }
        
        if((image1.image == nil && image1.image == nil && image1.image == nil))
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Add the back and front picture of licence . Also add your address proof", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                IJProgressView.shared.hideProgressView()
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
            
        else{
            
            IJProgressView.shared.showProgressView(view: self.view)
            param = ["email":emailTxt.text! as NSObject,"first_name":nameTxt.text! as NSObject,"title":titleTxt.text! as NSObject,"phone_number":phoneTxt.text! as! NSObject,"location":locationTxt.text! as! NSObject,"insurance_number":insurance_number.text! as! NSObject]
            
            print(param)
            //connection.startConnectionWithSting2(getUrlString: "updateprofile", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
    
            connection.sendImagesArray(imageData: getDataArr, fileName: fileNamesArr, imageparm: "images[]", getUrlString: "addeditdriver", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
                
                if (self.connection.responseCode == 1){
                    
                    print(receivedData)
                    
                    if(!((receivedData.value(forKey: "message") == nil)))
                    {
                        if(receivedData.value(forKey: "message") as! String == "success")
                        {
//                            self.fileNamesArr.removeAllObjects()
//                            self.getDataArr.removeAllObjects()
                            
                            IJProgressView.shared.hideProgressView()
                            let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
//                            self.emailTxt.text = getDataDict.value(forKey: "email") as! String
//                            self.titleTxt.text = getDataDict.value(forKey: "title") as! String
//                            self.nameTxt.text = getDataDict.value(forKey: "first_name") as! String
//                            self.phoneTxt.text = getDataDict.value(forKey: "phone_number") as! String
//                            self.locationTxt.text = getDataDict.value(forKey: "location") as! String
//                            self.insurance_number.text = getDataDict.value(forKey: "insurance_number") as! String
//                            let getimage1 = "http://carz4hire.com/documentproofs/"
//                            let geti1 = getDataDict.value(forKey: "licence_front") as! String
//                            let geti2 = getDataDict.value(forKey: "licence_back") as! String
//                            let geti3 = getDataDict.value(forKey: "address_proof") as! String
//                            self.image1.setImageWith(NSURL(string:"\(getimage1)\(geti1)")! as URL)
//                            self.image2.setImageWith(NSURL(string:"\(getimage1)\(geti2)") as! URL)
//                            self.image3.setImageWith(NSURL(string:"\(getimage1)\(geti3)") as! URL)
                            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Driver added", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
//                               self.navigationController?.popViewController(animated: true)
                                    if(self.getAdd == "adddriver")
                                    {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendDetails")

                                self.navigationController?.pushViewController(vc!, animated: true)
                                }
                              else  if(self.getAdd == "adddriver2")
                                {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "myaccount")
                                    
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                                else
                                    {
                                        
                                }
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
                    else{
                        
                        
                        
                        
                        
                        //  print(message)
                        
                        
                        
                        
                    }
                    
                }
                else{
                    
                    print(receivedData)
                    
                    
                    let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        IJProgressView.shared.hideProgressView()
                        
                        self.addDriver()
                        
                        
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
    func getAccountDetails(){
        
        // param ["user_email"]  = emailUser.text! as NSObject
        
        
        IJProgressView.shared.showProgressView(view: self.view)
        
        
        connection.startConnectionWithStringGetType2(getUrlString: "getuserdetails", outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(!((receivedData.value(forKey: "message") == nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        IJProgressView.shared.hideProgressView()
                        let getDataDict = receivedData.value(forKey: "data") as! NSDictionary
                        self.emailTxt.text = getDataDict.value(forKey: "email") as! String
                        self.titleTxt.text = getDataDict.value(forKey: "title") as! String
                        self.nameTxt.text = getDataDict.value(forKey: "first_name") as! String
                        self.phoneTxt.text = getDataDict.value(forKey: "phone_number") as! String
                        self.locationTxt.text = getDataDict.value(forKey: "location") as! String
                        
                        self.insurance_number.text = getDataDict.value(forKey: "insurance_number") as! String
                        let getimage1 = "http://carz4hire.com/documentproofs/"
                        let geti1 = getDataDict.value(forKey: "licence_front") as! String
                        let geti2 = getDataDict.value(forKey: "licence_back") as! String
                        let geti3 = getDataDict.value(forKey: "address_proof") as! String
                        
                        self.image1.setImageWith(NSURL(string:"\(getimage1)\(geti1)")! as URL)
                        self.image2.setImageWith(NSURL(string:"\(getimage1)\(geti2)") as! URL)
                        self.image3.setImageWith(NSURL(string:"\(getimage1)\(geti3)") as! URL)
                        
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
                    
                    
                    
                    
                }
                
            }
            else{
                
                print(receivedData)
                
                
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    IJProgressView.shared.hideProgressView()
                    
                    self.getAccountDetails()
                    
                    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func image3Tap(_ sender: Any) {
        imageTap = "3"
       
        let alertController = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Take Photo", style: .default, handler: { (action) -> Void in
       
            if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
                
                let ImagePicker = UIImagePickerController()
                ImagePicker.allowsEditing = true
                ImagePicker.delegate = self
                ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
                
                self.present(ImagePicker, animated: true, completion: nil)
                
            } else {
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                        
                        let ImagePicker = UIImagePickerController()
                        ImagePicker.allowsEditing = true
                        ImagePicker.delegate = self
                        ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
                        
                        self.present(ImagePicker, animated: true, completion: nil)
                        // User granted
                    } else {
                        let locationAlert = UIAlertController(title: "1 STOP RENTALS", message: "Camera is not enabled. Do you want to go to settings menu?", preferredStyle: UIAlertControllerStyle.alert)
                        
                        locationAlert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                            
                            UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
                            
                        }))
                        
                        locationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in}))
                        
                        self.present(locationAlert, animated: true, completion: nil)
                        // User Rejected
                    }
                })
            }
            
            
            
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
            if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
                
                let ImagePicker = UIImagePickerController()
                ImagePicker.allowsEditing = true
                ImagePicker.delegate = self
                ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
                
                self.present(ImagePicker, animated: true, completion: nil)
                
            } else {
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                        
                        let ImagePicker = UIImagePickerController()
                        ImagePicker.allowsEditing = true
                        ImagePicker.delegate = self
                        ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
                        
                        self.present(ImagePicker, animated: true, completion: nil)
                        // User granted
                    } else {
                        let locationAlert = UIAlertController(title: "1 STOP RENTALS", message: "Camera is not enabled. Do you want to go to settings menu?", preferredStyle: UIAlertControllerStyle.alert)
                        
                        locationAlert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                            
                            UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
                            
                        }))
                        
                        locationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in}))
                        
                        self.present(locationAlert, animated: true, completion: nil)
                        // User Rejected
                    }
                })
            }
            
            
            
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
            if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
                
                let ImagePicker = UIImagePickerController()
                ImagePicker.allowsEditing = true
                ImagePicker.delegate = self
                ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
                
                self.present(ImagePicker, animated: true, completion: nil)
                
            } else {
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                        
                        let ImagePicker = UIImagePickerController()
                        ImagePicker.allowsEditing = true
                        ImagePicker.delegate = self
                        ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
                        
                        self.present(ImagePicker, animated: true, completion: nil)
                        // User granted
                    } else {
                        let locationAlert = UIAlertController(title: "1 STOP RENTALS", message: "Camera is not enabled. Do you want to go to settings menu?", preferredStyle: UIAlertControllerStyle.alert)
                        
                        locationAlert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                            
                            UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
                            
                        }))
                        
                        locationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in}))
                        
                        self.present(locationAlert, animated: true, completion: nil)
                        // User Rejected
                    }
                })
            }
           
            
            
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
    
    @IBAction func savechanges(_ sender: Any) {
        
         if(getAdd == "adddriver" || getAdd == "adddriver2")
         {
            if(titleTxt.text == "")
            {

                
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the title", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
           else if(nameTxt.text == "")
            {
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the name", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else if(emailTxt.text == "")
            {
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the email", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else if(phoneTxt.text == "")
            {
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the phone", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            else if(locationTxt.text == "")
            {
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the location", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            else if(insurance_number.text == "")
            {
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the insurance number", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
            addDriver()
            }
        }
        else
         {
        saveChanges()
        }
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
