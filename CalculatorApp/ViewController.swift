//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Alfred Edwin on 10/4/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?
    
    // Enumerations for Operations
    enum Operation {
        case add, substract, multiply, divide
    }
    
    // Result Label
    private var resultLabel : UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica-Bold", size: 100)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpNumberPad()
    }
    
    private func setUpNumberPad() {
        // This will be the Button Size
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        // Adding Zero Button to UI
        let zeroButton = UIButton(frame: CGRect(x: 0,
                                                y: holder.frame.size.height-buttonSize,
                                                width: buttonSize*3,
                                                height: buttonSize))
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        
        // Tag
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        // Holder for Button Zero
        holder.addSubview(zeroButton)
        
        // Adding 1, 2, 3 Button to UI through a Loop
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x),
                                                    y: holder.frame.size.height-(buttonSize * 2),
                                                    width: buttonSize,
                                                    height: buttonSize))
            button1.setTitle("\(x+1)", for: .normal)
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            
            // Tag
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            
            // Holder
            holder.addSubview(button1)
        }
        
        // Adding 4, 5, 6 Button to UI through a Loop
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x),
                                                    y: holder.frame.size.height-(buttonSize * 3),
                                                    width: buttonSize,
                                                    height: buttonSize))
            button2.setTitle("\(x+4)", for: .normal)
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            
            // Tag
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            
            // Holder
            holder.addSubview(button2)
        }
        
        // Adding 7, 8, 9 Button to UI through a Loop
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x),
                                                    y: holder.frame.size.height-(buttonSize * 4),
                                                    width: buttonSize,
                                                    height: buttonSize))
            button3.setTitle("\(x+7)", for: .normal)
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            
            // Tag
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            
            // Holder
            holder.addSubview(button3)
        }
        
        
        // Adding Clear Button to UI
        let clearButton = UIButton(frame: CGRect(x: 0,
                                                y: holder.frame.size.height-(buttonSize*5),
                                                width: view.frame.size.width - buttonSize,
                                                height: buttonSize))
        clearButton.setTitle("CLEAR ALL", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        
        // Holder for clear button
        holder.addSubview(clearButton)
        
        
        // Adding = + - / * Operations Button to UI through a Loop
        let operations = ["=","+", "-", "*", "/"]
        
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3,
                                                    y: holder.frame.size.height-(buttonSize * CGFloat(x+1)),
                                                    width: buttonSize,
                                                    height: buttonSize))
            button4.setTitle(operations[x], for: .normal)
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            
            // Tag
            button4.tag = x + 1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            
            // Holder
            holder.addSubview(button4)
        }
        
        
        // Adding Result Label to UI
        
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        // Holder for result label
        holder.addSubview(resultLabel)
        
        
        // Actions
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    
    // Functions
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }
    
    @objc func zeroTapped() {
        
        if resultLabel.text != "0" {
            if let text =  resultLabel.text   {
            resultLabel.text = "\(text)\(0)"
        }
        }
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text =  resultLabel.text   {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        
        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                switch operation {
                case .add:
                    
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .substract:
                    
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                }
            }
        }
        else if tag == 2 {
            currentOperations = .add
        }
        else if tag == 3 {
            currentOperations = .substract
        }
        else if tag == 4 {
            currentOperations = .multiply
        }
        else if tag == 5 {
            currentOperations = .divide
        }
        
        
    }


}

