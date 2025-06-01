import SwiftUI

struct WalkingRouteView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = WalkingRouteViewModel()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.694, green: 0.874, blue: 0.866).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    HeaderView(title: "Dog walking routes", subtitle: locationManager.currentCity, backAction: {
                        print("Back tapped")
                    })

                    Text("Location: \(locationManager.currentCity)")
                        .padding(.horizontal)

                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.filteredRoutes) { route in
                                NavigationLink(destination: FollowRouteView(route: route)) {
                                    RouteRow(route: route)
                                }
                            }
                        }
                    }
                }
                .padding(.top)
            }
        }
    }
}
