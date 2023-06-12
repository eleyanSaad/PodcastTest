//
//  API.swift


import Foundation
import SwiftyJSON
import Alamofire

enum URLs {

    // MARK: - BASE:
    static var BaseURL = "https://staging.podcast.kaitdev.com/client"
    static let API = BaseURL
  
    //MARK: - AUTHS:
    static let Login = API + "/api/auth/login"
   
    // MARK: - HOME
    static func getHomePlayList(ID: String) -> String { return API + "/api/playlist/\(ID)" }
}

// MARK: - HEADERS
class API {
    static func headers() -> [String: String] {
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Accecpt": "application/json"
        ]
        if AppData.isLogin {
            headers["Authorization"] = "Bearer \(AppData.token)"
        }
        
        return headers
    }

    static func getMessageFromResponse(_ response: DataResponse<Any>) -> String {
        var message = ""
        
        switch response.result {
        case .failure(_):
        
            guard let data = response.data else { break }
            message = JSON(data)["error_message"].stringValue
            
            print(message)
            
            if response.response?.statusCode == 500 {
                message = "Server error"
            }
        case .success(let value):
            message = JSON(value)["success_message"].stringValue
        }
        return message
    }
    
    static func isUnauthenticated(_ response: DataResponse<Any>) -> Bool {
        return response.response?.statusCode == 401
    }
    
    static func isServerError(_ response: DataResponse<Any>) -> Bool {
        return response.response?.statusCode == 500
    }
}
