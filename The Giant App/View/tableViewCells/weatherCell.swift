//
//  weatherCell.swift
//  The Giant App
//
//  Created by Berkat Bhatti on 11/30/20.
//  Copyright © 2020 Berkat Bhatti. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    @IBOutlet weak var weatherImage:
    UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(weather: Weather) {
        self.conditionLabel.text = weather.condition
        self.temperatureLabel.text = weather.tempString
        self.weatherImage.image = UIImage(systemName: weather.imageId)
    }
}
