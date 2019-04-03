//
//  ViewController.swift
//  IMC
//
//  Created by Andreza Moreira on 12/03/19.
//  Copyright © 2019 Andreza Moreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfHeight: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var ivResult: UIImageView!
    @IBOutlet weak var viResult: UIView!
    
    var imc: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // tirar o foco ao tocar em outras partes da tela
        view.endEditing(true)
    }
    
    @IBAction func calculate(_ sender: Any) {
        // recuperar o dado
        // verifica se os valores foram preenchidos com números decimais
        if let weight = Double(tfWeight.text!),
            let height = Double(tfHeight.text!){
            // imc é calculo de massa corporal
            // imc = peso / alturaˆ2
            imc = weight / pow(height, 2) // pow substitui -> (height * height) - altura ao quadrado
            
            // mostrar na tela o resultado final
            showResults()
        }
    }
    
    func showResults(){
        var result: String = ""
        var image: String = ""
        
        switch imc {
            case 0..<16:
                result = "Magresa"
                image = "abaixo" // declarando o nome do imageSet
            case 16..<18.5:
                result = "Abaixo do peso"
                image = "abaixo"
            case 18.5..<25:
                result = "Peso ideal"
                image = "ideal"
            case 25..<30:
                result = "Sobre peso"
                image = "sobre"
            default: // >30
                result = "Obesidade"
                image = "obesidade"
        }
        // incorporando o conteúdo da variável dentro de uma string
        lbResult.text = "\(Int(imc)): \(result)" // convertendo o resultado para inteiro
        // cria uma imagem e usa pra isso uma imageSet com o nome que está na variável image
        ivResult.image = UIImage(named: image)
        viResult.isHidden = false
        view.endEditing(true)
    }

    // Botão limpar
    @IBAction func clear(_ sender: Any) {
        tfHeight.text = ""
        tfWeight.text = ""
        viResult.isHidden = true
    }
    
    // Máscaras de Entrada
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Peso
        if textField == tfWeight{
            let MAX_SIZE = 2 // tamanho máximo = 3
            if range.location > MAX_SIZE{
                return false
            }
        }
        
        // Altura
        if textField == tfHeight{
            let MAX_SIZE = 3 // tamanho máximo = 4
            if range.location > MAX_SIZE {
                return false
            }
            
            if var text = textField.text{
                let SECOND_POSITION = 1
                
                // busca a segunda posição
                if range.location == SECOND_POSITION {
                    // adiciona o . automáticamente
                    if string != "" {
                        text = text + "."
                        textField.text = text
                    }
                    // mas se for digitado .
                    if string == "."{
                        return false
                    }
                    if string == ","{
                        return false
                    }
                }
                // fora da segunda posição
                else {
                    // o . não é adicionado
                    if string == "."{
                        return false
                    }
                    if string == ","{
                        return false
                    }
                }
            }
        }
        return true
    }
}
