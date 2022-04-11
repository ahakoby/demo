//
//  LoadingViewController.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController {
        
    @IBOutlet weak var logoImageView: UIImageView!

    //MARK: - Injection
    private var viewModel: LoadingViewModelType?
    func inject(viewModel: LoadingViewModelType) {
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
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel!.inputs.viewDidLoad()
    }
    
    override func bindTexts() {
    }
    
    override func bindUI() {
        
    }
    
    override func bindStyles() {
        logoImageView.image = UIImage.imageAsset(Image.logo)//R.image.skyengNew()
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        // Outputs
        
        // Inputs
        
    }

}
