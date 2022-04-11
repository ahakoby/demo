//
//  SearchViewController.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
        
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Injection
    private var viewModel: SearchViewModelType?
    func inject(viewModel: SearchViewModelType) {
        if self.viewModel == nil {
            self.viewModel = viewModel
        } else {
            fatalError(.wrongInit)
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        guard let _ = viewModel else {
            fatalError(.wrongInit)
        }
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func bindTexts() {
    }
    
    override func bindUI() {
        searchBar.delegate = self
    }
    
    override func bindStyles() {
        logoImageView.image = UIImage.imageAsset(Image.logo)//R.image.skyengNew()
        let textFileld = searchBar.value(forKey: "searchField") as? UITextField
        textFileld?.textColor = .defaultTextColor
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if UIDevice.current.userInterfaceIdiom != .pad {
            self.viewModel!.inputs.searchBarShouldBeginEditing()
            return false
        }
        
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //TODO: Check language and text value - A.H.
        guard let text = searchBar.text else {
            return
        }
        self.viewModel!.inputs.searchBarSearchButtonClicked(text: text)
    }
}
