//
//  FullPhotoViewController.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class FullPhotoViewController: UIViewController {
    var presenter: FullPhotoPresenter

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var linkLabel: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 10)
        text.numberOfLines = 0
        text.textAlignment = .center
        text.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        text.addGestureRecognizer(guestureRecognizer)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    lazy var previousImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prev", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(previousImageButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var nextImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(nextImageButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter.viewDidLoad()
    }

    init(presenter: FullPhotoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func labelClicked() {
        let vc = LinkPhotoAssemble.assembleLinkPhoto(newsLink: presenter.photo[presenter.indexPath].originalLink)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func previousImageButtonTapped() {
        presenter.showImage(choose: .previous)
    }

    @objc func nextImageButtonTapped() {
        presenter.showImage(choose: .next)
    }
}

// MARK: Setup UI

extension FullPhotoViewController {
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(previousImageButton)
        view.addSubview(nextImageButton)
        view.addSubview(linkLabel)

        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),

            previousImageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            previousImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),

            nextImageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nextImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),

            linkLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 20),
            linkLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            linkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: ViewInput

extension FullPhotoViewController: FullPhotoViewInput {
    func configure(photo: Photo) {
        DispatchQueue.main.async {
            let attributedString = NSMutableAttributedString(string: "Source link")
            attributedString.addAttribute(
                .link,
                value: photo.originalLink,
                range: NSRange(location: 0, length: attributedString.length)
            )
            self.linkLabel.attributedText = attributedString
        }
    }

    func setImage(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
