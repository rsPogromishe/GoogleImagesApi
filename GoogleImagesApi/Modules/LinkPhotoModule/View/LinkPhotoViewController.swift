//
//  LinkPhotoViewController.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit
import WebKit

class LinkPhotoViewController: UIViewController {
    var presenter: LinkPhotoPresenter

    private let webView: WKWebView = {
        var webView = WKWebView()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    init(presenter: LinkPhotoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter.viewDidLoad()
    }
}

// MARK: Setup UI

extension LinkPhotoViewController {
    private func setupUI() {
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: ViewInput

extension LinkPhotoViewController: LinkPhotoViewInput {
    func uploadURL(url: URLRequest) {
        webView.load(url)
    }
}
