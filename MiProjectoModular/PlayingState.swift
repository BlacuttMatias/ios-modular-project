//
//  PlayingState.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/11/2021.
//

import Foundation

class PlayingState: AudioState{
    
    weak var audioPlayer: AudioPlayerManager?

    required init(audioPlayer: AudioPlayerManager) {
        self.audioPlayer = audioPlayer
    }
    
    required init(){
        
    }
    
    func setAudioPlayer(audioPlayer: AudioPlayerManager){
        self.audioPlayer = audioPlayer
    }
    
    private func changeStateToPausedState(){
        guard let audioPlayer = self.audioPlayer else {
            return
        }
        audioPlayer.changeTo(audioState: PausedState(audioPlayer: audioPlayer))
    }
    
    func changePlayingState() {
        self.audioPlayer?.pause()
        self.changeStateToPausedState()
    }
    
    func getEnabledActionImageName() -> String {
        return Resource.pauseCircleOutline
    }
    
    func getImagePlaying() -> Image {
        return ImageGif(resource: Resource.imagePlayingGif)
    }

}
