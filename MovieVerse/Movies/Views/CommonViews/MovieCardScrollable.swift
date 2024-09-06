import SwiftUI

struct MovieCardScrollable: View {
    @ObservedObject var movies_Data: MoviesViewModel
    var index: Int
    var movie: MovieItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let path = movie.poster_path {
                GeometryReader { geometry in
                    AsyncImage(url: movies_Data.getBackdropPath(path: path)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .cornerRadius(30)
                    } placeholder: {
                        ProgressView()
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .frame(width: 240, height: 330)
                //.background(Color.yellow)
                
                Text("\(index + 1)")
                    .font(.system(size: 150))
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(10)
                    .overlay(
                        // Blue outline effect
                        Text("\(index + 1)")
                            .font(.system(size: 150))
                            .fontWeight(.bold)
                            .foregroundColor(.clear)
                            .background(
                                Text("\(index + 1)")
                                    .font(.system(size: 150))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("BackgroundColor"))
                                    
                            )
                            .mask(Text("\(index + 1)").font(.system(size: 150)))
                        )
                    .padding([.bottom, .leading], -50)
                    .padding(.bottom, -15)

            }
        }
        .frame(height: 350)
        //.background(Color.green)
    }
}

//#Preview {
//    MovieCardScrollable(movies_Data: MoviesViewModel(), index: 1, movie: MovieItem(poster_path: ""))
//}
