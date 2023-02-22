//
//  PrevisaoDoTempo.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/22/23.
//

import UIKit

class PrevisaoDoTempo {
    
    struct WeatherData: Codable {
        //let coord: Coord
        let weather: [Weather]
        let main: Main
        let visibility: Int
        //let wind: Wind
        //let clouds: Clouds
        let dt: Int
        //let sys: Sys
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
    }
    
    /*struct Coord: Codable {
        let lon: Double
        let lat: Double
    }*/
    
    struct Weather: Codable {
        //let id: Int
        //let main: String
        let description: String
       //let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        /*let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let sea_level: Int?
        let grnd_level: Int?*/
    }
    
    /*struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type: Int?
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }*/
    
    func getPrevisao(completion: @escaping (Double?, String?, String?) -> Void) {
        let apiKey = "6442204c2436afcc2a5841485c583f0d"
        let city = "Piquete"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=pt_br"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    let temperatura = weatherData.main.temp
                    let condicao = weatherData.weather[0].description
                    let cidade = weatherData.name
                   
                    completion(temperatura, condicao, cidade)
                } catch {
                    print(error)
                    completion(nil, nil, nil)
                }
            }
        }.resume()
    }
}
