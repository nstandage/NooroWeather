//
//  WeatherConditionImage.swift
//  NooroWeather
//
//  Created by Nathan on 12/19/24.
//

import SwiftUI

struct WeatherConditionImage: View {
	var url: String
	var size: CGFloat
    var body: some View {
		AsyncImage(url: URL(string: url)) { phase in
			switch phase {
			case .failure:
				Image(systemName: "photo")
					.font(.largeTitle)
			case .success(let image):
				image
					.resizable()
					.frame(width: size, height: size)
			default:
				ProgressView()
			}
		}
    }
}
