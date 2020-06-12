//
//  chooseCurrencyViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 28/02/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class chooseCurrencyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var userData = UserDefaults()
    @IBOutlet var tableView: UITableView!
//    var getcurrencyArr = ["ALL","DZD","FAF / ADP","AON","XCD","XCD","ARS","AMD","AWG","AUD","ATS","AZN","BSD","BHD","BBD","BYN","BEF (EURO)","BZD","XOF","BMD","BTN","BOB","BAM","BWP","BRL","US$","BND","BGN","XOF","BIF","KHR","CFA","CAD","CVE","KYD","CFA","CLP","CNY","COP","KMF","CDF","CDF","NZD","CRC"," XOF","HRK","CYP","CZK","DKK","DJF","DOP","DOP","ECS","EGP","SVC","ERN","EEK","birr","FKP","kr","FJD","FIM (EURO)","EURO","EURO","CFP","XAF","GMD","GMD","GEL","EURO","GIP","EURO","DKK","USD","USD","GTQ","POUND","GWP","GYD","HNL","CNY","HUF","ISK","INR","IDR","IED (EURO)","ILS","ITL (EURO)","JMD","JPY","JOD","KZT","KES","AU$.","KWD","KGS","LAK","LVL (EURO)","LSL","SDP","LTL (EURO)","LUF (EURO)","MKD","MGA","MWK","MYR","MVR","CFA","MTL","USD","FRF","MRO","MUR","EURO","MXN","USD","MDL","FRF","MNT","RSD","XCD","MAD","MZM","ZAR / NAD","AUD","NPR","NLG","XPF","NEW ZEALAND","NIO","XOF","NGN","NZD","AUD","NOK","OMR","USD","PAB / USD","PGK","PYG","PEN","PHP","NZD","PLZ","USD","QAR","ROL","RUB","RWF","WST","ITL","SSTD","SAR","XOF","RSD","SCR","SLL","SGD","SKK","SIT","SBD","SOS","ZAR","KRW","ESP","LKR","SHP","XCD","XCD","FRF","XCD","SRG","NOK","SZL","SEK","CHF","TWD","RUR","TZS","THB","XOF","TOP","TTD","TND","TMM","USD","AUD","UGX","UAK","AED","GBP","USD / US$","UYU","VUV","ITL","VES","VND","WF","YE","ZMZ","ZW ","dsds","sdsd"]
//
//
//    var getcountriesArr = ["ALBANIA","ALGERIA","ANDORRA","ANGOLA","ANGUILLA","ANTIGUA & BARBUDA","ARGENTINA","ARMENIA","ARUBA","AUSTRALIA","AUSTRIA","AZERBAIJAN","BAHAMAS","BAHRAIN","BARBADOS","BELARUS","BELGIUM","BELIZE","BENIN","BERMUDA","BHUTAN","BOLIVIA","BOSNIA & HERZEGOVINA","BOTSWANA","BRAZIL","BRITISH VIRGIN ISLANDS","BRUNEI","BULGARIA","BURKINA FASO","BURUNDI","CAMBODIA","CAMEROON","CANADA","CAPE VERDE","CAYMAN ISLANDS","CHAD","CHILE","CHINA","COLOMBIA","COMOROS","CONGO - BRAZZAVILLE","CONGO - KINSHASA","COOK ISLANDS","COSTA RICA"," CÔTE D’IVOIRE","CROATIA","CYPRUS","CZECH REPUBLIC","DENMARK","DJIBOUTI","DOMINICA","DOMINICAN REPUBLIC","ECUADOR","EGYPT","EL SALVADOR","EL SALVADOR","ERITREA","ESTONIA","ETHIOPIA","FALKLAND ISLANDS","FAROE ISLANDS","FIJI","FINLAND","FRANCE","FRENCH GUIANA","FRENCH POLYNESIA","GABON","GAMBIA","GEORGIA","GERMANY","GIBRALTAR","GREECE","GREENLAND","GRENADA","GUADELOUPE","GUATEMALA","GUINEA","GUINEA-BISSAU","GUYANA","HONDURAS","HONG KONG SAR CHINA","HUNGARY","ICELAND","INDIA","INDONESIA","IRELAND","ISRAEL","ITALY","JAMAICA","JAPAN","JORDAN","KAZAKHSTAN","KENYA","KIRIBATI","KUWAIT","KYRGYZSTAN","LAOS","LATVIA","LESOTHO","LIECHTENSTEIN","LITHUANIA","LUXEMBOURG","MACEDONIA","MADAGASCAR","MALAWI","MALAYSIA","MALDIVES","MALI","MALTA","MARSHALL ISLANDS","MARTINIQUE","MAURITANIA","MAURITIUS","MAYOTTE","MEXICO","MICRONESIA","MOLDOVA","MONACO","MONGOLIA","MONTENEGRO","MONTSERRAT","MOROCCO","MOZAMBIQUE","NAMIBIA","NAURU","NEPAL","NETHERLANDS","NEW CALEDONIA","NEW ZEALAND","NICARAGUA","NIGER","NIGERIA","NIUE","NORFOLK ISLAND","NORWAY","OMAN","PALAU","PANAMA","PAPUA NEW GUINEA","PARAGUAY","PERU","PHILIPPINES","PITCAIRN ISLANDS","POLAND","PORTUGAL","QATAR","RÉUNION","ROMANIA","RUSSIA","RWANDA","SAMOA","SAN MARINO","SÃO TOMÉ & PRÍNCIPE","SAUDI ARABIA","SENEGAL","SERBIA","SEYCHELLES","SIERRA LEONE","SINGAPORE","SLOVAKIA","SLOVENIA","SOLOMON ISLANDS","SOMALIA","SOUTH AFRICA","SOUTH KOREA","SPAIN","SRI LANKA","ST. HELENA","ST. KITTS & NEVIS","ST. LUCIA","ST. PIERRE & MIQUELON","ST. VINCENT & GRENADINES","SURINAME","SVALBARD & JAN MAYEN","SWAZILAND","SWEDEN","SWITZERLAND","SWEDEN","SWITZERLAND","TAIWAN","TAJIKISTAN","TANZANIA","THAILAND","TOGO","TONGA","TRINIDAD & TOBAGO","TUNISIA","TURKMENISTAN","TURKS & CAICOS ISLANDS","TUVALU","UGANDA","UKRAINE","UNITED ARAB EMIRATES","UNITED KINGDOM","UNITED STATES","URUGUAY","VANUATU","VATICAN CITY","VENEZUELA","VIETNAM","WALLIS & FUTUNA","YEMEN","ZAMBIA ","ZIMBABWE "]


    
  
