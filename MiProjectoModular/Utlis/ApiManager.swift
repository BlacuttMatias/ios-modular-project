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
    
    let baseURL = "https://raw.githubusercontent.com/beduExpert/Swift-Proyecto/main/API/db.json"
    
    private static var instance: ApiManager?
    let musicEndPoint = ""
    var pathMonitor: NWPathMonitor
    var thereIsInternetConnection: Bool
    
    init(){
        pathMonitor = NWPathMonitor()
        thereIsInternetConnection = false
        pathMonitor.pathUpdateHandler = { Path in
            self.thereIsInternetConnection = Path.status == NWPath.Status.satisfied
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
        let session = URLSession(configuration: .default)
        var tarea: URLSessionTask?
        
        if let laUrl = URL(string: self.baseURL) {
            var elRequest = URLRequest(url: laUrl)
            elRequest.httpMethod = "GET"  // "POST" get es el método predeterminado
            elRequest.addValue("application/json", forHTTPHeaderField: "Accept")  // si el contenido es text/html, no se tiene que especificar
            tarea = session.dataTask(with: elRequest) { datos, response, error in
                guard error == nil else {
                    print ("Algo salio mal, error \(String(describing: error?.localizedDescription))")
                    return
                }
                guard let data = datos else {
                    print ("Algo salio mal, no se recibieron datos")
                    return
                }
                do {
                    let mascotas = try JSONDecoder().decode(SongsApi.self, from: data)
                    Tracks.tracks = mascotas.songs
                }
                catch {
                    print ("ERRORR: "+String(describing: error))
                }
            }
            tarea?.resume()
        }
    }
    
    func checkConnectivity() -> Bool {
        return thereIsInternetConnection
    }
}
