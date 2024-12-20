//
//  WeatherViewModels.swift
//  NooroWeather
//
//  Created by Nathan on 12/18/24.
//

import Foundation

struct CityViewModel {
	let cityName: String
	let temp: String
	let imageName: String
	let humitityPercentage: String
	let uvIndex: String
	let feelsLikeTemp: String
}

struct CitySearchListViewModel {
	struct ItemViewModel {
		let cityName: String
		let temp: String
		let imageName: String
	}
	
	var items: [ItemViewModel]
}


