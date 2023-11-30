import SwiftUI

//@MainActor
class DataModel: ObservableObject, Codable {
    private static let savePathList = FileManager.documentDirectory.appendingPathComponent("savedData")
    

    @Published var currentPoints: Int = 0 {
        didSet {
            save()
        }
    }
    
    @Published var allTimePossiblePoints: Int = 0 {
        didSet {
            save()
            computeSuccessRate()
        }
    }

    @Published var totalWordCount: Int = 0 {
        didSet {
            save()
        }
    }
    
    @Published var weightedSuccessRate: Double = 0.0 {
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
            currentPoints = decodedData.currentPoints
            totalWordCount = decodedData.totalWordCount
            allTimePossiblePoints = decodedData.allTimePossiblePoints
//            weightedSuccessRate = decodedData.weightedSuccessRate
        } catch {
            print("Error loading data: \(error)")
        }
    
        computeSuccessRate()
        
        
    }
    
    func computeSuccessRate() {
        if allTimePossiblePoints != 0 {
            self.weightedSuccessRate = Double(currentPoints) / Double(allTimePossiblePoints) * 100
        } else {
            self.weightedSuccessRate = 0.0
        }
    }

//    private func setupResetTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
//            // Reset properties to zero every minute
//            self?.resetProperties()
//        }
//    }

    func resetProperties() {
        currentPoints = 0
        totalWordCount = 0
        allTimePossiblePoints = 0
        weightedSuccessRate = 0.0
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentPoints = try container.decode(Int.self, forKey: .todaysPoints)
        totalWordCount = try container.decode(Int.self, forKey: .todaysWordCount)
        allTimePossiblePoints = try container.decode(Int.self, forKey: .totalPossiblePoints)
//        weightedSuccessRate = try container.decode(Double.self, forKey: .weightedSuccessRate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currentPoints, forKey: .todaysPoints)
        try container.encode(totalWordCount, forKey: .todaysWordCount)
        try container.encode(allTimePossiblePoints, forKey: .totalPossiblePoints)
//        try container.encode(weightedSuccessRate, forKey: .weightedSuccessRate)
    }

    private enum CodingKeys: String, CodingKey {
        case todaysPoints
        case todaysWordCount
        case totalPossiblePoints
        case weightedSuccessRate
    }
}
