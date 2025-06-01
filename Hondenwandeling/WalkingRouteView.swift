import SwiftUI

struct WalkingRouteView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = WalkingRouteViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.694, green: 0.874, blue: 0.866)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Text("Dog walking routes")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                    
                    Text("Location: \(locationManager.currentCity)")
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.filteredRoutes) { route in
                                NavigationLink(destination: FollowRouteView(route: route)) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("\(route.distance_km, specifier: "%.1f") km")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            Text(route.name)
                                                .foregroundColor(.black)
                                            Text(route.type.capitalized)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "map.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.blue)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    WalkingRouteView()
}
