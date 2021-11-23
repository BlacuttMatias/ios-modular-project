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
    let songId: String
    let genre: String?
    let duration: Double?
    
    enum CodingKeys:String, CodingKey{
        case title
        case artist
        case album
        case songId = "song_id"
        case genre
        case duration
    }
    
    init(title: String, artist: String? = nil, album: String? = nil, songId: String, genre: String? = nil, duration: Double? = nil) {
        self.title = title
        self.artist = artist
        self.album = album
        self.songId = songId
        self.genre = genre
        self.duration = duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        songId = try container.decode(String.self, forKey: .songId)
        genre = try container.decode(String.self, forKey: .genre)
        artist = try container.decode(String.self, forKey: .artist)
        do{
            album = try container.decode(String.self, forKey: .album)
        }
        catch{
            album = nil
        }
        do {
            duration = try Double(container.decode(String.self, forKey: .duration))
        } catch DecodingError.typeMismatch {
            duration = try container.decode(Double.self, forKey: .duration)
        }
    }
}

struct SongsApi: Codable{
    let songs:[Track]
}

struct Tracks{
    let myTracks = [
        Track(title: "cancion1", artist: "artista1", album: "album1", songId: "bensound-ukulele", genre: nil, duration: 146.42),
        Track(title: "cancion2", artist: "artista2", album: "album2", songId: "bensound-ukulele", genre: nil, duration: 146.42),
        Track(title: "cancion3", artist: "artista3", album: "album3", songId: "bensound-ukulele", genre: nil, duration: 146.42),
        Track(title: "cancion4", artist: "artista4", album: "album4", songId: "bensound-ukulele", genre: nil, duration: 146.42),
        Track(title: "cancion5", artist: "artista5", album: "album5", songId: "bensound-ukulele", genre: nil, duration: 146.42),
        Track(title: "cancion6", artist: "artista6", album: "album6", songId: "bensound-ukulele", genre: nil, duration: 146.42),
        Track(title: "cancion7", artist: "artista7", album: "album7", songId: "bensound-ukulele", genre: nil, duration: 146.42)
    ]
}

enum PlayerStates {
    case play
    case pause
    case next
    case previous
}
