//
//  ViewController.swift
//  ControlesYVistasTexto
//
//  Created by Eduardo Martin Lorenzo on 20/01/2020.
//  Copyright © 2020 Eduardo Martin Lorenzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // ------ Variables ------
    private let myPickerViewValues = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    // -----------------------
    
    // Para añadir la conexión del elemento de la interfaz en el código hay que pulsar 'control' y arrastrar el elemento hasta aquí. Hay varios tipos de conexiones:
    // Connection - Outlet: Sirve para las cualidades del elemento
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myActivityView: UIActivityIndicatorView!
    
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var mytextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    
    // Es lo primero que se ejecuta
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BUTTONS
        // Para el texto de un botón
        myButton.setTitle("Mi botón", for: .normal) // El 'for' hace referencia al estado del botón en el que va a coger el texto indicado. .normal se refiere a todos los estados. Hay algunos como disabled entre otros
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        // PICKERSVIEW
        myPickerView.backgroundColor = .lightGray
        myPickerView.dataSource = self // Indica la clase donde se van a cargar los datos del PickerView
        myPickerView.delegate = self // Para indicar a donde van a llegar las notificaciones de que se ha realizado algo sobre el PickerView
        myPickerView.isHidden = true // Por defecto va a estar invisible el PickerView
        
        // PAGE CONTROL
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue // Color del indicador de la página en la que nos encontramos
        myPageControl.pageIndicatorTintColor = .lightGray// Color del indicador de las páginas en las que no nos encontramos
        
        // SEGMENTEDCONTROLS
        mySegmentedControl.removeAllSegments() // Elimina los elementos que tuviera el SegmentedControl
        
        for (index, value) in myPickerViewValues.enumerated() {
            // Va añadiendo los elementos del PickerView al SegmentedControl
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // SLIDERS
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
        // STEPPERS
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)
        myStepper.value = 1
        
        // SWITCH
        mySwitch.onTintColor = .red
        mySwitch.isOn = false // Para indicar si aparece como true o false
        
        // PROGRESS INDICATOR
        myProgressView.progress = 0 // Toma valores entre 0 y 1
        
        // ACTIVITY INDICATOR
        myActivityView.color = .orange
        myActivityView.startAnimating()
        myActivityView.hidesWhenStopped = true // Esto hará que desaparezca automaticamente CADA VEZ que se para la animación
        
        // LABELS
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 16) // Letra en negrita con tamaño 16
        myStepperLabel.text = "1"
        
        mySwitchLabel.text = "Está apagado"
        
        // TEXT FIELD
        mytextField.textColor = .brown
        mytextField.placeholder = "Escribe algo"
        mytextField.delegate = self
        
        // TEXT VIEW
        myTextView.textColor = .brown
        //myTextView.isEditable = false
        myTextView.delegate = self
    }
    
    // Connection - Action: Sirve para los eventos del elemento
    @IBAction func myButtonAction(_ sender: Any) {
        // Bloque de código que se va a ejecutar al hacer click sobre el botón
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
            myButton.setTitleColor(.black, for: .normal)
        } else {
            myButton.backgroundColor = .blue
            myButton.setTitleColor(.white, for: .normal)
        }
        
        // Oculta el teclado asociado al TextView
        myTextView.resignFirstResponder()
    }
    
    @IBAction func myPageControlActtion(_ sender: Any) {
        // Bloque de código que se va a ejecutar cada vez que se cambie de página
        myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true) // inComponente se refiere a la columna que se quiere mover del PickerView
        
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
        
        mySlider.value = Float(myPageControl.currentPage + 1)
        
        myStepper.value = Double(myPageControl.currentPage + 1)
    }
    
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        // Bloque de código que se va a ejecutar cada vez que se elija un elemento del SegmentedControl
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
        
        mySlider.value = Float(mySegmentedControl.selectedSegmentIndex + 1)
        
        myStepper.value = Double(mySegmentedControl.selectedSegmentIndex + 1)
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        
        var progreso: Float = 0
        // Bloque de código que se ejecuta cada vez que se coloque el Slider en una nueva posición
        var myString = ""
        switch mySlider.value {
            case 1..<2:
                mySegmentedControl.selectedSegmentIndex = 0
                myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
                myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
                myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
                myButton.setTitle(myString, for: .normal)
                
                myStepper.value = Double(mySlider.value)
            
                progreso = 0.2
            case 2..<3:
                mySegmentedControl.selectedSegmentIndex = 1
                myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
                myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
                myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
                myButton.setTitle(myString, for: .normal)
                
                myStepper.value = Double(mySlider.value)
            
                progreso = 0.4
            case 3..<4:
                mySegmentedControl.selectedSegmentIndex = 2
                myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
                myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
                myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
                myButton.setTitle(myString, for: .normal)
            
                myStepper.value = Double(mySlider.value)
            
                progreso = 0.6
            case 4..<5:
                mySegmentedControl.selectedSegmentIndex = 3
                myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
                myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
                myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
                myButton.setTitle(myString, for: .normal)
            
                myStepper.value = Double(mySlider.value)
            
                progreso = 0.8
            default:
                mySegmentedControl.selectedSegmentIndex = 4
                myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
                myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
                myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
                myButton.setTitle(myString, for: .normal)
            
                myStepper.value = Double(mySlider.value)
            
                progreso = 1
        }
        
        myProgressView.progress = progreso
    }
    
    @IBAction func myStepperAction(_ sender: Any) {
        mySlider.value = Float(myStepper.value)
        mySegmentedControl.selectedSegmentIndex = Int(myStepper.value - 1)
        myPickerView.selectRow(Int(myStepper.value - 1), inComponent: 0, animated: true)
        myPageControl.currentPage = Int(myStepper.value - 1)
        let myString = myPickerViewValues[Int(myStepper.value - 1)]
        myButton.setTitle(myString, for: .normal)
        print(myStepper.value)
        
        myStepperLabel.text = /*String(myStepper.value)*/ "\(myStepper.value)"
    }
    
    @IBAction func mySwitchAction(_ sender: Any) {
        if mySwitch.isOn {
            myPickerView.isHidden = false
            myActivityView.stopAnimating()
            mySwitchLabel.text = "Está encendido"
        } else {
            myPickerView.isHidden = true
            myActivityView.startAnimating()
            mySwitchLabel.text = "Está apagado"
        }
    }
}

// Se necesita crear una extension de la clase ViewController para utilizar los protocolos dataSource y delegate del PickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Hay que indicar el número de COLUMNAS que tiene el PickerView. Por ejemplo el de fechas tiene 4 columnas por defecto
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Hay que indicar el número de filas, es decir, el número de elementos
        return myPickerViewValues.count
    }
    
    // Representación visual de cada uno de los elementos del PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    // Esto se va a ejecutar cuando paremos en uno de los elementos del PickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = row
        
        mySegmentedControl.selectedSegmentIndex = row
        
        mySlider.value = Float(row + 1)
        
        myStepper.value = Double(row + 1)
    }
    
    
}

// Se necesita crear una extension de la clase ViewController para utilizar el protocol delegate del TextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Cuando se pulsa el botón de 'intro' se realiza lo siguiente
        textField.resignFirstResponder() // Se cierra el teclado
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Cuando se termina de escribir en el input
        myButton.setTitle(mytextField.text, for: .normal) // Se cambia el texto del boton con lo introducido en el input
    }
}

// Se necesita crear una extension de la clase ViewController para utilizar el protocol delegate del TextView
extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Cuando se empieza a editar se ejecuta lo siguiente
        mytextField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // Cuando se deja de editar se ejecuta lo siguiente
        mytextField.isHidden = false
    }
}

