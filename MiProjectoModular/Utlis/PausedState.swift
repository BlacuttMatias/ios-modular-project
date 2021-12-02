//
//  PausedState.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/11/2021.
//

import Foundation

class PausedState: AudioState{

    weak var audioPlayer: AudioPlayerManager?

    required init(audioPlayer: AudioPlayerManager) {
        self.audioPlayer = audioPlayer
    }
    
    required init(){
        
    }
    
    private func changeStateToPlayingState(){
        guard let audioPlayer = self.audioPlayer else {
            return
        }
        audioPlayer.changeTo(audioState: PlayingState(audioPlayer: audioPlayer))
    }
    
    func changePlayingState() {
        self.audioPlayer?.resume()
        self.changeStateToPlayingState()
    }
    
    func getEnabledActionImageName() -> String {
        return Resource.playCircleIcon
    }
    
    func getImagePlaying() -> Image {
        return ImageAsset(named: Resource.audioPlayingImage)
    }

    func newSoundSetted() {
        self.audioPlayer?.pause()
    }
    
}
