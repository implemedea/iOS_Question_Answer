//
//  APIHandler.swift
//  WG_PhotoPrintAPI
//
//  Created by Sebastin on 06/04/17.
//  Copyright © 2017 Sebastin. All rights reserved.
//

import UIKit

class UploadPhotoAPIHandler: NSObject {

    var affId:String = ""
    var apiKey:String = ""
    var endpoint:String = ""
    
    /**
    func buildCredDict() -> NSDictionary
    {
        let dict = [kKeyServiceType:kWags3,
                    kKeyApiKey: self.apiKey,
                    kAffId: self.affId,
                    kKeyAct:"genCredV2",
                    kKeyView:kGenCredential,
                    kKeyDevInf:"IE",
                    kKeyAppVer:"1.0"
        ]
        return dict as NSDictionary
    }
    
    func buildCheckoutDict(_ images:Array<String>,lat:String,lng:String) -> NSDictionary
    {
        let defaults:UserDefaults = UserDefaults()
        let expiry = defaults.value(forKey: "EXPIRY_TIME") as! String
        let stringExpiry = self.convertExpiryTime(expiry)
        
        let dict:NSDictionary = [
            kKeyApiKey:self.apiKey,
            kAffId:self.affId,
            "transaction": "photoCheckoutv2",
            kKeyAct: "mweb5UrlV2",
            kKeyView: "mweb5UrlV2JSON",
            "channelInfo": "iPhone",
            "callBackLink": "",
            kKeyPublisherId: "",
            "expiryTime": stringExpiry,
            "images": images,
            "lat": lat,
            "lng": lng,
            "customer": [
                "firstName": "Drew",
                "lastName": "Schweinfurth",
                "email": "test@api.com",
                kPhone: "3123425743"
            ],
            kKeyDevInf: "iPhone,9.1",
            kKeyAppVer: "0.01",
            "affNotes": ""
        ]
        
        return dict
    }
 **/
    
    
    func generateFinalURL(_ imageName:String, url:String, sessionID:String, secretKey:String, accessKeyId:String) -> String
    {
        let uploadTrim = url.replacingOccurrences(of: "http://", with: "")
        let expiryTime = self.getExpiryTime()
        let defaults:UserDefaults = UserDefaults()
        defaults.setValue(expiryTime, forKey: "EXPIRY_TIME")
        
        let data = "GET\n\n\n\(expiryTime)\nx-amz-security-token:\(sessionID)\n/\(uploadTrim)/\(imageName)"
        let signature:String = data.hmac(key: secretKey)
        let encodedSessionID = sessionID.urlencode()
        let encodedSignature = signature.urlencode()
        let imageURL = "\(url)/\(imageName)?Expires=\(expiryTime)&AWSAccessKeyId=\(accessKeyId)&x-amz-security-token=\(encodedSessionID)&Signature=\(encodedSignature)"
        
        print("Expires:\(expiryTime)")
        print("Data:\(data)")
        print("Signature: \(signature)")
        print("Final URL: \(imageURL)")
        
        return imageURL
    }
    
    func convertExpiryTime(_ expiry:String) -> String
    {
        let e:Date = Date(timeIntervalSince1970: Double(expiry)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: kTimeZoneType)
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        let date = dateFormatter.string(from: e)
        
        return date
    }
    
    func generateUploadAuth(_ imageName:String, url:String, sessionID:String, secretKey:String, accessKeyId:String) -> String
    {
        let date:String = self.getDateString()
        let uploadTrim = url.replacingOccurrences(of: "http://", with: "")
        
        let data = "PUT\n\nimage/jpg\n\(date)\nx-amz-security-token:\(sessionID)\n/\(uploadTrim)/\(imageName)"
        let signature:String = data.hmac(key: secretKey)
        let auth:String = "AWS \(accessKeyId):\(signature)"
        
        print("Data:\(data)")
        print("Signature: \(signature)")
        print("Final Auth: \(auth)")
        
        return auth
    }
    func getExpiryTime() -> String
    {
        let date = Date().timeIntervalSince1970
        let expiry = String(Int(date) + 129600)
        
        return expiry
    }
    func getDateString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: kTimeZoneType)
        dateFormatter.dateFormat = "EEE',' dd MMM yyyy HH:mm:ss 'GMT'"
        let date = dateFormatter.string(from: Date())
        
        return date
    }
}

enum HMACAlgorithm {
    case md5, sha1, sha224, sha256, sha384, sha512
    
    func toCCHmacAlgorithm() -> CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .md5:
            result = kCCHmacAlgMD5
        case .sha1:
            result = kCCHmacAlgSHA1
        case .sha224:
            result = kCCHmacAlgSHA224
        case .sha256:
            result = kCCHmacAlgSHA256
        case .sha384:
            result = kCCHmacAlgSHA384
        case .sha512:
            result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    func digestLength() -> Int {
        var result: CInt = 0
        switch self {
        case .md5:
            result = CC_MD5_DIGEST_LENGTH
        case .sha1:
            result = CC_SHA1_DIGEST_LENGTH
        case .sha224:
            result = CC_SHA224_DIGEST_LENGTH
        case .sha256:
            result = CC_SHA256_DIGEST_LENGTH
        case .sha384:
            result = CC_SHA384_DIGEST_LENGTH
        case .sha512:
            result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    
    func hmac(key: String) -> String
    {
        let dataToDigest = self.data(using: String.Encoding.utf8)
        let keyData = key.data(using: String.Encoding.utf8)
        
        let digestLength = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<Any>.allocate(capacity: digestLength)
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), (keyData! as NSData).bytes, keyData!.count, (dataToDigest! as NSData).bytes, dataToDigest!.count, result)
        let data = Data(bytes: UnsafePointer(result), count: digestLength)
        let base64EncodedData = data.base64EncodedData(options: [])
        
        return NSString(data: base64EncodedData, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func urlencode()->String
    {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
            .replacingOccurrences(of: "&", with: "%26")
            .replacingOccurrences(of: "=", with: "%3D")
            .replacingOccurrences(of: "+", with: "%2B")
            .replacingOccurrences(of: "/", with: "%2F")
            .replacingOccurrences(of: "?", with: "%3F")
    }
}
