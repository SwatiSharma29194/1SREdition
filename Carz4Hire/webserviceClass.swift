
//
//  webserviceClass.swift
//  Proqyr
//
//  Created by promatics on 4/7/16.
//  Copyright © 2016 Apple. All rights reserved.
//

//
//  webserviceClass.swift
//  Proqyr
//
//  Created by promatics on 4/7/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import Foundation

import UIKit

import AFNetworking



enum methodType {
    
    case POST,GET
}

class webservices {
    
    class var sharedInstance: webservices {
        
        struct Static {
            
            let ff = 0
//            struct Person {
//                var age = 16
//                
//                lazy var fibonacciOfAge: Int = {
//                    return fibonacci(of: self.age)
//                }()
//            }
           // static var onceToken: dispatch_once_t = 0
            lazy var onceToken: Int = {
                
               // return fibonacci(of: self.age)
            }()

    
            
            static var instance: webservices? = nil
            
        }
        Static.instance = webservices()
        
//      dispatch_once(&Static.onceToken) {
//            
//            Static.instance = webservices()
//            
//        }
//    
        return Static.instance!
    }
    
    var responseCode = 0;
    
    var connectionError = ""
    
    var userData = UserDefaults()
    
    func startConnectionWithSting2(getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void
        
        ) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        // manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
       manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
      // manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        let url = baseURL + (getUrlString as String)
        
        print(url)
        
        var token = String()
        token =  userData.value(forKey: "acessToken") as! String

        manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")

        manager.post(url as String,
                     parameters: getParams,
                     success: { (operation: AFHTTPRequestOperation!,responseObject: Any!) in
                        
                        if(responseObject != nil){
                            
                            self.responseCode = 1
                            
                            
                            outputBlock(responseObject! as! NSDictionary);
                            
                            
                            
                            // print("JSON: " + responseObject.description)
                        }
        },
                     failure: { (operation, error) in
                        
                        self.responseCode = 2
                        
                        self.connectionError = error.localizedDescription
                        
                        
                        outputBlock([:]);
                        
                        
                        
                        print("Error: " + error.localizedDescription)
        })
    }

    func sendImagesArray(imageData:NSMutableArray,fileName:NSMutableArray,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        // manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        // text/html
        let url = baseURL + (getUrlString as String)
         var token = String()
           token =  userData.value(forKey: "acessToken") as! String
        manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
            
            for i in 0..<imageData.count {
                
                formData.appendPart(withFileData: (imageData.object(at: i) as! NSData) as Data, name:imageparm, fileName: fileName.object(at: i) as! String, mimeType: "image/jpeg")
                
                
            }
            
            
            
            
            
            
            
        },      success: { (operation: AFHTTPRequestOperation!,responseObject: Any!) in
            print(responseObject)
            if(responseObject != nil){
                
                IJProgressView.shared.hideProgressView()
                
                self.responseCode = 1
                
                //data.writeToFile(filename, atomically: true)
                
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
            
        },  failure: { (operation, error) in
            print(error)
            
            IJProgressView.shared.hideProgressView()
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error.localizedDescription]
            
            outputBlock(errorDist);
            
            print("Error: " + error.localizedDescription)
        })
        
    }

    func sendImagesArray2(imageData:NSMutableArray,fileName:NSMutableArray,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        // text/html
        let url = baseURL + (getUrlString as String)
      
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
            
            for i in 0..<imageData.count {
                
                formData.appendPart(withFileData: (imageData.object(at: i) as! NSData) as Data, name:imageparm, fileName: fileName.object(at: i) as! String, mimeType: "image/jpeg")
                
                
            }
            
            
            
            
            
            
            
        },      success: { (operation: AFHTTPRequestOperation!,responseObject: Any!) in
            print(responseObject)
            if(responseObject != nil){
                
                IJProgressView.shared.hideProgressView()
                
                self.responseCode = 1
                
                //data.writeToFile(filename, atomically: true)
                
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
            
        },  failure: { (operation, error) in
            print(error)
            
            IJProgressView.shared.hideProgressView()
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error.localizedDescription]
            
            outputBlock(errorDist);
            
            print("Error: " + error.localizedDescription)
        })
        
    }
    func startConnectionWithSting(getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void
        
        ) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
// manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
       manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
     //  manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        let url = baseURL + (getUrlString as String)
        
        print(url)
        
        manager.post(url as String,
                     parameters: getParams,
                     success: { (operation: AFHTTPRequestOperation!,responseObject: Any!) in
                        
                        if(responseObject != nil){
                            
                            self.responseCode = 1
                            
                            
                            outputBlock(responseObject! as! NSDictionary)
                            
                       
                            
                            // print("JSON: " + responseObject.description)
                        }
            },
                     failure: { (operation, error) in
                        
                        self.responseCode = 2
                        
                        self.connectionError = error.localizedDescription
                        
                        
                        outputBlock([:]);
                        
                        
                        
                        print("Error: " + error.localizedDescription)
        })
    }
    
