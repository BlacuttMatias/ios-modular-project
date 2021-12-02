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
    
    init(apiManager: ApiManager, trackerDelegate: TrackerDelegate){
        self.trackerDelegate = trackerDelegate
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
        return TrackTableViewCell(track: self.tracks[index], parent: trackerDelegate, reuseIdentifier: "reuseIdentifier")
    }
    
    func getAudioPlayerViewController(currentTrack: Track) -> AudioPlayerViewController{
        let vc = AudioPlayerViewController()
        vc.setTracks(currentTrack: currentTrack, tracks: self.tracks)
        return vc
    }
    
}
    

