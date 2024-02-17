//
//  AddTextVC.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 17/02/24.
//

import UIKit

class AddTextVC: UIViewController {

    var updateTextView: ((String) -> Void)?
    var memeTextField = MMTextField()

    var istextEntered: Bool{ return !memeTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTextField()

        createDismissKeyboard()
    }

    func configureTextField(){
        view.addSubview(memeTextField)

        memeTextField.delegate = self

        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            memeTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            memeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            memeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            memeTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func configure(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addText))
        navigationItem.rightBarButtonItem = doneButton
        title = "Add Custom Text"
    }

    func createDismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc func addText(){

        guard istextEntered else {
            print("text empty")
            return
        }

        updateTextView?(String(memeTextField.text ?? ""))

        dismiss(animated: true)
    }

}

extension AddTextVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addText()

        return true
    }
}


