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
    var playlistPickerView: UIPickerView = UIPickerView()
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

        self.setAddSongButton()
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
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let confirmButton = UIBarButtonItem()
        let cancelButton = UIBarButtonItem()
        
        confirmButton.image = UIImage(named: Resource.confirmIcon)
        confirmButton.tintColor = .blue
        cancelButton.image = UIImage(named: Resource.cancelIcon)
        cancelButton.tintColor = .red

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([cancelButton, spaceButton, confirmButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    private func setSongTextField(){
        songTextField.placeholder = "Add a song..."
        songTextField.borderStyle = .roundedRect
        songTextField.font = UIFont.systemFont(ofSize: 20)
        songTextField.inputView = self.playlistPickerView
        songTextField.inputAccessoryView = self.playlistPickerView
        songTextField.inputAccessoryView = toolBarPickerView()
        
        self.view.addSubview(songTextField)
        
        let constraintSetter = ConstraintsSetter(uiView: songTextField)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 50)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: self.view.leadingAnchor, distance: 30)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.addSongButton.leadingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 50)

    }
    
    @objc private func donePicker(){}
    
    private func setAddSongButton(){
        let imageButton = UIImage(named: Resource.playlistAddIcon)
        addSongButton.setImage(imageButton, for: .normal)
        addSongButton.setBlueIcon()
        
        self.view.addSubview(addSongButton)
        
        self.addSongButton.addTarget(self, action: #selector(addSongButtonTouch), for: .touchUpInside)
        
        let constraintSetter = ConstraintsSetter(uiView: addSongButton)
        constraintSetter.setTopEqualContraint(referenceAnchorView: self.view.topAnchor, distance: 50)
        constraintSetter.setRightEqualContraint(referenceAnchorView: self.view.trailingAnchor, distance: -20)
        constraintSetter.setHeightConstraint(height: 50)
        constraintSetter.setWidthConstraint(width: 50)

    }
    
    @objc private func addSongButtonTouch(){
        guard let track = self.trackToAdd else {
            return
        }
        self.playlist.append(track)
        self.playlistTableView.reloadData()
        self.trackToAdd = nil
        self.songTextField.text = ""
        self.view.endEditing(true)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
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
        self.view.endEditing(true)
    }
    
}

extension PlayListDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.playlistTableView.dequeueReusableCell(withIdentifier: "cellPlaylist") as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = self.playlist[indexPath.row].title
        
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
