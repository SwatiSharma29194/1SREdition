//
//  sendRequestViewController.swift
//  Carz4Hire
//
//  Created by user on 5/8/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class sendRequestViewController: UIViewController {
    @IBOutlet var emailview: UIView!
    
    @IBOutlet var specialRequestView: UIView!
  
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
    
    var message = ""
    var pickerView = UIDatePicker()
    var userData = UserDefaults()
    var toolBar = UIToolbar()
    var typePicker = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        emailview.layer.cornerRadius = 5
        emailview.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        emailview.clipsToBounds = true
        emailview.layer.borderWidth = 1
        
        specialRequestView.layer.cornerRadius = 5
        specialRequestView.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        specialRequestView.clipsToBounds = true
        specialRequestView.layer.borderWidth = 1
        
        waitTimeView.layer.cornerRadius = 5
        waitTimeView.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        waitTimeView.clipsToBounds = true
        waitTimeView.layer.borderWidth = 1
        
        returnDateTime.layer.cornerRadius = 5
        returnDateTime.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        returnDateTime.clipsToBounds = true
        returnDateTime.layer.borderWidth = 1
        
        returnReqview.layer.cornerRadius = 5
        returnReqview.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        returnReqview.clipsToBounds = true
        returnReqview.layer.borderWidth = 1
        
        dropoffAddress.layer.cornerRadius = 5
        dropoffAddress.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
        dropoffAddress.clipsToBounds = true
        dropoffAddress.layer.borderWidth = 1
        
//        addressPickup.layer.cornerRadius = 5
//        addressPickup.layer.borderColor = UIColor(red:0.15, green:0.22, blue:0.27, alpha:1.0).cgColor
//        addressPickup.clipsToBounds = true
//        addressPickup.layer.borderWidth = 1
        
      
        // Do any additional setup after loading the view.
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
        
        

                dateFormatter.dateFormat = "hh:mm a"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
