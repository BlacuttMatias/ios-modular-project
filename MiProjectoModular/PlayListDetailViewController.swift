//
//  PlayListDetailViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 29/11/2021.
//

import UIKit

class PlayListDetailViewController: UIViewController{
    
    var songTextField: UITextField = UITextField()
    var addSongButton: UIButton = UIButton(type: .system)
    var playlistTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playlistTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellPlaylist")

        self.setAddSongButton()
        self.setSongTextField()
        
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        
        self.setPlaylistTableView()
        
    }
    
    private func setSongTextField(){
        songTextField.placeholder = "Add a song..."
        songTextField.borderStyle = .roundedRect
        songTextField.font = UIFont.systemFont(ofSize: 20)
        
        self.view.addSubview(songTextField)
        
        let constraintSetter = ConstraintsSetter(uiView: songTextField)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 50)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 30)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.addSongButton.leadingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 50)

    }
    
    private func setAddSongButton(){
        let imageButton = UIImage(named: Resource.playlistAddIcon)
        addSongButton.setImage(imageButton, for: .normal)
        addSongButton.setBlueIcon()
        
        self.view.addSubview(addSongButton)
        
        let constraintSetter = ConstraintsSetter(uiView: addSongButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 50)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 50)
        constraintSetter.setWidthConstraint(width: 50)

    }
    
    private func setPlaylistTableView(){
        self.playlistTableView.backgroundColor = .cyan
        self.view.addSubview(playlistTableView)
        
        let constraintSetter = ConstraintsSetter(uiView: playlistTableView)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.songTextField.bottomAnchor, distance: 50)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.view.bottomAnchor, distance: -20)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
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

extension PlayListDetailViewController: UITableViewDelegate{
    
}

extension PlayListDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.playlistTableView.dequeueReusableCell(withIdentifier: "cellPlaylist") as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = "self.animals[indexPath.row]"
        
        return cell
    }
    
    
}
