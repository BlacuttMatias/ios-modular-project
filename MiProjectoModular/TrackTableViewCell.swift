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
    private var playButton: PlayButton = PlayButton()
    
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
        self.contentView.addSubview(self.audioTrackImage)
        
        let constraintSetter = ConstraintsSetter(uiView: self.audioTrackImage)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.topAnchor, distance: 5)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.bottomAnchor, distance: -5)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.leadingAnchor, distance: 5)
        constraintSetter.setWidthConstraint(width: 65)

    }
    
    private func setTitleLabel(){
        titleLabel.text = self.track.title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = .white
        self.contentView.addSubview(titleLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: self.titleLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.topAnchor, distance: 3)
        constraintSetter.setHeightConstraint(height: 35)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.audioTrackImage.trailingAnchor, distance: 10)
    }
    
    private func setArtistLabel(){
        artistLabel.text = self.track.artist
        artistLabel.font = UIFont.systemFont(ofSize: 18)
        artistLabel.textColor = .gray
        self.contentView.addSubview(artistLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: self.artistLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.topAnchor, distance: 30)
        constraintSetter.setHeightConstraint(height: 35)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.audioTrackImage.trailingAnchor, distance: 10)
    }
    
    private func setPlayButton(){
        playButton.icon = UIImage(named: Resource.playCircleIcon)
        playButton.secondIcon = UIImage(named: Resource.pauseCircleFilled)
        playButton.performTwoStateSelection()
        playButton.addTarget(self, action: #selector(playButtonTouch), for: .touchUpInside)
        self.contentView.addSubview(playButton)
        
        let constraintSetter = ConstraintsSetter(uiView: self.playButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.topAnchor, distance: 10)
        constraintSetter.setWidthConstraint(width: 50)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.bottomAnchor, distance: -10)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.trailingAnchor, distance: -10)
    }
    
    @objc private func playButtonTouch(){
        self.playButton.performTwoStateSelection()
        self.parent.buttonTouchedOnCell(tableViewCell: self)
    }
    
    func getTrack() -> Track{
        return self.track
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
