//
//  WeatherApplication.swift
//  Nooro Weather App - Nathan Standage
//
//  Created by Nathan on 12/17/24.
//

import Foundation
import SwiftUI

class WeatherApplication: ObservableObject {
	private let store: WeatherStore
	private var currentModel: WeatherModel?
	let viewBuilder: WeatherViewBuilder
	
	init(store: WeatherStore,
		 viewBuilder: WeatherViewBuilder) {
		self.store = store
		self.viewBuilder = viewBuilder
	}
	func start() {
		store.getStoredCityData()
	}
}

extension WeatherApplication: ViewActionReceiver {
	func send(action: WeatherAction) {
		switch action {
		case .searchForCity(let cityName):
			store.getWeatherDataByCityName(cityName)
		case .getCity(let name):
			guard name == currentModel?.location.name ?? "" else { return }
			let viewModel = buildCityViewModel(modelData: currentModel)
			viewBuilder.send(viewType: .cityView(viewModel))
		}
	}
	
	private func buildCityViewModel(modelData: WeatherModel?) -> CityViewModel {
		let urlString = prepareUrlString(modelData?.current.condition.iconUrl)
		return CityViewModel(
			cityName: modelData?.location.name ?? "",
			temp: String(Int(modelData?.current.temperature ?? 0)) + "˚",
			imageName: urlString,
			humitityPercentage: String(Int(modelData?.current.humidity ?? 0)) + "%",
			uvIndex: String(Int(modelData?.current.UVIndex ?? 0)),
			feelsLikeTemp: String(Int(modelData?.current.feelsLike ?? 0)) + "˚"
		)
	}
}

extension WeatherApplication: ModelReciever {
	func send(_ model: WeatherModel?) {
		currentModel = model
		let viewModel = buildCityListModel(model)
		viewBuilder.send(viewType: .citySearchView(viewModel, self))
	}
	
	private func buildCityListModel(_ model: WeatherModel?) -> CitySearchListViewModel {
		let updatedUrlString = prepareUrlString(model?.current.condition.iconUrl)
		return CitySearchListViewModel(items: [
			.init(
				cityName: model?.location.name ?? "",
				temp: String(Int(model?.current.temperature ?? 0)) + "˚",
				imageName: updatedUrlString
			)
		])
	}
	
	
	private func prepareUrlString(_ url: String?) -> String {
		let urlString = url ?? ""
		return "https:" + urlString
	}
	
	func send(storedModel model: WeatherModel?) {
		currentModel = model
		let viewModel = buildCityViewModel(modelData: model)
		viewBuilder.send(viewType: .cityView(viewModel))
	}
	
	func send(_ error: any Error) {
		viewBuilder.send(viewType: .noCityView)
	}
}
