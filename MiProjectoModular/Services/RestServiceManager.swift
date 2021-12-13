//
//  RestServiceManager.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 13/12/2021.
//

import Foundation
import Alamofire

class RestServiceManager{
    let baseUrl = "https://raw.githubusercontent.com/beduExpert/Swift-Proyecto/main/API/db.json"
    
    private static var instance: RestServiceManager?
    
    static func getInstance() -> RestServiceManager{
        if(self.instance == nil) {
            self.instance = RestServiceManager()
        }
        return self.instance!
    }
    
    func goToInfo<T: Decodable>(responseType: T.Type, method: HTTPMethod, endpoint: String, completionHandler: @escaping (_ data: T?, _ error: Error?) -> () ){
        
        Alamofire.Session.default.session.configuration.requestCachePolicy = .reloadIgnoringCacheData
        
        var request = URLRequest(url: URL(string: "\(self.baseUrl)\(endpoint)")!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { response in
                switch response.result{
                case .success(let value):
                    print(value)
                    do{
                        let data = try JSONDecoder().decode(T.self, from: value)
                        completionHandler(data, nil)
                    }
                    catch{
                        print(error)
                        completionHandler(nil, error)
                    }
                    break
                case .failure(let error):
                    print(error)
                    completionHandler(nil, error)
                    break
                }
            })
    }
    
    func getMusic(completionHandler: @escaping (_ data: [Track]?, _ error: Error?) -> ()){
        self.goToInfo(responseType: SongsApi.self, method: .get, endpoint: "", completionHandler: {
            songsApi, error in
            completionHandler(songsApi?.songs, error)
        })
    }
}
