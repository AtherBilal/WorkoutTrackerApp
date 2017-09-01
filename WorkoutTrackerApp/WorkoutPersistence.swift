import Foundation

protocol WorkoutPersistenceInterface {
    var savedWorkouts: [Workout] { get }
    func save(workout: Workout)
}

class WorkoutPersistence: JsonStoragePersistence, WorkoutPersistenceInterface {
    let directoryUrl: URL
    
    init?(atUrl baseUrl: URL, withDirectoryName name: String) {
        guard let directoryUrl = FileManager.default.createDirectory(atUrl: baseUrl, appendingPath: name) else { return nil }
        self.directoryUrl = directoryUrl
    }
    
    var savedWorkouts: [Workout] {
        let jsonDicts = names.flatMap { read(jsonFileWithId: $0) }
        return jsonDicts.flatMap { Workout.createFrom(dict: $0) }
    }
    
    func save(workout: Workout) {
        save(data: workout.toDictionary(), withId: workout.id.uuidString)
    }
}
