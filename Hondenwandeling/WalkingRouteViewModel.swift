import Foundation

struct WalksResponse: Decodable {
    let walks: [WalkRoute]
}

struct WalkRoute: Identifiable, Decodable {
    let id: UUID
    let name: String
    let city: String
    let latitude: Double
    let longitude: Double
    let distance_km: Double
    let description: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case name, city, latitude, longitude, distance_km, description, type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID() 
        self.name = try container.decode(String.self, forKey: .name)
        self.city = try container.decode(String.self, forKey: .city)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.distance_km = try container.decode(Double.self, forKey: .distance_km)
        self.description = try container.decode(String.self, forKey: .description)
        self.type = try container.decode(String.self, forKey: .type)
    }
}


class WalkingRouteViewModel: ObservableObject {
    @Published var nearbyRoutes: [WalkRoute] = []
    @Published var filteredRoutes: [WalkRoute] = []

    init() {
        fetchRoutes()
    }

    func fetchRoutes() {
        guard let url = URL(string: "https://fleurvandeville.github.io/hondenwandelroutes-api/hondenwandelroutes.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(WalksResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.nearbyRoutes = decoded.walks
                        self.filterRoutesForClosestCity()
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error)
            }
        }.resume()
    }

    func filterRoutesForClosestCity() {
        guard let closest = nearbyRoutes.min(by: { $0.distance_km < $1.distance_km }) else {
            self.filteredRoutes = []
            return
        }

        let targetCity = closest.city
        self.filteredRoutes = nearbyRoutes.filter { $0.city == targetCity }
    }
}

