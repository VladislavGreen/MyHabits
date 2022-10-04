//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/29/22.
//

import UIKit

class HabitViewController: UIViewController {
    
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
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var habitNameView = UIView()
    
    private lazy var habitName: UILabel = {
        let titleLabel = UILabel()
//        titleLabel.text = "НАЗВАНИЕ"
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
    
    private lazy var habitNameText = "Бегать по утрам, спать 8 часов и т.п."
    
    private lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
//        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = myHabitsFonts.body
        textField.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
//        textField.delegate = self
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        textField.attributedText = NSMutableAttributedString(
            string: habitNameText,
            attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        textField.addTarget(
            self,
            action: #selector(habitNameChanged(_:)),
            for: UIControl.Event.editingChanged)
        textField.clearsOnBeginEditing = true
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
    
    private lazy var habitColor = UIColor()
    
    private lazy var habitColorButton: UIButton = {
        let button = UIButton()
        let size:CGFloat = 30.0
        button.frame = CGRect(x: 0, y: 0, width: size, height: size)
        button.layer.cornerRadius = size / 2
        button.layer.backgroundColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1).cgColor
        button.layer.borderColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1).cgColor
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
        // Line height: 18 pt
        // (identical to box height)
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
        datePicker.addTarget(self, action: #selector(self.didChooseDate), for: .valueChanged)
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupGestures()
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
        let createButton: UIBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(save))
        self.navigationItem.rightBarButtonItem = createButton;
        
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
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
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
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func habitNameChanged(_: UITextField) {
        habitNameText = habitNameTextField.text ?? "Название привычки не задано"
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

