//
//  WeatheViewBuilder.swift
//  NooroWeather
//
//  Created by Nathan on 12/19/24.
//

import Foundation
import SwiftUI

enum ViewType {
	case cityView(CityViewModel)
	case noCityView
	case noResultsView
	case citySearchView(CitySearchListViewModel, ViewActionReceiver)
}
class WeatherViewBuilder: ObservableObject {
	@Published var activeView: AnyView = AnyView(NoResultsView())
//	
//	
//	init() {
//		let seconds = 4.0
//		DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//			self.activeView = AnyView(NoCityView())
//		}
//	}
	
	func send(viewType: ViewType) {
		switch viewType {
		case .cityView(let cityViewModel):
			activeView = AnyView(CityView(viewModel: cityViewModel))
		case .noCityView:
			activeView = AnyView(NoCityView())
		case .noResultsView:
			activeView = AnyView(NoResultsView())
		case .citySearchView(let cityListViewModel, let actionReceiver):
			activeView = AnyView(CitySearchListView(viewModel: cityListViewModel, actionReceiver: actionReceiver))
		}
	}
}
