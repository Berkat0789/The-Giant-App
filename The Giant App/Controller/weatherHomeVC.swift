//
//  weatherHomeVC.swift
//  The Giant App
//
//  Created by Berkat Bhatti on 11/30/20.
//  Copyright © 2020 Berkat Bhatti. All rights reserved.
//

import UIKit
import CoreLocation

class weatherHomeVC: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionDescription: UILabel!
    @IBOutlet weak var forecastTebleView: UITableView!
    
    var service = WeatherService()
    let locationManager = CLLocationManager()
    
    var forecast = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        service.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        
        self.forecastTebleView.register(UINib(nibName: K.CellIdentifiers.weatherCell, bundle: nil), forCellReuseIdentifier: K.CellIdentifiers.weatherCell)
        self.navigationItem.title = "Weather or Not"
        
    }
    
}

extension weatherHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newDay = forecast[indexPath.row]
        guard let weatherCell = forecastTebleView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.weatherCell, for: indexPath) as? weatherCell else {return UITableViewCell()}
        weatherCell.updateCell(weather: newDay)
        return weatherCell
    }
}

extension weatherHomeVC: CLLocationManagerDelegate, weatherDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        service.fetchWeatherDatafor(coordinates: locations[0].coordinate)
        service.fetchForecastDataFor(location: locations[0].coordinate)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("The was an error getting user location \(error)")
    }
    
    func didFinishGetting(weather: Weather) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempString
            self.conditionDescription.text = weather.condition
            self.weatherImage.image = UIImage(systemName: weather.imageId)
        }
    }
    func didFinishishGettingForecast(weather: [Weather]) {
        self.forecast = weather
        DispatchQueue.main.async {
            self.forecastTebleView.reloadData()
            
        }
    }
}
