import SwiftUI
import Charts

struct HomeView: View {
    @State private var recentWalks: [RecentWalk] = []
    let name = UserDefaults.standard.string(forKey: "name") ?? "Guest"

    var monthlyWalks: [WalkData] {
        var monthDict: [String: Double] = [:]
        let dateFormatter = ISO8601DateFormatter()

        for walk in recentWalks {
            if let date = dateFormatter.date(from: walk.date) {
                let monthIndex = Calendar.current.component(.month, from: date) - 1
                let monthName = Calendar.current.monthSymbols[monthIndex]
                monthDict[monthName, default: 0] += walk.distance
            }
        }

        return monthDict.map { WalkData(month: $0.key, kilometers: $0.value) }
            .sorted { Calendar.current.monthSymbols.firstIndex(of: $0.month)! < Calendar.current.monthSymbols.firstIndex(of: $1.month)! }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            HomeHeaderView(name: name)
                            ChartSectionView(monthlyWalks: monthlyWalks)

                            Text("Recent Walks")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)

                            if !recentWalks.isEmpty {
                                VStack(spacing: 15) {
                                    ForEach(recentWalks) { walk in
                                        RecentWalkRow(walk: walk)
                                    }
                                }
                                .padding(.bottom, 80)
                            } else {
                                Text("No recent walks yet")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }
                        }
                    }

                    VStack {
                        HStack(spacing: 10) {
                            NavigationLink(destination: WalkingRouteView()) {
                                Text("Find a walking route!")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(red: 0.694, green: 0.874, blue: 0.866), lineWidth: 3)
                                    )
                            }

                            NavigationLink(destination: WalkTrackerView()) {
                                Text("Let's go for a walk!")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                                    .foregroundColor(.black)
                                    .cornerRadius(30)
                            }
                        }
                        .padding(.horizontal, 4)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                    }
                }
            }
        }
        .onAppear {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                if let stored = UserDefaults.standard.array(forKey: "recentWalks") as? [[String: String]] {
                    self.recentWalks = stored.compactMap { RecentWalk(from: $0) }
                }
            }
        }
    }
}

#Preview{
    HomeView()
}
