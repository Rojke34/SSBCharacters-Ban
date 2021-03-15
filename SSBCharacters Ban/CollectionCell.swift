//
//  CollectionCell.swift
//  SSBCharacters Ban
//
//  Created by Kevin Rojas on 12/26/17.
//  Copyright © 2017 Kevin Rojas. All rights reserved.
//

import UIKit
import AVFoundation

class CollectionCell: BaseCell {
    var index: Int?
    var playAudioSourceEffect: AVAudioPlayer?
    var audioName: String = ""
    
    var isBanned: Bool? {
        didSet {
            guard let b = isBanned else { return }
            characterImageBan.isHidden = b ? true : false
        }
    }
    
    var character: Character? {
        didSet {
            guard let c = character else { return }
            
            characterImage.image = UIImage(named: c.image)
            
            if !isBanned! {
                characterName.text = c.name
            } else {
                characterName.text = c.name + " - P\(index! + 1)"
            }
            
            guard let url = Bundle.main.url(forResource: "Announcer/\(c.audio)", withExtension: "wav") else { return }
            
            do {
                playAudioSourceEffect = try AVAudioPlayer(contentsOf: url)
                playAudioSourceEffect?.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
    
    let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "??")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let characterImageBan: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ban")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    let nameContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        return view
    }()
    
    override func setupViews() {
        addSubview(characterImage)
        addSubview(characterImageBan)
        addSubview(nameContainer)
        
        addConstraintsWithFormat("H:|[v0]|", views: characterImage)
        addConstraintsWithFormat("V:|[v0]|", views: characterImage)
        addConstraintsWithFormat("H:|[v0]|", views: characterImageBan)
        addConstraintsWithFormat("V:|[v0]|", views: characterImageBan)
        
        addConstraintsWithFormat("H:|[v0]|", views: nameContainer)
        addConstraintsWithFormat("V:[v0(32)]|", views: nameContainer)
        
        nameContainer.addSubview(characterName)
        nameContainer.addConstraintsWithFormat("H:|[v0]|", views: characterName)
        nameContainer.addConstraintsWithFormat("V:|-1-[v0]-1-|", views: characterName)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        print("Please Help!")
        playAudioSourceEffect?.play()
    }
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() { }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    static func createViewContainer(bgColor: UIColor = .white) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        return view
    }
    
    static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    static func createLabel(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        return label
    }
    
    static func createTextfield(placeholderText: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholderText
        tf.borderStyle = .roundedRect
        return tf
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
