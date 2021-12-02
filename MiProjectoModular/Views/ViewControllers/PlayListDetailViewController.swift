//
//  PlayListDetailViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 29/11/2021.
//

import UIKit

class PlayListDetailViewController: UIViewController{
    
    var songTextField: UITextField = UITextField()
    var playlistTableView: UITableView = UITableView()
    var playlistPickerView: UIPickerView = UIPickerView()
    var namePlaylistTextField: UITextField = UITextField()
    var addPlaylistButton: UIButton = UIButton(type: .system)
    var tracks: [Track] = []
    var playlist: [Track] = []
    var trackToAdd: Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadTracksCallback: (([Track]?, Error?) -> ()) = { tracks, error in
            if error != nil {
                print("Error to load songs")
            }
            else{
                self.tracks = tracks ?? []
                DispatchQueue.main.async {
                    self.playlistPickerView.reloadAllComponents()
                }
            }
        }
        
        ApiManager.getInstance().getMusic(completion: loadTracksCallback)
        
        self.playlistTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellPlaylist")

        self.setAddPlaylistButton()
        self.setNamePlaylistTextField()
        
        self.setSongTextField()
        
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        
        self.playlistPickerView.delegate = self
        self.playlistPickerView.dataSource = self
        
        self.setPlaylistTableView()
        
    }
    
    private func toolBarPickerView() -> UIToolbar{
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = UIColor(named: Resource.pickerBackgroundColor)
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let addButton = UIBarButtonItem()
        let cancelButton = UIBarButtonItem()
        
        addButton.image = UIImage(named: Resource.addIcon)
        addButton.tintColor = UIColor(named: Resource.confirmColor)
        addButton.action = #selector(self.addSongAction)
        
        cancelButton.image = UIImage(named: Resource.cancelIcon)
        cancelButton.tintColor = UIColor(named: Resource.cancelColor)
        cancelButton.action = #selector(self.cancelSongAction)

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([cancelButton, spaceButton, addButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    private func setSongTextField(){
        songTextField.placeholder = "Add a song..."
        songTextField.borderStyle = .roundedRect
        songTextField.font = UIFont.systemFont(ofSize: 18)
        songTextField.inputView = self.playlistPickerView
        songTextField.inputAccessoryView = self.playlistPickerView
        songTextField.inputAccessoryView = toolBarPickerView()
        
        self.view.addSubview(songTextField)
        
        self.songTextField.addTarget(self, action: #selector(SongTextFieldTouchUpInside), for: .editingDidBegin)
        
        let constraintSetter = ConstraintsSetter(uiView: songTextField)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.namePlaylistTextField.bottomAnchor, distance: 40)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 50)

    }
    
    @objc private func SongTextFieldTouchUpInside(){
        let indice = self.playlistPickerView.selectedRow(inComponent: 0)
        self.trackToAdd = tracks[indice]
        self.songTextField.text = tracks[indice].title
    }
    
    @objc private func addSongAction(){
        self.view.endEditing(true)
        guard let track = self.trackToAdd else {
            return
        }
        self.playlist.append(track)
        self.playlistTableView.reloadData()
        self.trackToAdd = nil
        self.songTextField.text = ""
    }
    
    @objc private func cancelSongAction(){
        self.songTextField.text = ""
        self.trackToAdd = nil
        self.view.endEditing(true)
    }
    
    @objc private func addSongButtonTouch(){

        self.view.endEditing(true)
    }
    
    private func setPlaylistTableView(){
        self.view.addSubview(playlistTableView)
        
        let constraintSetter = ConstraintsSetter(uiView: playlistTableView)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.songTextField.bottomAnchor, distance: 40)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: 0)
        constraintSetter.setBottomEqualContraint(referenceAnchorView: self.view.bottomAnchor, distance: -60)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.cancelSongAction()
    }
    
    private func setNamePlaylistTextField(){
        namePlaylistTextField.placeholder = "Name Playlist"
        namePlaylistTextField.borderStyle = .roundedRect
        namePlaylistTextField.font = UIFont.systemFont(ofSize: 18)
        
        self.view.addSubview(namePlaylistTextField)
        
        let constraintSetter = ConstraintsSetter(uiView: namePlaylistTextField)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 40)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 20)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.addPlaylistButton.leadingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 40)

    }
    
    private func setAddPlaylistButton(){
        addPlaylistButton.setTitle("Add", for: .normal)
        addPlaylistButton.setActionButtonText(sizeFont: 24)
        
        self.view.addSubview(addPlaylistButton)
        
        let constraintSetter = ConstraintsSetter(uiView: addPlaylistButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 40)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 40)
        constraintSetter.setWidthConstraint(width: 80)

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cancelSongAction()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension PlayListDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = PlaylistTrackViewCell(track: self.playlist[indexPath.row], reuseIdentifier: "cellPlaylist")
        
        return cell
    }
}

extension PlayListDetailViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indice = pickerView.selectedRow(inComponent: 0)
        self.trackToAdd = tracks[indice]
        self.songTextField.text = tracks[indice].title
    }
    
}

extension PlayListDetailViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.tracks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.tracks[row].title
    }
    
    
}
