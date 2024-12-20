//
//  CitySeachView.swift
//  NooroWeather
//
//  Created by Nathan on 12/18/24.
//

import SwiftUI

struct CitySeachItemView: View {
	var viewModel: CitySearchListViewModel.ItemViewModel
	let actionReceiver: ViewActionReceiver
	
    var body: some View {
		HStack {
			VStack {
				Text(viewModel.cityName)
					.font(.system(size: 26))
				Text(viewModel.temp)
					.font(.system(size: 50))
					.bold()
			}
			.padding()
			Spacer()
			WeatherConditionImage(url: viewModel.imageName, size: 100)
		}
		.background(Color.gray.opacity(0.1))
		.cornerRadius(30)
		.onTapGesture {
			actionReceiver.send(action: .getCity(viewModel.cityName))
		}
    }
}
