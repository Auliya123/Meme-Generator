//
//  MemeInfoVC.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

class MemeInfoVC: UIViewController {

    var memeView = MemeView()
    let addTextBtn = UIButton(frame: .zero)
    let addImgBtn = UIButton(frame: .zero)

    var additionalText: String = ""
    var memeImage: String = ""

    let pickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureMemeView()
        configureAddImgBtn()
        configureAddTextBtn()
    }

    func configure(){
        view.backgroundColor = .systemBackground
        memeView.setImageUrl(imageUrl: memeImage)

        title = "Memes"

        navigationItem.titleMenuProvider = { suggestions in
            var finalMenuElements = suggestions
            finalMenuElements.append(UICommand(title: "Share Photo",
                                               action: #selector(self.sharePhoto))
                                     )
            return UIMenu(children: finalMenuElements)
        }
    }

    @objc func sharePhoto(){
        let renderer = UIGraphicsImageRenderer(size: memeView.bounds.size)
        let image = renderer.image { ctx in
            memeView.drawHierarchy(in: memeView.bounds, afterScreenUpdates: true)
        }

        let shareSheetVC = UIActivityViewController(
            activityItems: [image], applicationActivities: nil)

        present(shareSheetVC, animated: true )
    }

    func configureMemeView(){
        view.addSubview(memeView)

        memeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            memeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            memeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            memeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            memeView.heightAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

    func configureAddTextBtn(){
        view.addSubview(addTextBtn)

        addTextBtn.translatesAutoresizingMaskIntoConstraints = false
        addTextBtn.setTitle("Add Text", for: .normal)
        addTextBtn.setTitleColor(.black, for: .normal)
        addTextBtn.addTarget(self , action: #selector(showTextForm), for: .touchUpInside)


        NSLayoutConstraint.activate([
            addTextBtn.centerYAnchor.constraint(equalTo: addImgBtn.centerYAnchor),
            addTextBtn.leadingAnchor.constraint(equalTo: addImgBtn.trailingAnchor, constant: 12),
            addTextBtn.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    func configureAddImgBtn(){
        view.addSubview(addImgBtn)
        
        addImgBtn.translatesAutoresizingMaskIntoConstraints = false
        addImgBtn.setTitle("Add Logo", for: .normal)
        addImgBtn.setTitleColor(.black, for: .normal)
        addImgBtn.addTarget(self , action: #selector(showGallery), for: .touchUpInside)


        NSLayoutConstraint.activate([
            addImgBtn.topAnchor.constraint(equalTo: memeView.bottomAnchor, constant: 8),
            addImgBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addImgBtn.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    @objc func showTextForm(_ sender: UIBarButtonItem){
        let destVC = AddTextVC()
        let navController = UINavigationController(rootViewController: destVC)

        destVC.updateTextView = { newText in
            self.set(text: newText)
        }
        
        present(navController, animated: true)
    }

    @objc func showGallery(){
        pickerController.allowsEditing = true
        pickerController.delegate = self
        present(pickerController, animated: true)
    }

    func set(text: String){
        memeView.set(additionalText: text)
        addTextBtn.setTitle("Edit Text", for: .normal)
    }

    func setImage(selectedImage: UIImage){
        memeView.additionalImage.image = selectedImage
    }
}

extension MemeInfoVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[.editedImage] as! UIImage
        self.setImage(selectedImage: image)
        self.dismiss(animated: true)
    }
}


