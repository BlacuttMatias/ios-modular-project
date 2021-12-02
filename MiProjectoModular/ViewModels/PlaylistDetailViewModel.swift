//
//  PlaylistDetailViewModel.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 02/12/2021.
//

import Foundation

class PlaylistDetailViewModel{
    private var tracks: [Track] = []
    private var playlist: [Track] = []
    private weak var playlistDetailDelegate: PlaylistDetailDelegate?
    
    init(apiManager: ApiManager, playlistDetailDelegate: PlaylistDetailDelegate){
        self.playlistDetailDelegate = playlistDetailDelegate
        let loadTracksCallback: (([Track]?, Error?) -> ()) = { tracks, error in
            if error != nil {
                print("Error to load songs")
            }
            else{
                self.tracks = tracks ?? []
                DispatchQueue.main.async {
                    self.playlistDetailDelegate?.reloadPicker()
                }
            }
        }
        ApiManager.getInstance().getMusic(completion: loadTracksCallback)
    }
    
    func getTracks() -> [Track]{
        return self.tracks
    }
    
    func getNumberRowsPicker() -> Int{
        return self.tracks.count
    }
    
    func getTitleRowPicker(row: Int) -> String{
        return self.tracks[row].title
    }
    
    func getNumberComponentsPicker() -> Int{
        return 1
    }
    
    func getPlaylist() ->[Track]{
        return self.playlist
    }
    
    func addTrackToPlaylist(track: Track){
        self.playlist.append(track)
        self.playlistDetailDelegate?.songAdded()
    }
    
    func getNumberRowsInSection() -> Int{
        return self.playlist.count
    }
    
    func getCellPlaylist(index: Int) -> PlaylistTrackViewCell{
        return PlaylistTrackViewCell(track: self.playlist[index], reuseIdentifier: "cellPlaylist")
    }
}
