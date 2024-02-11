//
//  DetailsViewController.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
    override var isPrefersLargeTitles: Bool {
        return true
    }
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var model: Word?
    fileprivate var word: String?

    //MARK: - Injection
    private var viewModel: DetailsViewModelType?
    func inject(viewModel: DetailsViewModelType) {
        if self.viewModel == nil {
            self.viewModel = viewModel
        } else {
            fatalError(.wrongInit)
        }
    }

    func configure(with model: Word, word: String) {
        self.model = model
        self.word = word
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        guard let _ = viewModel else {
            fatalError(.wrongInit)
        }
        self.configureTableView()

        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func bindTexts() {
        self.title = R.string.localizable.title_meaning()
        BaseStyles.defaultBackgroundView.apply(to: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Helpers
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model, let meanings = model.meanings else {return 0}
        return  meanings.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
            guard let model = model, let text = model.text else {return UITableViewCell()}
            cell.titleLabel.text = text
            cell.titleLabel.textColor = .defaultTextColor
            BaseStyles.defaultBackgroundView.apply(to: cell)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeaningCell", for: indexPath) as! MeaningTableViewCell
        guard let model = model, let meanings = model.meanings else {return UITableViewCell()}
        let meaning = meanings[indexPath.row - 1]
        cell.meaningTextLabel.text = meaning.translation?.text
        cell.noteLabel.text = meaning.translation?.note
        cell.transcriptionLabel.text = meaning.transcription
        
        cell.meaningTextLabel.textColor = .defaultTextColor
        cell.noteLabel.textColor = .defaultTextColor
        cell.transcriptionLabel.textColor = .defaultTextColor
        
        // It will be better to create operations and add in operation queue
        if let urlComponent = meaning.previewUrl {
            cell.previewImageView.setImage(("https:" + urlComponent).toUrl())
        }
        BaseStyles.defaultBackgroundView.apply(to: cell)
        return cell
    }
}
