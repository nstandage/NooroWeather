//
//  WeatherModels.swift
//  NooroWeather
//
//  Created by Nathan on 12/17/24.
//

import Foundation

struct WeatherModel: Codable {
	struct Location: Codable {
		var name: String
	}
	
	struct Current: Codable  {
		var temperature: Double
		var condition: Condition
		var humidity: Double
		var feelsLike: Double
		var UVIndex: Double
		
		enum CodingKeys: String, CodingKey {
			case temperature = "temp_f"
			case condition
			case humidity
			case feelsLike = "feelslike_f"
			case UVIndex = "uv"
		}
		struct Condition: Codable  {
			var text: String
			var iconUrl: String
			var code: Int
			enum CodingKeys: String, CodingKey {
				case text
				case iconUrl = "icon"
				case code
			}
		}
	}
	
	var location: Location
	var current: Current
	enum CodingKeys: String, CodingKey {
		case location
		case current
	}
}
