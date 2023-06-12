//////
//////  BasicAPI.swift
//////  QosoorApp
//////
//////  Created by Ammar AlTahhan on 01/06/2019.
//////  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//////
////
import Foundation
import Alamofire
import SwiftyJSON
////
extension API {
    static func getPlayListDetails(completion: @escaping (_ services: PlaylistData?,_ message: String, _ error: Error?)-> Void)
        {
            let url = URL(string: URLs.getHomePlayList(ID: "01GVD0TTY5RRMHH6YMCW7N1H70"))!
            
            
            let debug = Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: API.headers()).validate().responseJSON { (response) in
    
                guard !isUnauthenticated(response) else {
                    completion(nil, "401", response.error)
                    return
                }
                guard !isServerError(response) else {
                    completion(nil, "500",response.error)
                    return
                }
    
                let message = getMessageFromResponse(response)
                switch response.result {
                case .failure(let err):
                    completion(nil, message, err)
                case .success(let value):
                    let json = JSON(value)
                    do {
                        let playListData: PlaylistData? = try JSONDecoder()
                            .decode(PlaylistData.self, from: try json["data"].rawData())
                        completion(playListData , message, nil)
                    } catch {
                        print("Error, couldn't decode data: \(error)")
                        completion(nil, "Error, couldn't decode data", error)
                    }
                }
    
            }.debugDescription
            print(debug)
        }
    
}