//
//    ==============================================================
//    Australian dollar (AUD)
//    Brazilian real (BRL)*
//  var getArr =  [ "British pound (GBP)","Canadian dollar (CAD)","Czech koruna (CZK)","Danish krone (DKK)","Euro (EUR)","Hong kong Dollar (HKD)","Hungarian forint (HUF)","Israeli new shekel (ILS)","Japanese yen (JPY)","Mexican peso (MXN)","New Taiwan dollar (TWD)","New Zealand dollar (NZD)","Norwegian krone (NOK)","Philippine peso (PHP)","Polish złoty (PLN)","Russian ruble (RUB)","Singapore dollar (SGD)","Swedish krona (SEK)","Swiss franc (CHF)","Thai baht (THB)","US dollar (USD)"]
    var getcurrencyArr = ["AED","UAE","AFN","ALL","AMD","AOA","ARS","AUD","AWG" ,"AZN","BAM","BBD","BDT","BGN","BHD","BHD","BIF","BMD","BND","BOB","BRL","BSD","BTN","BWP","BYR","BZD","CAD","CDF","CHF","CLP","CNY","COP","CRC","CUP","CVE","CZK","DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","GBP","GEL","GEL","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","INR","IQD","IRR","ISK","JMD","JOD","JPY","KES","KGS","KHR","KPW","KRW","KWD","KYD","KZT","LAK","LBP","LKR","LRD","LSL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRO","MUR","MVR","MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","RSD","RUB","RWF","SAR","SBD","SCR","SDG","SEK","SGD","SHP","SLL","SOS","SRD","STD","SYP","SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VEF","VND","VUV","WST","XAF","XCD","XPF","YER","ZAR","ZMW","ZWL"]

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        print(getcurrencyArr.count)
        return getcurrencyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCEll", for: indexPath) as! carz4hireTableViewCell
        
   //     cell.countryNameCurrency.text = getcountriesArr[indexPath.row]
        cell.currencyName.text = getcurrencyArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
                let getCu = getcurrencyArr[indexPath.row]
        
        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Are you sure to use \(getCu) currency ", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) {
            UIAlertAction in
        
           self.userData.set("\(getCu)", forKey: "saveCurrency")
            self.navigationController?.popViewController(animated: true)
        }
        
        
        alertController.addAction(okAction)
        let okAction2 = UIAlertAction(title: "NO", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
             tableView.reloadData()
        }
        
        
        alertController.addAction(okAction2)
        self.present(alertController, animated: true, completion: nil)
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
