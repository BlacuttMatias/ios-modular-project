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
    case remove = "Remove..."
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

enum ErrorSignInUp: String{
    case emptyField = "This field is required"
    case usernameTooLong = "Username must have least than 10 characters"
    case passwordTooLong = "Password must have least than 10 characters"
    case userNotExists = "Incorrect Username or Password"
    case notValidEmail = "Email must have \"@\" and least than 10 characters"
    case usernameAlreadyExists = "Username already exists"
    case emailAlreadyExists = "Email already exists"
}
