import SwiftUI

//@MainActor
class DataModel: ObservableObject, Codable {
    private static let savePathList = FileManager.documentDirectory.appendingPathComponent("savedData")
    
    
    

    @Published var todaysPoints: Int = 0 {
        didSet {
            save()
        }
    }

    @Published var todaysWordCount: Int = 0 {
        didSet {
            save()
        }
    }

    private var timer: Timer?

    init() {
        load()
//        setupResetTimer()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: DataModel.savePathList)
        } catch {
            print("Error saving data: \(error)")
        }
    }

    private func load() {
        do {
            let data = try Data(contentsOf: DataModel.savePathList)
            let decodedData = try JSONDecoder().decode(DataModel.self, from: data)
            todaysPoints = decodedData.todaysPoints
            todaysWordCount = decodedData.todaysWordCount
        } catch {
            print("Error loading data: \(error)")
        }
    }

//    private func setupResetTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
//            // Reset properties to zero every minute
//            self?.resetProperties()
//        }
//    }

    private func resetProperties() {
        todaysPoints = 0
        todaysWordCount = 0
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        todaysPoints = try container.decode(Int.self, forKey: .todaysPoints)
        todaysWordCount = try container.decode(Int.self, forKey: .todaysWordCount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(todaysPoints, forKey: .todaysPoints)
        try container.encode(todaysWordCount, forKey: .todaysWordCount)
    }

    private enum CodingKeys: String, CodingKey {
        case todaysPoints
        case todaysWordCount
    }
}
