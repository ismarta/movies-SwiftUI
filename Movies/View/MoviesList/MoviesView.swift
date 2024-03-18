//
//  MoviesListView.swift
//  Movies
//
//  Created by Marta on 15/3/24.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    var body: some View {
        switch viewModel.statusView {
            case .loading:
                LoadingProgressView()
            case .error(let messageText, let buttonText):
                MessageView(imageName: "error", textMessage: messageText, textButton: buttonText, viewModel: viewModel)
            case .success:
                MoviesListView(viewModel: viewModel)
        }
    }
}

struct AsyncImageLoader: View {
    let path: String
    var body: some View {
        AsyncImage(url: URL(string: "\(ImagesConstants.baseURl)\(path)"),
                   content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }, placeholder: {
            LoadingProgressView()
        }).background(Color.black)
    }
}

struct FavoriteImageView: View {
    let isSelected: Bool
    var body: some View {
        let imageName = isSelected ? "favorite_on" : "favorite_off"
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.white)
            .frame(width: 35, height: 35)
    }
}

struct LoadingProgressView: View {
    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            .controlSize(.small)
            .background(Color.black)
            .frame(width: UIScreen.main.bounds.size.width, height: 300)
    }
}

