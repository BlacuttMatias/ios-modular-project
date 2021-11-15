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
            return Resource.pauseCircleOutline
        }
        else{
            return Resource.playCircleIcon
        }
    }
    
    func getImagePlaying() -> Image?{
        guard let sound = self.sound else{
            return nil
        }
        if(sound.playing){
            return ImageGif(resource: Resource.imagePlayingGif)
        }
        else{
            return ImageAsset(named: Resource.audioPlayingImage)
        }
    }
    
}
