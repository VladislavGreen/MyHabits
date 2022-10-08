//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/29/22.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habitIsNew = Bool()
    
    var habitToEditTag = Int()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.29).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var habitNameView = UIView()
    
    private lazy var habitName: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = myHabitsFonts.footNOTE
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        titleLabel.attributedText = NSMutableAttributedString(
            string: "НАЗВАНИЕ",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var habitNameTextFieldView = UIView()
    
    private lazy var habitNameText = "Бегать по утрам, выпить стакан и.т.п"
    
    private lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = myHabitsFonts.body
        textField.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        textField.keyboardType = .emailAddress
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        textField.attributedText = NSMutableAttributedString(
            string: habitNameText,
            attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        textField.addTarget(
            self,
            action: #selector(habitNameChanged(_:)),
            for: UIControl.Event.editingChanged)
        textField.clearsOnBeginEditing = habitIsNew
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var habitColorNameView = UIView()
    
    private lazy var habitColorName: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = myHabitsFonts.footNOTE
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        titleLabel.attributedText = NSMutableAttributedString(
            string: "ЦВЕТ",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var habitColorButtonView = UIView()
    
    private lazy var habitColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1)
    
    private lazy var habitColorButton: UIButton = {
        let button = UIButton()
        let size:CGFloat = 30.0
        button.frame = CGRect(x: 0, y: 0, width: size, height: size)
        button.layer.cornerRadius = size / 2
        button.layer.backgroundColor = habitColor.cgColor
        button.layer.borderColor = habitColor.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapColorButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var habitTimeView = UIView()
    
    private lazy var habitTime: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = myHabitsFonts.footNOTE
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        titleLabel.attributedText = NSMutableAttributedString(
            string: "ВРЕМЯ",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var habitTimeCommentView = UIView()
    
    private lazy var habitTimeComment: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 194, height: 22)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = myHabitsFonts.body
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: "Каждый день в 11:00 PM",
            attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePickerView = UIView()
    
    private lazy var habitDate = Date()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 375, height: 216))
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.date = habitDate
        datePicker.addTarget(self, action: #selector(self.didChooseDate), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var deleteLabelView = UIView()
    
    private lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.isHidden = habitIsNew
        label.frame = CGRect(x: 0, y: 0, width: 147, height: 22)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 1, green: 0.231, blue: 0.188, alpha: 1)
        label.font = myHabitsFonts.headline
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(
            string: "Удалить привычку",
            attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.isUserInteractionEnabled = true
        let tapDeleteLabel = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteLabel))
        label.addGestureRecognizer(tapDeleteLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alertController = UIAlertController(
        title: "Удалить привычку",
        message: habitNameText,
        preferredStyle: .alert
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupGestures()
        self.setupAlertConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Создать"
        
        let cancelButton: UIBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        if habitIsNew == true {
            let createButton: UIBarButtonItem = UIBarButtonItem(
                title: "Сохранить",
                style: .plain,
                target: self,
                action: #selector(save))
            self.navigationItem.rightBarButtonItem = createButton;
        } else {
            let createButton: UIBarButtonItem = UIBarButtonItem(
                title: "Сохранить",
                style: .plain,
                target: self,
                action: #selector(saveEditedHabit))
            self.navigationItem.rightBarButtonItem = createButton;
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        self.view.addSubview(self.topSeparator)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.deleteLabel)
        
        self.scrollView.addSubview(self.stackView)
        
        self.habitNameView.addSubview(self.habitName)
        self.stackView.addArrangedSubview(self.habitNameView)
        
        self.habitNameTextFieldView.addSubview(self.habitNameTextField)
        self.stackView.addArrangedSubview(self.habitNameTextFieldView)
        
        self.habitColorNameView.addSubview(self.habitColorName)
        self.stackView.addArrangedSubview(self.habitColorNameView)
        
        self.habitColorButtonView.addSubview(self.habitColorButton)
        self.stackView.addArrangedSubview(self.habitColorButtonView)
        
        self.habitTimeView.addSubview(self.habitTime)
        self.stackView.addArrangedSubview(self.habitTimeView)
        
        self.habitTimeCommentView.addSubview(self.habitTimeComment)
        self.stackView.addArrangedSubview(self.habitTimeCommentView)
        
        self.datePickerView.addSubview(self.datePicker)
        self.stackView.addArrangedSubview(self.datePickerView)
        
        NSLayoutConstraint.activate([
            
            self.topSeparator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            self.scrollView.topAnchor.constraint(equalTo: self.topSeparator.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            
            self.deleteLabel.heightAnchor.constraint(equalToConstant: 22),
            self.deleteLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.deleteLabel.widthAnchor.constraint(equalToConstant: 147),
            self.deleteLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),

            self.habitNameView.heightAnchor.constraint(equalToConstant: 21 + 18),
            self.habitName.leadingAnchor.constraint(equalTo: self.habitNameView.leadingAnchor, constant: 16),
            self.habitName.bottomAnchor.constraint(equalTo: self.habitNameView.bottomAnchor),

            self.habitNameTextFieldView.heightAnchor.constraint(equalToConstant: 7 + 22),
            self.habitNameTextField.leadingAnchor.constraint(equalTo: self.habitNameTextFieldView.leadingAnchor, constant: 15),
            self.habitNameTextField.bottomAnchor.constraint(equalTo: self.habitNameTextFieldView.bottomAnchor),
            
            self.habitColorNameView.heightAnchor.constraint(equalToConstant: 15 + 18),
            self.habitColorName.leadingAnchor.constraint(equalTo: self.habitColorNameView.leadingAnchor, constant: 16),
            self.habitColorName.bottomAnchor.constraint(equalTo: self.habitColorNameView.bottomAnchor),
            
            self.habitColorButtonView.heightAnchor.constraint(equalToConstant: 7 + 30),
            self.habitColorButton.leadingAnchor.constraint(equalTo: self.habitColorButtonView.leadingAnchor, constant: 16),
            self.habitColorButton.bottomAnchor.constraint(equalTo: self.habitColorButtonView.bottomAnchor),
            self.habitColorButton.widthAnchor.constraint(equalToConstant: 30),
            self.habitColorButton.heightAnchor.constraint(equalToConstant: 30),
            
            self.habitTimeView.heightAnchor.constraint(equalToConstant: 15 + 18),
            self.habitTime.leadingAnchor.constraint(equalTo: self.habitTimeView.leadingAnchor, constant: 16),
            self.habitTime.bottomAnchor.constraint(equalTo: self.habitTimeView.bottomAnchor),
            
            self.habitTimeCommentView.heightAnchor.constraint(equalToConstant: 7 + 22),
            self.habitTimeComment.leadingAnchor.constraint(equalTo: self.habitTimeCommentView.leadingAnchor, constant: 16),
            self.habitTimeComment.bottomAnchor.constraint(equalTo: self.habitTimeCommentView.bottomAnchor),
            
            self.datePickerView.heightAnchor.constraint(equalToConstant: 15 + 216),
            self.datePickerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func habitNameChanged(_: UITextField) {
        habitNameText = habitNameTextField.text ?? " "
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {

    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc private func didTapColorButton() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc private func didChooseDate() {
        let date = DateFormatter()
        date.dateFormat = "hh:mm a"
        let newText = date.string(from: self.datePicker.date)
        habitDate = self.datePicker.date
        self.habitTimeComment.text = "Каждый день в \(newText)"
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func save() {
        let newHabit = Habit(
            name: habitNameTextField.text ?? "Название привычки не задано",
            date: habitDate,
            color: habitColor
        )
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        self.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: Notification.Name("reloadHabits"), object: nil)
    }
    
    func setHabit (_ withTag: Int) {
        print("Метод установки привычки успешно запустился")
        habitNameText = HabitsStore.shared.habits[withTag].name
        habitColor = HabitsStore.shared.habits[withTag].color
        habitDate = HabitsStore.shared.habits[withTag].date
    }
    
    @objc private func saveEditedHabit() {
        print("Сохраняем отредактированную привычку")
        let habit = HabitsStore.shared.habits[habitToEditTag]
        habit.name = habitNameText
        habit.color = habitColor
        habit.date = habitDate
        HabitsStore.shared.habits[habitToEditTag] = habit
        
        self.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: Notification.Name("reloadHabits"), object: nil)
    }
        
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
           print("Не удаляем")
        }))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in
            print("Удаляем")
            let _ = HabitsStore.shared.habits.remove(at: self.habitToEditTag)
            
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("reloadHabits"), object: nil)
        }))
    }
    
    @objc private func didTapDeleteLabel() {
        print("DeleteLabel button tapped")
        self.present(alertController, animated: true, completion: nil)
    }
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.habitColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
        self.habitColorButton.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        habitColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.habitColorButton.layer.backgroundColor = UIColor.white.cgColor
        self.habitColorButton.layer.borderColor = viewController.selectedColor.cgColor
        
     }
    
    
}

