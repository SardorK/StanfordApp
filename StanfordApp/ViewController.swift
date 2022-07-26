//
//  ViewController.swift
//  StanfordApp
//
//  Created by APPLE on 21/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: buttons.count)
    
    var count = 0 {
        didSet{
            flipLabel.text = "Flips: \(count)"
        }
    }
    
    lazy var buttons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in 0...11{
            let button = makeButton()
            buttons.append(button)
        }
        return buttons
    }()
    
    lazy var stackLine1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttons[0],buttons[1],buttons[2],buttons[3]])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5.0
        
        return view
    }()
    
    lazy var stackLine2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttons[4],buttons[5],buttons[6],buttons[7]])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5.0
        
        return view
    }()
    
    lazy var stackLine3: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttons[8],buttons[9],buttons[10],buttons[11]])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5.0
        
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [stackLine1,stackLine2,stackLine3])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 10.0
        
        return view
    }()
    
    lazy var flipLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Flips: \(count)"
        view.textColor = .orange
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 35.0, weight: .bold)
        
        return view
    }()
    
    func makeButton()->UIButton{
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.systemFont(ofSize: 40.0)
        view.backgroundColor = .orange
        view.setTitle("", for: .normal)
        view.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
                
        return view
    }
    
    
    
    @objc func flipCard(button: UIButton){
        if let cardNumber = buttons.index(of: button){
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("s")
        }
    }
    
    func updateViewFromModel(){
        for index in buttons.indices{
            let button = buttons[index]
            let card = game.cards[index]
            if card.isFacedUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
    
    var images: [String] = ["👻","⚡️","😈","🐺","🎃","💀","👻","⚡️","😈","🐺","🎃","💀"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card)->String{
        if emoji[card.identifier] == nil,images.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(images.count)))
            emoji[card.identifier] = images.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
//    func setImageButtons(button: UIButton){
////        buttons.enumerated().forEach{ $1.setTitle(images[$0], for: .normal)}
//        button.setTitle(images[button.tag], for: .normal)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setImageButtons()
        view.backgroundColor = .black
        view.addSubview(contentStack)
        view.addSubview(flipLabel)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            contentStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0),
            contentStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0),
            contentStack.heightAnchor.constraint(equalToConstant: 350.0),
            
            flipLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0),
            flipLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60.0),
            flipLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60.0),
            flipLabel.heightAnchor.constraint(equalToConstant: 50.0),
        ])
    }


}

