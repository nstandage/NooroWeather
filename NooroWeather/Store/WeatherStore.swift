//
//  WeatherStore.swift
//  Nooro Weather App - Nathan Standage
//
//  Created by Nathan on 12/17/24.
//

import Foundation

enum WeatherStoreError: Error {
	case noStoredCity
	case dataNotFound
	case cityNotFound
}
class WeatherStore {
	var networkService: WeatherNetworkService
	var modelReceiver: ModelReciever?
	private let cityNameKey = "cityName"
	private var isStored = false
	
	init(networkService: WeatherNetworkService) {
		self.networkService = networkService
	}

	func getStoredCityData() {
		if let cityName = UserDefaults.standard.string(forKey: cityNameKey) {
			isStored = true
			getWeatherDataByCityName(cityName)
		} else {
			modelReceiver?.send(WeatherStoreError.noStoredCity)
		}
	}
	
	func getWeatherDataByCityName(_ cityName: String?) {
		guard let cityName = cityName else {
			modelReceiver?.send(WeatherStoreError.cityNotFound)
			return
		}
		networkService.fetchWeatherBy(cityName: cityName)
	}
	
	private func setStoredCity(cityName: String?) {
		guard let cityName = cityName else { return }
		UserDefaults.standard.setValue(cityName, forKey: cityNameKey)
	}
}

extension WeatherStore: WeatherResponseReceiver {
	func send(_ result: Result<Data, WeatherNetworkError>) {
		switch result {
		case .success(let data):
			let serviceModel = try? JSONDecoder().decode(WeatherModel.self, from: data)
			setStoredCity(cityName: serviceModel?.location.name)
			if isStored {
				modelReceiver?.send(storedModel: serviceModel)
			} else {
				modelReceiver?.send(serviceModel)
			}
		case .failure(let error):
			modelReceiver?.send(error)
		}
		isStored = false
	}
}

