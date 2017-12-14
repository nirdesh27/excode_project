//
//  ViewController.swift
//  TextRecognition
//
//  Created by cl-macmini-152 on 06/09/17.
//  Copyright © 2017 clicklabs. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController ,G8TesseractDelegate ,UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    
   
    @IBAction func actionButton(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated : true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageValue = info[UIImagePickerControllerOriginalImage] as? UIImage {
            fetchText(image: imageValue)
            print(imageValue)
            self.dismiss(animated: true, completion: nil)
        }else {
            print("error loading images")
        }
    }


     override func viewDidLoad() {
        super.viewDidLoad()
         let image = #imageLiteral(resourceName: "myimage").g8_blackAndWhite()
        print(image ?? "")
        fetchText(image: image!)
    }
    
    
    func fetchText(image: UIImage) {
        if let tessaract = G8Tesseract(language : "eng"){
            tessaract.image = image
            tessaract.delegate = self
            tessaract.recognize()
            textView.text = tessaract.recognizedText
        }
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("image cognition progress \(tesseract.progress)")
        progressBar.progress = Float(tesseract.progress)
    }
}



