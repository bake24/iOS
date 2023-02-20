//
//  WeatherManager.swift
//  TH
//
//  Created by Бакдаулет Дуйсенбеков on 08.11.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, with model: WeatherModel)
    
    func didFailWithError(error: Error)
    
}
struct WeatherManager{
    
    var delegate: WeatherManagerDelegate?
    
    func fetchRequest() {
        let link = "https://api.openweathermap.org/data/2.5/weather?lat=43.25667&lon=76.92861&units=metric&appid=8766c7914ea1fc3af240fbe783ff7ef1"
        guard let URL = URL(string: link) else { return }
        let task = URLSession.shared.dataTask(with: URL) {data, response, error in
            if let data {
                print(data)
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(WeatherData.self, from: data)
                    let cityName = decodedData.name
                    let temp = decodedData.main.temp
                    let desc = decodedData.weather[0].description
                    let hTemp = decodedData.main.temp_max
                    let lTemp = decodedData.main.temp_min
                    
                    let weatherModel = WeatherModel(cityName: cityName, temp: temp, desc: desc, hTemp: hTemp, lTemp: lTemp)
                    
                    delegate?.didUpdateWeather(self, with: weatherModel)
                       
                }
                catch{
                    print (error)
                    return
                }
            }
            else {
                print("NOTHING HAS BEEN RETRIEVED!)")
            }
        }
        task.resume()
    }
}

// "https://api.openweathermap.org/data/2.5/weather?lat=43.238949&lon=76.889709&appid=8766c7914ea1fc3af240fbe783ff7ef1"
