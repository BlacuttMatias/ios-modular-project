//
//  TracksPlayer.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 26/11/2021.
//

import Foundation

class TracksPlayer{
    var currentTrack: Track
    var tracks: [Track] = []
    
    init(currentTrack: Track, tracks: [Track]){
        self.currentTrack = currentTrack
        self.tracks = tracks
    }
    
    private func indexCurrentTrack() -> Int{
        return self.tracks.firstIndex(where: { $0.songId == self.currentTrack.songId }) ?? 0
    }
    
    func nextTrack(){
        self.currentTrack = self.tracks[self.indexCurrentTrack()+1]
    }
    
    func previousTrack(){
        self.currentTrack = self.tracks[self.indexCurrentTrack()-1]
    }
    
    func areInTheFirstTrack() -> Bool{
        return self.indexCurrentTrack() == 0
    }
    
    func areInTheLastTrack() -> Bool{
        return self.indexCurrentTrack() == (self.tracks.count-1)
    }
    
    func areNotInTheLastTrack() -> Bool{
        return !self.areInTheLastTrack()
    }
}
