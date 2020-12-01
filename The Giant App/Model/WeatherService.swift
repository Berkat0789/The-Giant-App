//
//  WeatherService.swift
//  The Giant App
//
//  Created by Berkat Bhatti on 11/30/20.
//  Copyright © 2020 Berkat Bhatti. All rights reserved.
//

import Foundation
import CoreLocation

private let api = "94575f2b659527a9f2e2d58b8a2c7044"

protocol weatherDelegate {
    func didFinishGetting(weather: Weather)
    func didFinishishGettingForecast(weather: [Weather])
}

struct WeatherService {
    
    var delegate: weatherDelegate?
    
    func fetchWeatherDatafor(coordinates: CLLocationCoordinate2D) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(api)&units=imperial"
        print(url)
        fetchWeatherFor(url: url)
    }
    func fetchForecastDataFor(location: CLLocationCoordinate2D) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.latitude)&lon=\(location.longitude)&cnt=10&appid=\(api)&units=imperial"
        print(url)
        fetchForecastData(for: url)
        
    }
    func fetchWeatherFor(url: String) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let task  = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                // There was an error
                print("There was an error getting weather data \(err)")
            } else {
                // There was no error
                guard let data = data else {fatalError("No data retrieved")}
//                guard let dataString = String(data: data, encoding: String.Encoding.utf8) else {return}
//                print(dataString)
                guard let returnedWeather = self.Decode(data: data) else {return}
                self.delegate?.didFinishGetting(weather: returnedWeather)
            }
        }
        task.resume()
    }
    //Function to decode Data
    private func Decode(data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let w = try decoder.decode(WeatherData.self, from: data)
            let weather = Weather(temp: w.main.temp, condition: w.weather[0].description, id: w.weather[0].id, cityName: w.name)
            return weather
        } catch {
            print("There was an error decoding \(error.localizedDescription)")
            return nil
        }
    }
    //Fetching Forecast Data
    func fetchForecastData(for url: String) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let task  = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                // There was an error
                print("There was an error getting weather data \(err)")
            } else {
                // There was no error
                guard let data = data else {fatalError("No data retrieved")}
//                guard let dataString = String(data: data, encoding: String.Encoding.utf8) else {return}
                guard let forecast = self.DecodeForecast(data: data) else {return}
                self.delegate?.didFinishishGettingForecast(weather: forecast)
            }
        }
        task.resume()
    }
    //Decoding Forecast
    private func DecodeForecast(data: Data) -> [Weather]? {
        let decoder = JSONDecoder()
        var weeklyForecast = [Weather]()
        do {
            let fore = try decoder.decode(ForecastData.self, from: data)
            fore.list.forEach { (day) in
                let weather = Weather(temp: day.main.temp, condition: day.weather[0].description, id: day.weather[0].id, cityName: fore.city.name)
                weeklyForecast.append(weather)
            }
            return weeklyForecast
        }catch {
            print("error getting forevast \(error.localizedDescription)")
            return nil
        }
    }
    
    
}
