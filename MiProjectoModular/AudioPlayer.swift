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
    
    init(file: String, fileExtension: String){
        let possibleUrl = Bundle.main.url(forResource: file, withExtension: fileExtension)
        guard let url = possibleUrl else{
            return
        }
        self.sound = Sound(url: url)
    }
    
    func play(){
        self.sound?.play()
    }
    
    func stop(){
        self.sound?.stop()
    }
    
    func setVolume(volume: Float){
        self.sound?.volume = volume
    }
    
    func changePlayingState(){
        guard let sound = self.sound else{
            return
        }
        if(sound.playing){
            sound.pause()
        }
        else{
            sound.resume()
        }
    }
    
    func getActionImageName() -> String{
        guard let sound = self.sound else{
            return ""
        }
        if(sound.playing){
            return "PauseCircleOutline"
        }
        else{
            return "PlayCircleOutline"
        }
    }
    
}
