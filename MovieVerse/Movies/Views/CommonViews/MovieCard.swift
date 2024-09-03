import SwiftUI

import SwiftUI

struct MovieCard: View {
    @ObservedObject var movies_Data : MoviesViewModel
    var movieImage : URL?
    var title: String
    var description: String
    var rating: Double
    @Binding var count : Int

    var body: some View {
        ZStack {
            // Using AsyncImage for loading the movie image
            AsyncImage(url: movieImage, content: { Image in
                Image
                    .resizable()
//                    .frame(maxWidth: .infinity)
//                    .scaledToFill()
            
            }, placeholder: {
                ProgressView()
            })
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.white)

                Text(description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.white)

                HStack {
                    Text("Rating:")
                        .font(.subheadline)
                        .foregroundColor(.white)

                    Spacer()
                    Text("\(String(format: "%.1f", rating))")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )

            
        }
        .frame(width: 170 , height: 230)
        .cornerRadius(12)
        .onAppear(perform: {
            // to get start from 1
            count = count + 1
            Task{
                await movies_Data.loadMoreData()
            }
        })
        
    }
}

//#Preview {
//    MovieCard(
//        movieImage: URL(string: "https://picsum.photos/300"),
//        title: "Inception",
//        description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
//        rating: 4.5
//    )
//}


#Preview {
    MovieCard(
        movies_Data : MoviesViewModel(),
        movieImage: URL(string: "https://picsum.photos/300"),
        title: "Inception",
        description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
        rating: 4.5, count: Binding.constant(0)
    )
}
