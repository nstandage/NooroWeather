//
//  NoCityView.swift
//  NooroWeather
//
//  Created by Nathan on 12/18/24.
//

import SwiftUI

struct NoCityView: View {
    var body: some View {
		VStack {
			Text("No City Selected")
				.font(.largeTitle)
				.bold()
			Text("Please Seach For A City")
				.font(.subheadline)
				.bold()
		}
    }
}

