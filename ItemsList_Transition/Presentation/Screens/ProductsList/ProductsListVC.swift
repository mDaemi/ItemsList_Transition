//
//  ProductsListVC.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import UIKit
import Combine

class ProductsListVC: AbstractViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    private var observers: [AnyCancellable] = []
    private let transitionManger = CardTransitionManager()
    var viewModel: ProductListViewModel?
    
    // MARK: Views
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.delegate = self
        return view
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
//        let searchView = UISearchBar()
//        searchView.constraintToSuperview(top: 4, bottom: 4, left: 4, right: 4)
        return view
    }()
    
    lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(GenericTableViewCell<CardView>.self)
        return tableView
    }()
    
    // MARK: override functions
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        configureView()
        
        bindViewModel()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("View deinit.")
    }
}

// MARK: Views configuration
extension ProductsListVC {
    
    func configureView() {
        view.backgroundColor = .white
        configureScrollView()
        configureTopView()
        configureCardsView()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureTopView() {
        scrollView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            topView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
    }
    
    func configureCardsView() {
        guard let viewModel = viewModel else { return }
        scrollView.addSubview(cardsTableView)
        NSLayoutConstraint.activate([
            cardsTableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            cardsTableView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            cardsTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            cardsTableView.heightAnchor.constraint(equalToConstant: CGFloat(450 * 20)),
            cardsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

// MARK: Data
extension ProductsListVC {
    // MARK: - Private
    private func bindViewModel() {
        viewModel?.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.cardsTableView.isHidden = false
                self?.cardsTableView.reloadData()
                self?.view.hideLoader()
            }
            .store(in: &observers)
    }
    
    private func loadData() {
        guard let viewModel = viewModel else {
            print("ViewModel is NULL.")
            return
        }
        Task {
            do {
                try await viewModel.fetchProducts(for: "samsung")
            } catch {
                displaySnack(text: localized("error.service"))
            }
        }
    }
}

// MARK: Table view
extension ProductsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<CardView>
        
        let cardViewModel = viewModel!.products[indexPath.row]
        
        guard let cellView = cardCell.cellView else {
            let cardView = CardView(cardModel: cardViewModel)
            cardCell.cellView = cardView

            return cardCell
        }
        
        cellView.configure(with: cardViewModel)
        cardCell.clipsToBounds = false
        cardCell.contentView.clipsToBounds = false
        cardCell.cellView?.clipsToBounds = false
        
        cardCell.layer.masksToBounds = false
        cardCell.contentView.layer.masksToBounds = false
        cardCell.cellView?.layer.masksToBounds = false
        
        return cardCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cardViewModel = cardsViewData[indexPath.row]
//        let detailView = DetailView(cardViewModel: cardViewModel)
//        detailView.modalPresentationStyle = .overCurrentContext
//        detailView.transitioningDelegate = transitionManger
//        present(detailView, animated: true, completion: nil)
//
//        // To wake up the UI, Apple issue with cells with selectionStyle = .none
//        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCellCardView() -> CardView? {
        
        guard let indexPath = cardsTableView.indexPathForSelectedRow else { return nil }

        let cell = cardsTableView.cellForRow(at: indexPath) as! GenericTableViewCell<CardView>
        guard let cardView = cell.cellView else { return nil }

        return cardView
    }
}

