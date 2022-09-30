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
        stackView.distribution = .fillEqually
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
        // Line height: 18 pt
        // (identical to box height)
        titleLabel.attributedText = NSMutableAttributedString(string: "НАЗВАНИЕ", attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var habitNameTextFieldView = UIView()
    
    private lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
//        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = myHabitsFonts.body
        textField.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        textField.keyboardType = .phonePad
        textField.clearButtonMode = .whileEditing
//        textField.delegate = self
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        // Line height: 22 pt
        // (identical to box height)
        textField.attributedText = NSMutableAttributedString(string: "Бегать по утрам, спать 8 часов и т.п.", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Создать"
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelButton;
        let createButton: UIBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = createButton;
        
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        self.view.addSubview(self.topSeparator)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        
        self.habitNameView.addSubview(habitName)
        self.stackView.addArrangedSubview(self.habitNameView)
        
        self.habitNameTextFieldView.addSubview(self.habitNameTextField)
        self.stackView.addArrangedSubview(self.habitNameTextFieldView)

        NSLayoutConstraint.activate([
            
            self.topSeparator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            self.scrollView.topAnchor.constraint(equalTo: self.topSeparator.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
//            self.stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            
            self.habitNameView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 21),
            self.habitNameView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.habitNameView.heightAnchor.constraint(equalToConstant: 18),
            self.habitNameView.widthAnchor.constraint(equalToConstant: 74),
            
//            self.habitName.heightAnchor.constraint(equalTo: habitNameView.heightAnchor),

            self.habitNameTextFieldView.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 46),
            self.habitNameTextFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.habitNameTextFieldView.heightAnchor.constraint(equalToConstant: 22),
            
//            self.habitNameTextField.heightAnchor.constraint(equalTo: self.habitNameTextFieldView.heightAnchor),

        ])
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func save() {
        self.dismiss(animated: true, completion: nil)
    }
    

    
}
