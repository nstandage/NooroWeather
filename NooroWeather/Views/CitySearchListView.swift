//
//  CitySearchListView.swift
//  NooroWeather
//
//  Created by Nathan on 12/19/24.
//

import SwiftUI

struct CitySearchListView: View {
	let viewModel: CitySearchListViewModel
	let actionReceiver: ViewActionReceiver
    var body: some View {
		ForEach(viewModel.items, id: \.cityName) { viewModel in
			CitySeachItemView(viewModel: viewModel, actionReceiver: actionReceiver)
		}
		Spacer()
    }
}
