//
//  TrackerTableViewController.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 03/11/2021.
//

import UIKit

class TrackerTableViewController: UITableViewController {

    var trackerViewModel: TrackerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentLoadingAlert()
        
        self.trackerViewModel = TrackerViewModel(apiManager: ApiManager.getInstance(), trackerDelegate: self)
         
        //self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func presentLoadingAlert(){
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.trackerViewModel?.getNumberOfSections() ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.trackerViewModel?.getNumberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        let cell = trackerViewModel?.getTrackViewCell(index: indexPath.row) ?? UITableViewCell()

        //let track = tracks[indexPath.row]
        //cell.textLabel?.text = track.title
        //cell.textLabel?.textColor = UIColor.white
        //cell.backgroundColor = UIColor.black

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrackerTableViewController: ButtonOnCellDelegate {
    func buttonTouchedOnCell(tableViewCell: TrackTableViewCell) {
        guard let trackerViewModel = self.trackerViewModel else{
            return
        }
        self.present(trackerViewModel.getAudioPlayerViewController(currentTrack: tableViewCell.getTrack()), animated: true)
    }
}

extension TrackerTableViewController: TrackerDelegate {

    func dismissLoadingAlert() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func reloadDataTable() {
        self.tableView.reloadData()
    }
    
}

