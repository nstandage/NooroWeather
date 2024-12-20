//
//  CityView.swift
//  NooroWeather
//
//  Created by Nathan on 12/18/24.
//

import SwiftUI

struct CityView: View {
	let viewModel: CityViewModel
    var body: some View {
		VStack {
			WeatherConditionImage(url: viewModel.imageName, size: 160)
			HStack {
				Text(viewModel.cityName)
					.font(.system(size: 30))
					.bold()
				Image(systemName: "location.fill")
			}
			Text(viewModel.temp)
				.font(.system(size: 50))
				.bold()
			CityDetailsView(viewModel: viewModel)
		}
    }
}

struct CityDetailsView: View {
	private let titleTextColor = Color.gray.opacity(0.5)
	private let valueTextColor = Color.gray.opacity(0.8)
	let viewModel: CityViewModel
	var body: some View {
		HStack {
			VStack {
				Text("Humidity")
					.foregroundColor(titleTextColor)
				Text(viewModel.humitityPercentage)
					.foregroundColor(valueTextColor)
			}
			.padding()
			VStack {
				Text("UV")
					.foregroundColor(titleTextColor)
				Text(viewModel.uvIndex)
					.foregroundColor(valueTextColor)

			}
			.padding()
			VStack {
				Text("Feels Like")
					.foregroundColor(titleTextColor)
				Text(viewModel.feelsLikeTemp)
					.foregroundColor(valueTextColor)
			}
			.padding()
		}
		.background(Color.gray.opacity(0.1))
		.cornerRadius(12)
	}
}
