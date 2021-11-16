//
//  PlayingState.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/11/2021.
//

import Foundation

class PlayingState: AudioState{
    
    weak var audioPlayer: AudioPlayer?

    required init(audioPlayer: AudioPlayer) {
        self.audioPlayer = audioPlayer
    }
    
    required init(){
        
    }
    
    func setAudioPlayer(audioPlayer: AudioPlayer){
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
