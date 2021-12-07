//
//  Enums.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 07/12/2021.
//

import Foundation

enum PlayerStates {
    case play
    case pause
    case next
    case previous
}

enum TitleActionMenuAudioPlayer: String {
    case removeFromLybrary = "Remove from lybrary"
    case download = "Download"
    case addToAPlaylist = "Add to a Playlist..."
    case shareSong = "Share Song..."
    case love = "Love"
    case unloved = "Unlove"
}

enum TitleActionMenuTracker: String {
    case play = "Play"
    case download = "Download"
    case eliminateFromPlaylist = "Eliminate from Playlist"
}
