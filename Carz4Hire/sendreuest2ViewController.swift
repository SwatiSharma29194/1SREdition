//
//  sendreuest2ViewController.swift
//  Carz4Hire
//
//  Created by user on 5/8/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class sendreuest2ViewController: UIViewController {
    var connection = webservices()
    var userData = UserDefaults()
    var getTypeD = String()
    let validation:Validation = Validation.validationManager() as! Validation
    var message = String()
    
    @IBOutlet var emailview: UIView!
  
    @IBOutlet var specialRequestView: UIView!
    
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var returnDateTime: UIView!
    @IBOutlet var pickupDateTime: UIView!
    
    @IBOutlet var waitTimeView: UIView!
    @IBOutlet var dropoffAddress: UIView!
    @IBOutlet var returnReqview: UIView!
    @IBOutlet var addressPickup: UIView!
    
    @IBOutlet var submitb: UIButton!
    @IBOutlet var pickupAdressTxt: UITextField!
    @IBOutlet var pickuptimeTxt: UITextField!
    
    @IBOutlet var specialRequestText: UITextField!
    @IBOutlet var waittimeTxt: UITextField!
    @IBOutlet var returndatetimeTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var returnReqTxt: UITextField!
    @IBOutlet var dropoffAdressTxt: UITextField!
    
    @IBOutlet var backGround: UIImageView!
    var typeRequest = String()
    var pickerView = UIDatePicker()
  
    var toolBar = UIToolbar()
    var typePicker = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(getTypeD == "bus")
        {
          //
            self.backGround.image = UIImage(named: "imgpsh_fullsize.jpeg")
            typeRequest = "Minibus"
          
            
        }
        else
        {
              self.backGround.image = UIImage(named: "IMG_9184 copy.png")
             typeRequest = "Chauffer"
        
        }
        emailview.layer.cornerRadius = 5
        emailview.layer.borderColor = UIColor.white.cgColor
        emailview.clipsToBounds = true
        emailview.layer.borderWidth = 1
        
        pickupDateTime.layer.cornerRadius = 5
        pickupDateTime.layer.borderColor = UIColor.white.cgColor
        pickupDateTime.clipsToBounds = true
        pickupDateTime.layer.borderWidth = 1
        
        specialRequestView.layer.cornerRadius = 5
        specialRequestView.layer.borderColor = UIColor.white.cgColor
        specialRequestView.clipsToBounds = true
        specialRequestView.layer.borderWidth = 1
        
        waitTimeView.layer.cornerRadius = 5
        waitTimeView.layer.borderColor = UIColor.white.cgColor
        waitTimeView.clipsToBounds = true
        waitTimeView.layer.borderWidth = 1
        
        returnDateTime.layer.cornerRadius = 5
        returnDateTime.layer.borderColor = UIColor.white.cgColor
        returnDateTime.clipsToBounds = true
        returnDateTime.layer.borderWidth = 1
        
        returnReqview.layer.cornerRadius = 5
        returnReqview.layer.borderColor = UIColor.white.cgColor
        returnReqview.clipsToBounds = true
        returnReqview.layer.borderWidth = 1
        
        dropoffAddress.layer.cornerRadius = 5
        dropoffAddress.layer.borderColor = UIColor.white.cgColor
        dropoffAddress.clipsToBounds = true
        dropoffAddress.layer.borderWidth = 1
        
                addressPickup.layer.cornerRadius = 5
                addressPickup.layer.borderColor = UIColor.white.cgColor
                addressPickup.clipsToBounds = true
                addressPickup.layer.borderWidth = 1
        scrollview.frame = self.view.frame
        scrollview.contentSize.height = submitb.frame.size.height + submitb.frame.origin.y + 20
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTap(_ sender: Any) {0
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pickupDateBtnTap(_ sender: Any) {
        typePicker = "pickup"
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        dropDownList()
    }
    @IBAction func returnDateTimeTap(_ sender: Any) {
        
        typePicker = "return"
        
        pickerView.removeFromSuperview()
        
        toolBar.removeFromSuperview()
        
        dropDownList()
        
    }
    @IBAction func submitBtnTap(_ sender: Any) {
        if(pickupAdressTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the full address of pickup location", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(dropoffAdressTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the full address of dropoff location", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(returnReqTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the return required?", preferredStyle: .alert)
            
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
        else if(pickuptimeTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the pickup time", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(returndatetimeTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the return time", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else if(waittimeTxt.text == "")
        {
            let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Enter the wait time", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            self.sendRequest()
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action:#selector(sendRequestViewController.donePicker))
        
        //        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(JobRequestViewController.donePicker))
        
        doneButton.tintColor = UIColor.black
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action:#selector(sendRequestViewController.canclePicker))
        
        //        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(JobRequestViewController.canclePicker))
        //
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(pickerView)
        
        self.view.addSubview(toolBar)
        
        
        
        
        pickerView.datePickerMode = .dateAndTime
        
        
        
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
        
        //          dateFormatter.dateFormat = "dd/MM/yyyy"
        //        date.text = dateFormatter.string(from: sender.date)
        
        
        
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        if(typePicker == "pickup")
        {
            pickuptimeTxt.text = "\(dateFormatter.string(from: sender.date))"
        }
        else
        {
            returndatetimeTxt.text = "\(dateFormatter.string(from: sender.date))"
        }
        
        
        
        // weekday
        // dobTxt.text = dateFormatter.string(from: sender.date)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
func sendRequest()
{
    
    
    let getCar_id = userData.value(forKey:"idget")
        var param = [NSString: NSObject]()
    param = ["pickup_from":pickupAdressTxt.text! as! NSObject,"drop_at":dropoffAdressTxt.text! as NSObject,"returnrequest":returnReqTxt.text! as NSObject,"email":emailTxt.text! as! NSObject,"pickuptime":pickuptimeTxt.text! as! NSObject,"wait_time":waittimeTxt.text! as! NSObject,"specialrequest":specialRequestText.text! as! NSObject,"car_id":getCar_id as! NSObject,"droptime":returndatetimeTxt.text! as! NSObject,"type":typeRequest as! NSObject]
    //    param = ["user_password":passwo rdTxt.text! as NSObject,"device_id":udidPhone as NSObject,"device_type":"ios" as NSObject,"user_long":longi as NSObject,"user_lat":lati as NSObject]
    
    print(param)
    

        
        connection.startConnectionWithSting2(getUrlString: "savequoteforchauffer", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(((receivedData.value(forKey: "message") != nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        //   IJProgressView.shared.hideProgressView()
                        
                  
                        
                              self.message = "Our team will respond within 1 working day to provide you with a quotation. 1SR"
                  
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: self.message, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "booking")
                            
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
                    
                    self.sendRequest()
                    
                    
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
