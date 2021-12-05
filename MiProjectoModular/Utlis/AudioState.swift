//
//  AudioState.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/11/2021.
//

import Foundation

protocol AudioState{
    
    func changePlayingState()
    func getEnabledActionImageName() -> String
    func getImagePlaying() -> Image
    func newSoundSetted()
    
    init(audioPlayer: AudioPlayerViewModel)
    init()
    
}
