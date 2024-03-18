//
//  MessageView.swift
//  Movies
//
//  Created by Marta on 16/3/24.
//

import SwiftUI

struct MessageView: View {
    let imageName: String
    let textMessage: String
    let textButton: String?
    @ObservedObject var viewModel: MoviesListViewModel

    var body: some View {
        VStack() {
            Image(imageName).resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Spacer().frame(height: 20)
            Text(textMessage)
                .font(.system(size: 17))
                .foregroundColor(.white)
            Spacer().frame(height: 20)
            if let textButton = textButton {
                Button(action: {
                    viewModel.loadMovies()
                }, label: {
                    Text(textButton)
                        .foregroundColor(.white)
                }).buttonStyle(BorderlessButtonStyle())
            }

        }.padding()
    }
}

