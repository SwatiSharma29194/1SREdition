//
//  carz4hireTableViewCell.swift
//  Carz4Hire
//
//  Created by user on 3/5/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class carz4hireTableViewCell: UITableViewCell {
    @IBOutlet var driver: UILabel!
    @IBOutlet var expirydatePayment: UILabel!
    
    @IBOutlet var phoneIconds: UIImageView!
    @IBOutlet var filterType: UILabel!
    @IBOutlet var validDate: UILabel!
    @IBOutlet var locationdriver: UILabel!
    @IBOutlet var emaildriver: UILabel!
    @IBOutlet var phonedriver: UILabel!
    @IBOutlet var namedriver: UILabel!
    @IBOutlet var cardnumberpayment: UILabel!
    @IBOutlet var cardTypePayment: UILabel!
    @IBOutlet var cardNumber: UILabel!
    @IBOutlet var nameCardHolder: UILabel!

    @IBOutlet var phoneIcon: UIImageView!
    
    @IBOutlet var deleteDriver: UIButton!
    @IBOutlet var card_type: UILabel!
    @IBOutlet var imagecarlist: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var locationgetlist: UILabel!
    @IBOutlet var companyLogo: UIImageView!
    @IBOutlet var carImage: UIImageView!
    @IBOutlet var redcarpet: UILabel!
    @IBOutlet var economy: UILabel!
    @IBOutlet var payment: UILabel!
    @IBOutlet var locationlist: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var moneyCar: UILabel!
    @IBOutlet var cartitlename: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var backImg: UIImageView!
    
    @IBOutlet var currencyName: UILabel!
    @IBOutlet var countryNameCurrency: UILabel!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn1: UIButton!
    var strBooking = String()
    var strReservation = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
