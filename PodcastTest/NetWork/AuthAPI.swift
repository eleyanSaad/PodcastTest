//
//  API.swift
//
//  Created by Ammar AlTahhan on 27/05/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
//import FirebaseCrashlytics


extension API {
    
    //    // -------REGISTER THEN LOGIN API-------
    static func LoginAuth(email: String,password:String
                         , completion: @escaping (_ userData: User?, _ message: String?, _ error: Error?)->Void)
    {
        
        let url = URL(string: URLs.Login)!
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let headers = headers()
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            let message = getMessageFromResponse(response)
            switch response.result {
            case .failure(let err):
                print("\n\n\n/////////")
                print(err.localizedDescription)
                completion(nil, "", err)
            case .success(let value):
             
                let json = JSON(value)
                if let accessToken = json["accessToken"].string {
                    AppData.token = accessToken
                }
                
                if let refreshToken = json["refreshToken"].string {
                    AppData.refreshToken = refreshToken
                }
                
                do {
                    let services: User = try JSONDecoder()
                        .decode(User.self, from: try json["user"].rawData())
                  
                    completion(services , message, nil)
                } catch {
                    print("Error, couldn't decode data: \(error)")
                    completion(nil, "Error, couldn't decode data", error)
                }
            }
        }
        
    }
    
}

extension JSONDecoder {
    convenience public init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                            dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
