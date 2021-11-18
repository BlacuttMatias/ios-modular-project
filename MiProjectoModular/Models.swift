//
//  Models.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 29/10/2021.
//

import Foundation

struct Account {
    let username: String
    let email: String
    let pass: String
}

struct Registered {
    let user1: Account = Account(username: "123", email: "123@io", pass: "clave123")
    
    func isRegistered(account: Account) -> Bool{
        return (account.username == user1.username || account.email == user1.email) && account.pass == user1.pass
    }
}

struct Track: Codable{
    let title: String
    let artist: String?
    let album: String?
    let song_id: String
    let genre: String?
    let duration: String?
}

struct Tracks{
    let myTracks = [
        Track(title: "cancion1", artist: "artista1", album: "album1", song_id: "bensound-ukulele", genre: nil, duration: "146.42"),
        Track(title: "cancion2", artist: "artista2", album: "album2", song_id: "bensound-ukulele", genre: nil, duration: "146.42"),
        Track(title: "cancion3", artist: "artista3", album: "album3", song_id: "bensound-ukulele", genre: nil, duration: "146.42"),
        Track(title: "cancion4", artist: "artista4", album: "album4", song_id: "bensound-ukulele", genre: nil, duration: "146.42"),
        Track(title: "cancion5", artist: "artista5", album: "album5", song_id: "bensound-ukulele", genre: nil, duration: "146.42"),
        Track(title: "cancion6", artist: "artista6", album: "album6", song_id: "bensound-ukulele", genre: nil, duration: "146.42"),
        Track(title: "cancion7", artist: "artista7", album: "album7", song_id: "bensound-ukulele", genre: nil, duration: "146.42")
    ]
}
