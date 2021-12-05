//
//  MenuAudioPlayerDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 05/12/2021.
//

import Foundation

protocol MenuAudioPlayerDelegate{
    func deleteLybrary(action: UIAction)
    func downloadSong(action: UIAction)
    func addToPlaylist(action: UIAction)
    func shareSong(action: UIAction)
    func love(action: UIAction)
}
