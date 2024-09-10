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
            // Using AsyncImage for dynamically loading the movie image
            AsyncImage(url: movieImage, content: { Image in
                Image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 130, maxHeight: .infinity)
                    .cornerRadius(30)
            
            }, placeholder: {
                ProgressView()
                    .tint(.white)
                    .padding()
            })
            
            VStack(alignment: .leading) {
                Spacer()

                HStack {
                    Text(title)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(.white)

                    Spacer()
                    Label("\(String(format: "%.0f", rating))", systemImage: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
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
        .frame(width: 170 , height: 200)
        .cornerRadius(20)
        
    }
}


//#Preview {
//    MovieCard(
//        movies_Data : MoviesViewModel(),
//        movieImage: URL(string: "https://picsum.photos/300"),
//        title: "Inception",
//        description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
//        rating: 4.5, count: Binding.constant(0)
//    )
//}
