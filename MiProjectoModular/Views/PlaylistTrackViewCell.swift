//
//  PlaylistTrackViewCell.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 30/11/2021.
//

import UIKit

class PlaylistTrackViewCell: UITableViewCell {

    
    private var track: Track
    
    private var titleLabel: UILabel = UILabel()
    private var artistLabel: UILabel = UILabel()
    
    init(track: Track, reuseIdentifier: String){
        self.track = track
            
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        //self.textLabel?.text = track.title
        //self.textLabel?.textColor = UIColor.white
        
        setTitleLabel()
        setArtistLabel()
        self.backgroundColor = UIColor(named: Resource.backgroundColor)
    }
    
    private func setTitleLabel(){
        titleLabel.text = self.track.title
        titleLabel.setFontSizeIn18()
        titleLabel.textColor = UIColor(named: Resource.labelColor)
        self.contentView.addSubview(titleLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: self.titleLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.topAnchor, distance: 3)
        constraintSetter.setHeightConstraint(height: 35)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.leadingAnchor, distance: 10)
    }
    
    private func setArtistLabel(){
        artistLabel.text = self.track.artist ?? ""
        if(artistLabel.text!.isEmpty){
            artistLabel.text = "Unknown"
        }
        artistLabel.setFontSize(16)
        artistLabel.textColor = .darkGray
        self.contentView.addSubview(artistLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: self.artistLabel)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.topAnchor, distance: 30)
        constraintSetter.setHeightConstraint(height: 35)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.leadingAnchor, distance: 10)
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
