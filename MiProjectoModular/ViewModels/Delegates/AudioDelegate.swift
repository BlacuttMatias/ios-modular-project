//
//  AudioDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 19/11/2021.
//

import Foundation

protocol AudioDelegate: AnyObject{
    func onChangePlayingState()
    func onChangeCurrentTimeSong(updatedCurrentTime: Float)
    func onSongFinished()
}
