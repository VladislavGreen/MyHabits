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
    
    private lazy var bottomSeparator: UIView = {
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
//        stackView.spacing = 10
//        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        label.text = InfoData.text[-1] ?? "No Text"
        label.frame = CGRect(x: 0, y: 0, width: 218, height: 24)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(
            string: label.text ?? "No Text",
            attributes: [
                NSAttributedString.Key.kern: 0.38,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    private var textLabel = UILabel()
  
    
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
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.titleSeparatorView)
        
        for key in InfoData.text.keys.sorted() {
            guard key >= 0 else { continue }
            print("\(key)")

            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: 343, height: 66)
            label.backgroundColor = .white
            label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            label.font = UIFont(name: "SFProText-Regular", size: 17)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.01
            label.attributedText = NSMutableAttributedString(
                string: textChooser(forParagraphNumber: key),
                attributes: [
                    NSAttributedString.Key.kern: -0.41,
                    NSAttributedString.Key.paragraphStyle: paragraphStyle
                ]
            )
            textLabel = label
            self.stackView.addArrangedSubview(textLabel)
        }
        
           
        
        self.view.addSubview(self.bottomSeparator)

//        for fontFamily in UIFont.familyNames {
//           print(UIFont.fontNames(forFamilyName: fontFamily))
//        }

        
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
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 22),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 218),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 24),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            
//            self.titleSeparatorView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
//            self.titleSeparatorView.widthAnchor.constraint(equalToConstant: 218),
            self.titleSeparatorView.heightAnchor.constraint(equalToConstant: 16),
//            self.titleSeparatorView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            
//            self.textLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            
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
