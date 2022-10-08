//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/26/22.
//

import UIKit

class InfoViewController: UIViewController {
    
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
        stackView.spacing = 12
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        label.text = InfoData.text[-1] ?? "No Text"
        label.frame = CGRect(x: 0, y: 0, width: 218, height: 24)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = myHabitsFonts.title3
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(
            string: label.text ?? "No Text",
            attributes: [NSAttributedString.Key.kern: 0.38,
                NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var textLabel = UILabel()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.29).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Информация"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.topSeparator)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabelView)
        self.titleLabelView.addSubview(self.titleLabel)
        
        for key in InfoData.text.keys.sorted() {
            guard key >= 0 else { continue }
//            print("\(key)")

            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: 343, height: 66)
            label.backgroundColor = .white
            label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            label.font = myHabitsFonts.body
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.01
            label.attributedText = NSMutableAttributedString(
                string: textChooser(forParagraphNumber: key),
                attributes: [NSAttributedString.Key.kern: -0.41,
                    NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
            textLabel = label
//            let view = UIView()
//            view.addSubview(textLabel)
            
            self.stackView.addArrangedSubview(textLabel)
        }
        
        self.view.addSubview(self.bottomSeparator)
        
        NSLayoutConstraint.activate([
            
            self.topSeparator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            self.scrollView.topAnchor.constraint(equalTo: self.topSeparator.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomSeparator.topAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1.0),
            
            self.titleLabelView.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            self.titleLabelView.heightAnchor.constraint(equalToConstant: 50),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.titleLabelView.topAnchor, constant: 22),
            
            self.bottomSeparator.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -1),
            self.bottomSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottomSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
    private func textChooser (forParagraphNumber: Int) -> String {
        let text: String = InfoData.text[forParagraphNumber] ?? "No Text"
        return text
    }
}
