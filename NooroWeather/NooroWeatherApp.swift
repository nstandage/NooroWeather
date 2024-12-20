//
//  NooroWeatherApp.swift
//  NooroWeather
//
//  Created by Nathan on 12/19/24.
//

import SwiftUI

@main
struct NooroWeatherApp: App {
	@StateObject private var application: WeatherApplication = {
		let networkService = WeatherNetworkService()
		let store = WeatherStore(networkService: networkService)
		let viewBuilder = WeatherViewBuilder()
		let application = WeatherApplication(
			store: store,
			viewBuilder: viewBuilder
		)
		store.modelReceiver = application
		networkService.reciever = store
		application.start()
		return application
	}()
    var body: some Scene {
        WindowGroup {
			MainWeatherView(application: application)
        }
    }
}
