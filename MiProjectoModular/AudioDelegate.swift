//
//  AudioDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 19/11/2021.
//

import Foundation

protocol AudioDelegate{
    func OnChangePlayingState()
    func OnChangeCurrentTimeSong(updatedCurrentTime: Float)
}
