//
//  TrackConverter.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/12/2021.
//

import Foundation

struct TrackConverter{
    func getTrackWithLove(with track: Track) -> TrackWithLove{
        return TrackWithLove(title: track.title, artist: track.artist, album: track.album, songId: track.songId, genre: track.genre, duration: track.duration)
    }
    
    func getTracksWithLove(with tracks: [Track]) -> [TrackWithLove]{
        return tracks.map({self.getTrackWithLove(with: $0)})
    }
    
    func getTrack(with trackWithLove: TrackWithLove) -> Track{
        return Track(title: trackWithLove.title, artist: trackWithLove.artist, album: trackWithLove.album, songId: trackWithLove.songId, genre: trackWithLove.genre, duration: trackWithLove.duration)
    }
}
