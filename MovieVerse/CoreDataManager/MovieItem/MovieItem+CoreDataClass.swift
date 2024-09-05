import Foundation
import CoreData


//extension CodingUserInfoKey {
//    static let context = CodingUserInfoKey(rawValue: "context")
//}



@objc(MovieItem)
public class MovieItem: NSManagedObject, Codable {
    // Define the CodingKeys enum to match Core Data properties
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        //case timestamp
        case none
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // Access the managed object context
//        guard let context = CodingUserInfoKey.context,
//              let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext else {
//            fatalError("Failed to decode MovieItem because managed object context was not found.")
//        }
        
        // Initialize NSManagedObject
        //self.init(context: managedObjectContext)
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieItem", in: context)!
        self.init(entity: entity, insertInto: context)
        // Decode properties
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.original_language = try container.decode(String.self, forKey: .originalLanguage)
        self.original_title = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.poster_path = try container.decode(String.self, forKey: .posterPath)
        self.release_date = try container.decode(String.self, forKey: .releaseDate)
        self.title = try container.decode(String.self, forKey: .title)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.vote_average = try container.decode(Double.self, forKey: .voteAverage)
        self.vote_count = try container.decode(Int32.self, forKey: .voteCount)
        //self.genre_ids = try container.decode(NSObject as! any Decodable.self , forKey: .genreIds)
        //self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdrop_path, forKey: .backdropPath)
        try container.encode(id, forKey: .id)
        try container.encode(original_language, forKey: .originalLanguage)
        try container.encode(original_title, forKey: .originalTitle)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(poster_path, forKey: .posterPath)
        try container.encode(release_date, forKey: .releaseDate)
        try container.encode(title, forKey: .title)
        try container.encode(video, forKey: .video)
        try container.encode(vote_average, forKey: .voteAverage)
        try container.encode(vote_count, forKey: .voteCount)
        //try container.encode(timestamp, forKey: .timestamp)
        
        // Decode `genre_ids` from JSON and assign it to `genreIds` property
//        if let genreIdsArray = try? container.decode([Int].self, forKey: .genreIds) {
//            self.genre_ids = genreIdsArray
//        } else {
//            self.genre_ids = []
//        }
    }
}
