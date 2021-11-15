//
//  TrackTableViewCell.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 04/11/2021.
//

import Foundation
import UIKit

class TrackTableViewCell: UITableViewCell{
    
    private var track: Track
    private var parent: ButtonOnCellDelegate
    
    private var audioTrackImage: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var artistLabel: UILabel = UILabel()
    private var playButton: UIButton = UIButton(type: .custom)
    
    init(track: Track, parent: ButtonOnCellDelegate, reuseIdentifier: String){
        self.track = track
        self.parent = parent
            
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        //self.textLabel?.text = track.title
        //self.textLabel?.textColor = UIColor.white
        
        setAudioTrackImage()
        setTitleLabel()
        setArtistLabel()
        setPlayButton()
        
        self.backgroundColor = UIColor.black
    }
    
    private func setAudioTrackImage(){
        self.audioTrackImage.image = UIImage(named: Resource.audioTrackIcon)
        self.audioTrackImage.backgroundColor = .white
        //self.audioTrackImage.autoresizingMask = .flexibleWidth
        self.audioTrackImage.translatesAutoresizingMaskIntoConstraints=false
        //self.audioTrackImage.frame = CGRect(x: 5, y: 5, width: 30, height: 60)
        self.contentView.addSubview(self.audioTrackImage)
        NSLayoutConstraint.activate([
            self.audioTrackImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            self.audioTrackImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            self.audioTrackImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            self.audioTrackImage.widthAnchor.constraint(equalTo: self.audioTrackImage.heightAnchor)
        ])
    }
    
    private func setTitleLabel(){
        titleLabel.text = self.track.title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = .white
        
        //titleLabel.autoresizingMask = .flexibleWidth
        titleLabel.translatesAutoresizingMaskIntoConstraints=false
        //titleLabel.frame=CGRect(x: 100, y: -10, width: 100, height: 50)
        //titleLabel.textAlignment = .left
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: audioTrackImage.trailingAnchor, constant: 10),
            //titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -5)
        ])
    }
    
    private func setArtistLabel(){
        artistLabel.text = self.track.artist
        artistLabel.font = UIFont.systemFont(ofSize: 18)
        artistLabel.textColor = .gray
        
        //artistLabel.autoresizingMask = .flexibleWidth
        artistLabel.translatesAutoresizingMaskIntoConstraints=false
        //artistLabel.frame=CGRect(x: 100, y: 20, width: 100, height: 50)
        //artistLabel.textAlignment = .left
        self.contentView.addSubview(artistLabel)
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            artistLabel.heightAnchor.constraint(equalToConstant: 35),
            artistLabel.leadingAnchor.constraint(equalTo: audioTrackImage.trailingAnchor, constant: 10),
            //artistLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -5)
        ])
    }
    
    private func setPlayButton(){
        let buttonImage = UIImage(named: Resource.playCircleIcon)
        playButton.setImage(buttonImage, for: .normal)
        //playButton.autoresizingMask = .flexibleWidth
        playButton.translatesAutoresizingMaskIntoConstraints=false
        //playButton.frame=CGRect(x: 265, y: -10, width: 90, height: 90)
        playButton.addTarget(self, action: #selector(playButtonTouch), for: .touchUpInside)
        self.contentView.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
    }
    
    @objc private func playButtonTouch(){
        self.parent.buttonTouchedOnCell(tableViewCell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
