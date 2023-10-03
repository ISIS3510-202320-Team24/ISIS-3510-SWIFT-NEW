import Foundation
import Combine

struct AlertResponse: Codable {
    let alert: [Alert]
    
    struct Alert: Codable {
        struct User: Codable {
            let name: String
            let username: String
        }
        
        let active: Bool
        let danger: Int
        let date: String
        let id: String
        let latitude: String
        let longitude: String
        let user: User
    }
}

class HomeViewModel: ObservableObject {
    @Published var alerts: [AlertResponse.Alert] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showAlert = false
    
    private var cancellables: Set<AnyCancellable> = []
    private var timerCancellable: AnyCancellable?
    private var elapsedTime: Int = 0
    
    init() {
        startTimer()
        fetchAlerts()
    }

    func startTimer() {
        timerCancellable = Timer.publish(every: 15, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.elapsedTime += 15
                
                if self.elapsedTime >= 60 {
                    self.timerCancellable?.cancel()
                    print("Timer stopped after 200 seconds")
                } else {
                    self.fetchAlerts()
                }
            }
    }
    
    func fetchAlerts() {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/alert/all") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        self.isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: AlertResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    self.isLoading = false
                    switch completion {
                    case .finished:
                        print("Fetching alerts completed")
                    case .failure(let error):
                        print("Error fetching alerts: \(error)")
                        self.error = error
                    }
                } receiveValue: { response in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
                    
                    let currentTime = Date()
                    let filteredAlerts = response.alert.filter { alert in
                        if let alertDate = dateFormatter.date(from: alert.date) {
                            let timeInterval = currentTime.timeIntervalSince(alertDate)
                            print("Alert Date: \(alertDate)")
                            print("Time Interval: \(timeInterval)")
                            let isWithinTimeInterval = timeInterval <= 100
                            print("Is Within Time Interval: \(isWithinTimeInterval)")
                            return isWithinTimeInterval
                        }
                        return false
                    }

                    self.alerts = filteredAlerts
                    self.showAlert = !filteredAlerts.isEmpty
                    print("Show Alert: \(self.showAlert)")
                }
                .store(in: &cancellables)
    }
    
    deinit {
        timerCancellable?.cancel()
    }
}

