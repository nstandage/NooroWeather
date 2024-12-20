//
//  WeatherBoundry.swift
//  Nooro Weather App - Nathan Standage
//
//  Created by Nathan on 12/17/24.
//

import Foundation
import SwiftUI

//App -> ViewBuilder
protocol ViewModelReciever {
	func send(_ view: some View)
}

enum WeatherAction {
	case searchForCity(String)
	case getCity(String)
}
// View -> App
protocol ViewActionReceiver {
	func send(action: WeatherAction)
}

//Store -> App
protocol ModelReciever {
	func send(_ model: WeatherModel?)
	func send(storedModel: WeatherModel?)
	func send(_ error: Error)
}

// App -> Store
protocol StoreReceiver {
	func send(action: WeatherAction)
}

// Network -> Store
protocol WeatherResponseReceiver {
	func send(_ result: Result<Data, WeatherNetworkError>)
}
