//
//  MenuTrackerDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 06/12/2021.
//

import Foundation

protocol MenuTrackerDelegate: AnyObject{
    func playSong(action: UIAction)
    func downloadSong(action: UIAction)
    func eliminateFromPlaylist(action: UIAction)
}
