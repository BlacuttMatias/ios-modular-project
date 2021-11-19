//
//  ApiManager.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 18/11/2021.
//

import Foundation
import SystemConfiguration
import Network

class ApiManager{
    
    let baseURL = "https://jsonplaceholder.typicode.com/"
    
    private static var instance: ApiManager?
    let musicEndPoint = "songs/"
    var pathMonitor: NWPathMonitor
    var path: NWPath?
    
    init(){
        pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = { Path in
            self.path = Path
        }
        let elKiu = DispatchQueue (label: "NetworkMonitor")
        pathMonitor.start(queue: elKiu)
    }
    
    static func getInstance() -> ApiManager{
        if(self.instance == nil) {
            self.instance = ApiManager()
        }
        return self.instance!
    }
    
    func getMusic(completion: @escaping ([Track]?, Error?) -> ()) {
        let url : String = baseURL + self.musicEndPoint
        let request : NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string:  url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if error != nil {
                completion(nil, error!)
            }
            else {
                if let data = data {
                    let result = try? JSONDecoder().decode([Track].self, from: data)
                    completion (result, nil)
                }
            }
        }
        task.resume()
    }
    
    func checkConnectivity() -> Bool {
        if let path = self.path {
            return path.status == NWPath.Status.satisfied
        }
       return false
    }
}
