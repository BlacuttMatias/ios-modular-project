//
//  TrackerViewModel.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 01/12/2021.
//

import Foundation
import CoreData

class TrackerViewModel{
    
    private var tracks: [Track] = []
    private weak var trackerDelegate: TrackerDelegate?
    private var loadTracksCallback: (([Track]?, Error?) -> ()) = {_,_ in }
    private weak var menuTrackerDelegate: MenuTrackerDelegate?
    var selectedCell: TrackTableViewCell?
    var addElementsTimer: Timer?
    let addElementsNotification: String = "addElementsNotification"
    
    init(apiManager: RestServiceManager, trackerDelegate: TrackerDelegate, menuTrackerDelegate: MenuTrackerDelegate){
        self.trackerDelegate = trackerDelegate
        self.menuTrackerDelegate = menuTrackerDelegate
        
        ///
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        self.savedData()
        ///
        
        loadTracksCallback = { tracks, error in
            if error != nil {
                self.savedData()
                DispatchQueue.main.async {
                    self.trackerDelegate?.reloadDataTable()
                    self.trackerDelegate?.dismissLoadingAlert()
                }
                print("Error to load songs")
                
                
            }
            else{
                self.tracks = tracks ?? []
            ///
                if let _context = context{
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TrackModel")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    do{
                        try appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                    } catch{
                        print(error)
                    }
                    
                    let _tracks = tracks ?? []
                    for item in _tracks{
                        guard let trackEntity = NSEntityDescription.insertNewObject(forEntityName: "TrackModel", into: _context) as? NSManagedObject else {
                            return
                        }
                        trackEntity.setValue(item.songId, forKey: "songId")
                        trackEntity.setValue(item.title, forKey: "title")
                        trackEntity.setValue(item.artist, forKey: "artist")
                        trackEntity.setValue(item.genre, forKey: "genre")
                        trackEntity.setValue(item.album, forKey: "album")
                        trackEntity.setValue(item.duration, forKey: "duration")
                        
                        do{
                            try _context.save()
                        } catch{
                            print("No se guardo la informacion: \(error), \(error.localizedDescription)")
                        }
                            
                    }
                }
                
                DispatchQueue.main.async {
                    self.trackerDelegate?.reloadDataTable()
                    self.trackerDelegate?.dismissLoadingAlert()
                }
            }
        }
        ApiManager.getInstance().getMusic(completion: loadTracksCallback)
        self.addObserverToAddElements()
        self.startTimerAddElements()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(addElementsNotification), object: nil)
        self.addElementsTimer?.invalidate()
    }
    
    func savedData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TrackModel")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context!.fetch(request)
            self.tracks = []
            
            for data in result as! [NSManagedObject]{
                let title = data.value(forKey: "title") as? String ?? ""
                let songId = data.value(forKey: "songId") as? String ?? ""
                let artist = data.value(forKey: "artist") as? String ?? ""
                let album = data.value(forKey: "album") as? String ?? ""
                let genre = data.value(forKey: "genre") as? String ?? ""
                let duration = data.value(forKey: "duration") as? Double ?? 0
                
                let track = Track(title: title, artist: artist, album: album, songId: songId, genre: genre, duration: duration)
                
                self.tracks.append(track)
            }
        } catch{
            print("Fallo al obtener info de la BD. \(error), \(error.localizedDescription)")
        }
        
    }
    
    func getNumberOfRows() -> Int{
        return self.tracks.count
    }
    
    func getNumberOfSections() -> Int{
        return 1
    }
    
    func getTrackViewCell(index: Int) -> TrackTableViewCell? {
        guard let trackerDelegate = self.trackerDelegate else {
            return nil
        }
        return TrackTableViewCell(track: self.tracks[index], parent: trackerDelegate, reuseIdentifier: "reuseIdentifier", actionsMenu: self.getActionsMenu(wasDownloaded: false), titleUiMenu: "")
    }
    
    func getAudioPlayerViewController(currentTrack: Track) -> AudioPlayerViewController{
        let vc = AudioPlayerViewController()
        vc.setTracks(currentTrack: currentTrack, tracks: self.tracks)
        return vc
    }
    
    func getActionsMenu(wasDownloaded: Bool?) -> [ActionMenuButton]{
        var actions = [
            ActionMenuButton(title: TitleActionMenuTracker.play.rawValue, imageName: Resource.playCircleIcon, actionHandler: { self.menuTrackerDelegate?.playSong(action: $0) }),
            ActionMenuButton(title: TitleActionMenuTracker.eliminateFromPlaylist.rawValue, imageName: Resource.deleteIcon, actionHandler: { self.menuTrackerDelegate?.eliminateFromPlaylist(action: $0) }),
        ]
        if(!(wasDownloaded ?? false)){
            let downloadAction = ActionMenuButton(title: TitleActionMenuTracker.download.rawValue, imageName: Resource.downloadIcon, actionHandler: { self.menuTrackerDelegate?.downloadSong(action: $0) })
            actions.insert(downloadAction, at: 1)
        }
        return actions
    }
    
    func getTitleDownloadAction() -> String{
        return "Downloading song..."
    }
    
    func getMessageDownloadAction() -> String{
        let titleSong = selectedCell?.getTrack().title ?? "Unknown"
        let artistSong = selectedCell?.getTrack().artist ?? "Unknown"
        let albumSong = selectedCell?.getTrack().album ?? "Unknown"
        return "Title: \(titleSong)\n Artist: \(artistSong)\n Album: \(albumSong)"
    }
    
    func getSelectedTrack() -> Track?{
        return self.selectedCell?.getTrack()
    }
    
    func doDownloadAction(){
        self.selectedCell?.wasDownloaded = true
    }
    
    func getTitleDeleteSongAction() -> String{
        let songTitle = selectedCell?.getTrack().title ?? "Unknown"
        return "\"\(songTitle)\" removed from Playlist"
    }
    
    func getMessageDeleteSongAction() -> String{
        let songTitle = selectedCell?.getTrack().title ?? "Unknown"
        return "The song \"\(songTitle)\" was removed from the Playlist"
    }
    
    func startTimerAddElements(){
        addElementsTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.publishAddElementNotification), userInfo: nil, repeats: true)
    }
    
    @objc func publishAddElementNotification(){
        NotificationCenter.default.post(name: NSNotification.Name(addElementsNotification), object: nil)
    }
    
    func addObserverToAddElements(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.addHardcodeElement), name: NSNotification.Name(addElementsNotification), object: nil)
    }
    
    @objc func addHardcodeElement(){
        let trackToAdd = Track(title: "cancion1", artist: "artista1", album: "album1", songId: "1010", genre: nil, duration: 146.42)
        self.tracks.append(trackToAdd)
        DispatchQueue.main.async {
            self.trackerDelegate?.reloadDataTable()
        }
    }
    
}
    

