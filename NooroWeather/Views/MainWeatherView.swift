//
//  ContentView.swift
//  NooroWeather
//
//  Created by Nathan on 12/19/24.
//

import SwiftUI

struct MainWeatherView: View {
	@ObservedObject private var application: WeatherApplication
	@ObservedObject private var weatherViewBuilder: WeatherViewBuilder
	@State var textFieldText = ""
	
	init(application: WeatherApplication) {
		self.application = application
		self.weatherViewBuilder = application.viewBuilder
	}
	
	var body: some View {
		VStack {
			ZStack {
				TextField(text: $textFieldText) {
					Text("Search Location")
				}.onSubmit {
					application.send(action: .searchForCity(textFieldText))
				}
				.padding()
				.background(Color.gray.opacity(0.1))
				.cornerRadius(12)
				HStack {
					Spacer()
					Image(systemName: "magnifyingglass")
						.foregroundColor(.gray)
						.padding(.trailing, 10)
				}
			}
			Spacer()
			weatherViewBuilder.activeView
			Spacer()
		}
		.padding()
	}
}
