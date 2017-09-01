

import UIKit

protocol WorkoutCreationViewControllerDelegate: class {
    func save(workout: Workout)
}

class WorkoutCreationViewController: UIViewController {

    weak var delegate: WorkoutCreationViewControllerDelegate?
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var dateField: UITextField!
    @IBOutlet private weak var minutesLabel: UILabel!
    @IBOutlet private weak var minutesStepper: UIStepper!
    @IBOutlet private weak var caloriesStepper: UIStepper!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var addWorkoutButton: UIButton!
    @IBOutlet fileprivate weak var tappableBackgroundView: UIView!
    
    private var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure date picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)

        // Configure date text field
        dateField.inputView = datePicker   // use picker as input view
        dateField.text = datePicker.date.toString(format: .yearMonthDay)  // uses toString() extension I made
        
        // Configure minutes stepper and label
        minutesStepper.minimumValue = 2
        minutesStepper.maximumValue = 90
        minutesStepper.value = 10
        minutesLabel.text = "\(Int(minutesStepper.value))"

        // Calories per minute 
        caloriesStepper.minimumValue = 1
        caloriesStepper.maximumValue = 90
        caloriesStepper.value = 5
        caloriesLabel.text = "\(Int(caloriesStepper.value))"
        
        // Configure tappable background when keyboard or picker is displayed
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tappableBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        tappableBackgroundView.isHidden = true

        // Configure delegates
        nameField.delegate = self
        dateField.delegate = self
    }
    
    @IBAction private func minutesValueChanged(_ sender: UIStepper) {
        minutesLabel.text = "\(Int(sender.value))"
    }
    @IBAction private func calorieValueChanged(_ sender: UIStepper) {
        caloriesLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction private func addWorkoutButtonTapped(_ sender: UIButton) {
        var name = nameField.text ?? ""
        if name == "" { name = "No Name" }
        
        let duration = Int(minutesStepper.value)
        let date = datePicker.date
        let caloriesPerMin = Int(caloriesStepper.value)
        
        let workout = Workout(id: UUID(), name: name, date: date, duration: duration, caloriesPerMin: caloriesPerMin)
        
        delegate?.save(workout: workout)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func dateValueChanged() {
        dateField.text = datePicker.date.toString(format: .yearMonthDay)
    }
    
    @objc private func backgroundTapped() {
        self.view.endEditing(true)  // this actually loops through all this view's subviews and resigns the first responder on all of them
        tappableBackgroundView.isHidden = true
    }


}

extension WorkoutCreationViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tappableBackgroundView.isHidden = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        tappableBackgroundView.isHidden = true
        return true
    }
    
}
