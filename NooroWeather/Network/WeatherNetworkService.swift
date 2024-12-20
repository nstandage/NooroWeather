//
//  WeatherNetworkService.swift
//  NooroWeather
//
//  Created by Nathan on 12/17/24.
//

import Foundation


enum WeatherNetworkError: Error {
	case dataNotFound
}

class WeatherNetworkService {
	private let apiKey = "7341f3b970d549f493d00935241812"
	private let baseURL = "https://api.weatherapi.com/v1"
	private let currentWeatherMethod = "/current.json"
	private let errorRange = 400..<500
	var reciever: WeatherResponseReceiver?
	var cityName = "Paris"
	
	func fetchWeatherBy(cityName: String) {
		guard var components = URLComponents(string: baseURL + currentWeatherMethod) else {
			send(.failure(.dataNotFound))
			return
		}
		
		components.queryItems = [
			URLQueryItem(name: "key", value: apiKey),
			URLQueryItem(name: "q", value: cityName)
		]
		
		guard let url = components.url else {
			send(.failure(.dataNotFound))
			return
		}
		
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			
			if let httpResponse = response as? HTTPURLResponse {
				let statusCode = httpResponse.statusCode
				if self?.errorRange.contains(statusCode) ?? false {
					self?.send(.failure(.dataNotFound))
					return
				}
			}
			guard let data = data else {
				self?.send(.failure(.dataNotFound))
				return
			}
			self?.send(.success(data))
	
		}.resume()
	}
	
	private func send(
		_ result: Result<Data, WeatherNetworkError>
	) {
		reciever?.send(result)
	}
}
