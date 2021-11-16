//
//  AudioPlayer.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 12/11/2021.
//

import Foundation
import SwiftySound

class AudioPlayer{
    private var sound: Sound?
    private var audioState: AudioState
    
    init(file: String, fileExtension: String){
        self.audioState = PausedState()
        let possibleUrl = Bundle.main.url(forResource: file, withExtension: fileExtension)
        guard let url = possibleUrl else{
            return
        }
        self.sound = Sound(url: url)
    }
    
    func play(){
        self.sound?.play()
        self.audioState = PlayingState(audioPlayer: self)
    }
    
    func pause(){
        self.sound?.pause()
    }
    
    func resume(){
        self.sound?.resume()
    }
    
    func getVolume() -> Float{
        guard let sound = self.sound else{
            return 0
        }
        return sound.volume
    }
    
    func setVolume(volume: Float){
        self.sound?.volume = volume
    }
    
    func changePlayingState(){
        self.audioState.changePlayingState()
    }
    
    func getActionImageName() -> String{
        self.audioState.getEnabledActionImageName()
    }
    
    func getImagePlaying() -> Image?{
        self.audioState.getImagePlaying()
    }
    
    func changeTo(audioState: AudioState){
        self.audioState = audioState
    }

}
