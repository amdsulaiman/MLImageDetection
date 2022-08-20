//
//  TextRecognitionVC.swift
//  CoreML2
//
// .
//

import UIKit
import Vision

class TextRecognitionVC: UIViewController {
    
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var galleryBtnRef: UIButton!
    @IBOutlet weak var cameraBtnRef: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var searchBtnRef: UIButton!
    @IBOutlet weak var txtViewHc: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRecognition()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        setupRecognition()
    }
    func setupUI() {
        txtViewHc.constant = 0
        galleryBtnRef.layer.cornerRadius = 8
        cameraBtnRef.layer.cornerRadius = 8
        searchBtnRef.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
        textView.layer.cornerRadius = 8
    }
    func setupRecognition(){
        if imageView.image == #imageLiteral(resourceName: "image") {
            txtViewHc.constant = 0

        }
        else {
            recognizeText(image: imageView.image)
        }
    }
    private func recognizeText(image:UIImage?){
        guard let cgImage = image?.cgImage else {
            fatalError()
        }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observation = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            let text = observation.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            DispatchQueue.main.async {
                self!.textView.text = text
                self!.txtViewHc.constant = (self?.textView.contentSize.height)!
            }
        }
//        request.recognitionLevel = .fast
//        request.usesLanguageCorrection = true
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func onClickCamera(_ sender: UIButton) {
        presentCamera()
        
    }
    
    @IBAction func onClickGallery(_ sender: UIButton) {
        presentPhotoPicker()
    }
    @IBAction func onClickSearch(_ sender: UIButton) {
        if textView.text == "" {
            print("Text is Empty")
        }
        else {
            var query = textView.text
            query = query!.replacingOccurrences(of: " ", with: "+")
            let url = "https://www.google.co.in/search?q=" + query!
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
}
extension TextRecognitionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
        recognizeText(image: imageView.image)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
