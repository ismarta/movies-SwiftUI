//
//  RowView.swift
//  Movies
//
//  Created by Marta on 16/3/24.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    var body: some View {
        List(viewModel.movies, id: \.identifier) { movie in
        VStack(spacing: 0) {
            HStack {
                if let imageBackdropPath = movie.imageBackdropPath {
                    AsyncImageLoader(path: imageBackdropPath)
                }
            }
            Spacer()
            HStack() {
                Text(movie.title)
                    .textCase(.uppercase)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.white)
                Spacer()
            }.padding(EdgeInsets(top: 15.0, leading: 10.0, bottom: 6.0, trailing: 10.0))
            Spacer()
            HStack {
                Image("popCorn")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 46)

                Text("\(movie.voteAverage) / \(movie.voteCount)")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                Spacer()
                Button(action: {
                    viewModel.favoriteButtonPressed(for: movie, isFavorite: movie.isFavorite)
                }, label: {
                    let imageName = movie.isFavorite ? "favorite_on" : "favorite_off"
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .frame(width: 35, height: 35)
                }).buttonStyle(BorderlessButtonStyle())
                Spacer().frame(width: 10)
            }.padding(EdgeInsets(top: 6.0, leading: 10.0, bottom: 6.0, trailing: 10.0))

        }.background(.black)
            .listRowInsets(EdgeInsets())
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.moviePressed(movie: movie)
            }
    }.listStyle(.plain)
        .listRowInsets(EdgeInsets())
        .background(Color.black)
    }
}
