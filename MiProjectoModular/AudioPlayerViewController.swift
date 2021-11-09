//
//  AudioPlayerViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController {

    private var audioPlayerLabel: UILabel = UILabel()
    private var playButton: UIButton = UIButton(type: .system)
    private var playSlider: UISlider = UISlider()
    private var volumeLabel: UILabel = UILabel()
    private var volumeSlider: UISlider = UISlider ()
    private var stopButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtiene el alto y ancho de la pantalla que se esta usando
        let w = UIScreen.main.currentMode?.size.width
        let h = UIScreen.main.currentMode?.size.height
        
        self.view.backgroundColor = .white

        self.setAudioPlayerLabel()
        self.setPlayButton()
        self.setStopButton()
        self.setPlaySlider()
        self.setVolumeLabel()
        
    }
    
    private func setAudioPlayerLabel(){
        audioPlayerLabel.text = "AudioPlayer"
        audioPlayerLabel.font = UIFont.systemFont(ofSize: 30)
        
        audioPlayerLabel.autoresizingMask = .flexibleWidth
        audioPlayerLabel.translatesAutoresizingMaskIntoConstraints=true
        audioPlayerLabel.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        audioPlayerLabel.textAlignment = .center
        self.view.addSubview(audioPlayerLabel)
    }
    
    private func setPlayButton(){
        playButton.setTitle("Play", for: .normal)
        playButton.autoresizingMask = .flexibleWidth
        playButton.translatesAutoresizingMaskIntoConstraints=true
        playButton.setTitleColor(UIColor.blue, for: .normal)
        playButton.frame=CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(playButton)
    }
    
    private func setStopButton(){
        stopButton.setTitle("Stop", for: .normal)
        stopButton.autoresizingMask = .flexibleWidth
        stopButton.translatesAutoresizingMaskIntoConstraints=true
        stopButton.frame=CGRect(x: self.view.frame.width-120, y: 100, width: 100, height: 40)
        self.view.addSubview(stopButton)
    }
    
    private func setPlaySlider(){
        playSlider.autoresizingMask = .flexibleWidth
        playSlider.translatesAutoresizingMaskIntoConstraints=true
        playSlider.frame=CGRect(x: 20, y:150, width: self.view.frame.width-40, height: 50)
        self.view.addSubview(playSlider)
    }
    
    private func setVolumeLabel(){
        volumeLabel.text = "Volume"
        volumeLabel.font = UIFont.systemFont(ofSize: 18)
        
        volumeLabel.autoresizingMask = .flexibleWidth
        volumeLabel.translatesAutoresizingMaskIntoConstraints=true
        volumeLabel.frame=CGRect(x: 20, y: 200, width: 100, height: 50)
        volumeLabel.textAlignment = .left
        self.view.addSubview(volumeLabel)
    }
    
    private func setvolumeSlider(){
        volumeSlider.autoresizingMask = .flexibleWidth
        volumeSlider.translatesAutoresizingMaskIntoConstraints=true
        volumeSlider.frame=CGRect(x: 20, y:250, width: self.view.frame.width/2, height: 50)
        self.view.addSubview(volumeSlider)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
