//
//  HomeVC.swift
//  The Giant App
//
//  Created by Berkat Bhatti on 11/30/20.
//  Copyright © 2020 Berkat Bhatti. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var appListTable: UITableView!
    
    var apps = [App(name: "Weather App", description: "App developed to get the current weather a a users location or a selected location view search")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "App List"
        self.appListTable.register(UINib(nibName: K.CellIdentifiers.appListXibName, bundle: nil), forCellReuseIdentifier: K.CellIdentifiers.appListCell)
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app  = apps[indexPath.row]
        guard let appCell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.appListCell, for: indexPath) as? appListCell else {return UITableViewCell()}
        appCell.appName.text = app.name
        appCell.appDescription.text = app.description
        return appCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = apps[indexPath.row]
        switch app.name {
        case "Weather App":
            self.performSegue(withIdentifier: K.Segues.appsToWeather, sender: self)
        default:
            return
        }
    }
    
    
}