//    func startConnectionWithfile(imageData:NSData,fileName:String,filetype:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
//        
//        let manager = AFHTTPRequestOperationManager()
//        
//        manager.operationQueue.cancelAllOperations()
//        
//      //  manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
//          manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
//          //   manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
//        
//        let url = baseURL + (getUrlString as String)
//        // let request = NSMutableURLRequest(URL: directionsURL)
//       
//        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
//            //code
//            formData.appendPart(withFileData: imageData as Data, name: "file", fileName: fileName, mimeType:filetype )
//            
//              print("formdata",formData)
//            }, success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in
//                
//                print(responseObject)
//              
//                if(responseObject != nil){
//                    
//                    self.responseCode = 1
//                    
//                    
//                    outputBlock(responseObject! as! NSDictionary);
//                    
//                    // print("JSON: " + responseObject.description)
//                }
//                
//            }, failure: { (operation, error) in
//                print(error)
//                
//                IJProgressView.shared.hideProgressView()
//        })
//        
//    }
    
    
    func startConnectionWithfile2(imageData:NSData,fileName:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
              // text/html
        let url = baseURL + (getUrlString as String)
        //let url = (getUrlString as String)
        var token = String()
        token =  userData.value(forKey: "acessToken") as! String
        
        manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
            //code
        formData.appendPart(withFileData: imageData as Data, name:imageparm, fileName: fileName, mimeType: "image/jpeg")
            
            
            //
            //            conn.startConnectionWithfile(imageData, fileName: fileName, imageparm: "cover_image", getUrlString: "PublishBook", method_type:methodType.POST, params: param){receivedData in
        }, success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in
            print(responseObject)
            if(responseObject != nil){
                
                self.responseCode = 1
                
                //data.writeToFile(filename, atomically: true)
                
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
            
        }, failure: { (operation, error) in
            print(error)
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error.localizedDescription]
            
            outputBlock(errorDist);
            
            print("Error: " + error.localizedDescription)
        })
        
        
        
        
    }
    
    func startConnectionWithMultipleFile(getUrlString:NSString ,method_type:methodType,fileData:NSMutableArray,fileName:NSMutableArray,imageparm:NSMutableArray, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void
        
        ) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
      //  manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        // text/html
        // text/html
        let url = baseURL + (getUrlString as String)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
            //code
            formData.appendPart(withFileData: (fileData.object(at: 0) as! NSData) as Data, name:imageparm.object(at: 0) as! String, fileName: fileName.object(at: 0) as! String, mimeType: "image/jpeg")
            formData.appendPart(withFileData: (fileData.object(at: 1) as! NSData) as Data, name:imageparm.object(at: 1) as! String, fileName: fileName.object(at: 1) as! String, mimeType: "application/pdf")
            
            
        }, success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in
            print(responseObject)
            print(responseObject)
            if(responseObject != nil){
                
                self.responseCode = 1
                
                //data.writeToFile(filename, atomically: true)
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
            
        },failure: { (operation, error) in
            print(error)
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error.localizedDescription]
            
            //  self.msg = error.localizedDescription
            
            outputBlock(errorDist);
            
            print("Error: " + error.localizedDescription)
        })
        
    }
    //
    func startConnectionWithfileSave(_ imageData:Data,fileName:String,filetype:String, getUrlString:NSString ,method_type: methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        
        let url = baseURL + (getUrlString as String)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
            //code
            formData.appendPart(withFileData: imageData, name: "file", fileName: fileName, mimeType:filetype )
        }, success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in
            print(responseObject)
            if(responseObject != nil){
                
                self.responseCode = 1
                
                
                outputBlock(responseObject! as! NSDictionary);

                
                // print("JSON: " + responseObject.description)
            }
            
        }, failure: { (operation, error) in
            print(error)
            
            IJProgressView.shared.hideProgressView()
        })
        
    }
    
    func startConnectionWithStringGetType(getUrlString:NSString ,outputBlock:@escaping (_ receivedData:NSDictionary)->Void
        
        ) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        let url = baseURL + (getUrlString as String)
        
        print(url)
        
        manager.get(url as String,
                    parameters: nil,//getParams,
            success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in

                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    IJProgressView.shared.hideProgressView()
                    
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
        },
            
            
            failure: { (operation, error) in
                IJProgressView.shared.hideProgressView()
                
                self.responseCode = 2
                
                let errorDist:NSDictionary = ["Error" : error.localizedDescription]
                
                outputBlock(errorDist);
                
                print("Error: " + error.localizedDescription)
        })
        
        
        
    }
    
    func startConnectionWithStringGetType2(getUrlString:NSString ,outputBlock:@escaping (_ receivedData:NSDictionary)->Void
        
        ) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        let url = baseURL + (getUrlString as String)
        
        print(url)
        var token = String()
        token =  userData.value(forKey: "acessToken") as! String
        
        manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.get(url as String,
                    parameters: nil,//getParams,
            success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in
                
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    IJProgressView.shared.hideProgressView()
                    
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
        },
            
            
            failure: { (operation, error) in
                IJProgressView.shared.hideProgressView()
                
                self.responseCode = 2
                
                let errorDist:NSDictionary = ["Error" : error.localizedDescription]
                
                outputBlock(errorDist);
                
                print("Error: " + error.localizedDescription)
        })
        
        
        
    }


    func startConnectionWithfile(imageData:NSData,fileName:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
       // manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
         manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        // text/html
        let url = baseURL + (getUrlString as String)
        //let url = (getUrlString as String)
   
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
            //code
            formData.appendPart(withFileData: imageData as Data, name:imageparm, fileName: fileName, mimeType: "image/jpeg")
            
            
            //
            //            conn.startConnectionWithfile(imageData, fileName: fileName, imageparm: "cover_image", getUrlString: "PublishBook", method_type:methodType.POST, params: param){receivedData in
        }, success: { (operation:AFHTTPRequestOperation!, responseObject:Any!) -> Void in
            print(responseObject)
            if(responseObject != nil){
                
                self.responseCode = 1
                
                //data.writeToFile(filename, atomically: true)
                
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
            
        }, failure: { (operation, error) in
            print(error)
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error.localizedDescription]
            
            outputBlock(errorDist);
            
            print("Error: " + error.localizedDescription)
        })
        
        
        
        
    }

}
