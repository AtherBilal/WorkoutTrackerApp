
import UIKit


class WorkoutListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var totalCaloriesBurned: UILabel!
    
    
    func decorate(with workout: Workout) {
        nameLabel.text = workout.name
        dateLabel.text = workout.date.toString(format: .yearMonthDay)
        durationLabel.text = "\(workout.duration) minutes"
        totalCaloriesBurned.text = "\(workout.caloriesBurned()) Calories Burned"
    }
}
