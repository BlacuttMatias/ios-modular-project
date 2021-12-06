//
//  TrackerViewModel.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 01/12/2021.
//

import Foundation

class TrackerViewModel{
    
    private var tracks: [Track] = []
    private weak var trackerDelegate: TrackerDelegate?
    private var loadTracksCallback: (([Track]?, Error?) -> ()) = {_,_ in }
    private weak var menuTrackerDelegate: MenuTrackerDelegate?
    var selectedCell: TrackTableViewCell?
    
    init(apiManager: ApiManager, trackerDelegate: TrackerDelegate, menuTrackerDelegate: MenuTrackerDelegate){
        self.trackerDelegate = trackerDelegate
        self.menuTrackerDelegate = menuTrackerDelegate
        loadTracksCallback = { tracks, error in
            if error != nil {
                DispatchQueue.main.async {
                    self.trackerDelegate?.dismissLoadingAlert()
                }
                print("Error to load songs")
            }
            else{
                self.tracks = tracks ?? []
                DispatchQueue.main.async {
                    self.trackerDelegate?.reloadDataTable()
                    self.trackerDelegate?.dismissLoadingAlert()
                }
            }
        }
        ApiManager.getInstance().getMusic(completion: loadTracksCallback)
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
            ActionMenuButton(title: "Play", imageName: Resource.playCircleIcon, actionHandler: { self.menuTrackerDelegate?.playSong(action: $0) }),
            ActionMenuButton(title: "Eliminate from Playlist", imageName: Resource.deleteIcon, actionHandler: { self.menuTrackerDelegate?.eliminateFromPlaylist(action: $0) }),
        ]
        if(!(wasDownloaded ?? false)){
            let downloadAction = ActionMenuButton(title: "Download", imageName: Resource.downloadIcon, actionHandler: { self.menuTrackerDelegate?.downloadSong(action: $0) })
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
    
}
    

