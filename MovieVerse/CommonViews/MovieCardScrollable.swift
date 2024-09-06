import SwiftUI

struct MovieCardScrollable: View {
    @ObservedObject var movies_Data: MoviesViewModel
    var index: Int
    var movie: MovieItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let path = movie.poster_path {
                AsyncImage(url: movies_Data.getBackdropPath(path: path)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 250)
                        .cornerRadius(30)
                    //Text(movie.dates)
                } placeholder: {
                    VStack{
                        Spacer()
                        ProgressView()
                            .tint(.white)
                            .padding()
                            .frame(width: 200, height: 300)
                        Spacer()
                    }
                    
                }
                
                //.background(Color.yellow)
                
                Text("\(index + 1)")
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(10)
                    .overlay(
                        // Blue outline effect
                        Text("\(index + 1)")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .foregroundColor(.clear)
                            .background(
                                Text("\(index + 1)")
                                    .font(.system(size: 100))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("BackgroundColor"))
                                
                            )
                            .mask(Text("\(index + 1)").font(.system(size: 100)))
                    )
                    .padding([.bottom, .leading], -30)
                    .padding(.bottom, -15)
                
            }
        }
        .frame(height: 350)
        .onAppear(perform: {
            // start from 1
            movies_Data.upComCount = index + 1
            Task{
                await movies_Data.getUpcomingMovies()
            }
        })
        //.background(Color.green)
    }
}

//#Preview {
//    MovieCardScrollable(movies_Data: MoviesViewModel(), index: 1, movie: MovieItem(poster_path: ""))
//}
