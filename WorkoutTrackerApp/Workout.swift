
import Foundation

struct Workout {
    let id: UUID
    let name: String
    let date: Date
    let duration: Int
    let caloriesPerMin: Int
    func caloriesBurned () -> Int {
        return caloriesPerMin * duration
    }
}

extension Workout {
    func toDictionary() -> JsonDictionary {
        return [
            "id": self.id.uuidString,
            "name": self.name,
            "date": self.date.timeIntervalSince1970,
            "duration": self.duration,
            "caloriesPerMinute": self.caloriesPerMin
        ]
    }
    
    static func createFrom(dict: JsonDictionary) -> Workout? {
        guard
            let idString = dict["id"] as? String,
            let id = UUID(uuidString: idString),
            let name = dict["name"] as? String,
            let timeInterval = dict["date"] as? TimeInterval,
            let duration = dict["duration"] as? Int,
            let caloriesPerMin = dict["caloriesPerMin"] as? Int
        else {
            return nil
        }
        let date = Date(timeIntervalSince1970: timeInterval)
        return Workout(id: id, name: name, date: date, duration: duration, caloriesPerMin: caloriesPerMin)
    }
}
