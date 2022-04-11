//
//  ResultViewController.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ResultViewController: BaseViewController {
    override var isPrefersLargeTitles: Bool {
        return true
    }
    fileprivate var text: String?
    private let searchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Injection
    private var viewModel: ResultViewModelType?
    func inject(viewModel: ResultViewModelType) {
        if self.viewModel == nil {
            self.viewModel = viewModel
        } else {
            fatalError(.wrongInit)
        }
    }
    
    func configure(with text: String?) {
        self.text = text
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        guard let viewModel = viewModel else {
            fatalError(.wrongInit)
        }
        
        viewModel.bindErrorTracker()
        viewModel.bindActivityIndicator()

        super.viewDidLoad()
        self.bindViewModel()
        self.configureTableView()
        
        guard let text = text else {
            return
        }
        searchController.searchBar.text = text
        self.viewModel!.inputs.search(text)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = text else {
            DispatchQueue.main.async {
                self.searchController.searchBar.becomeFirstResponder()
            }
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func bindTexts() {
        self.title = RLocalized.title_skyeng()
        BaseStyles.defaultBackgroundView.apply(to: tableView)
        let textFileld = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFileld?.textColor = .defaultTextColor
    }
    
    override func bindUI() {
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true

        navigationItem.searchController = searchController
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        // Outputs
        // RXTableView
        let configureTableCell: RxTableViewSectionedReloadDataSource<TranslationSection>
            .ConfigureCell = { dataSource, tableView, index, model in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RNib.tableViewCell, for: index)  else {
                    return TableViewCell()

                }
                cell.bind(to: model)
                return cell
        }


        let tableDataSource = RxTableViewSectionedReloadDataSource<TranslationSection>(configureCell: configureTableCell)

        viewModel!.outputs.translateDriver
            .drive(tableView.rx.items(dataSource: tableDataSource))
            .disposed(by: disposeBag)
                
        // Inputs
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .subscribe {[weak self] text in
                self?.viewModel!.inputs.search(text)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Word.self)
            .subscribe(onNext: {[weak self] section in
                guard let strongSelf = self else {return}
                strongSelf.viewModel!.inputs.translateItemClicked(item: section, word: strongSelf.text ?? "")
            }).disposed(by: disposeBag)
        
    }

    // MARK: - Helpers
    private func configureTableView() {
        tableView.register(RNib.tableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
    }

}
