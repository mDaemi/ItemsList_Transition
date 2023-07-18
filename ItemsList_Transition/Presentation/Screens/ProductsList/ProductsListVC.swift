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
    var viewModel: ProductListViewModel?
    private var observers: [AnyCancellable] = []
    private let transitionManger = CardTransitionManager()
    private var heightConstraint: NSLayoutConstraint!
    private var keyboardIsOpen: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
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
    
    // MARK: - Top View -
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Cards Table View
    lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.registerCell(GenericTableViewCell<CardView>.self)
        return tableView
    }()
    
    // MARK: overrides functions
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        configureView()
        bindViewModel()
        searchBar.searchTextField.textPublisher
            .sink(receiveValue: { text in
                self.loadData(for: text)
            }).store(in: &cancellables)
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
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: View configuration functions
extension ProductsListVC {
    
    private func configureView() {
        view.backgroundColor = .white
        configureScrollView()
        configureTopView()
        configureCardsView()
        configureTap()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureTopView() {
        scrollView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            topView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            topView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        topView.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8.0),
            searchBar.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16.0),
            searchBar.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -16.0)
        ])
    }
    
    private func configureCardsView() {
        scrollView.addSubview(cardsTableView)
        heightConstraint = cardsTableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            cardsTableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            cardsTableView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            cardsTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            heightConstraint,
            cardsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func configureTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        keyboardIsOpen = true
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        keyboardIsOpen = false
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: Data
extension ProductsListVC {
    // MARK: - Private
    private func bindViewModel() {
        viewModel?.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self, let viewModel = self.viewModel else { return }
                self.heightConstraint.constant = CGFloat(viewModel.products.count * constraint.cardHeight)
                self.cardsTableView.reloadData()
                self.view.layoutIfNeeded()
            }
            .store(in: &observers)
    }
    
    private func loadData(for world: String) {
        guard let viewModel = viewModel else {
            print("ViewModel is NULL.")
            return
        }
        Task {
            do {
                try await viewModel.fetchProducts(for: world)
            } catch {
                displaySnack(text: localized("error.service"))
            }
        }
    }
}

// MARK: - Table view -
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
        return CGFloat(constraint.cardHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if keyboardIsOpen { return }
        let cardViewModel = viewModel!.products[indexPath.row]
        let detailView = ProductDetailsVC(cardViewModel: cardViewModel)
        detailView.viewModel = ProductDetailsViewModel(DataUseCaseProvider().provideProductDetailsUseCase())
        detailView.productID = viewModel!.products[indexPath.row].id
        detailView.modalPresentationStyle = .overCurrentContext
        detailView.transitioningDelegate = transitionManger
        present(detailView, animated: true, completion: nil)
        
        // To wake up the UI, Apple issue with cells with selectionStyle = .none
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCellCardView() -> CardView? {
        
        guard let indexPath = cardsTableView.indexPathForSelectedRow else { return nil }
        
        let cell = cardsTableView.cellForRow(at: indexPath) as! GenericTableViewCell<CardView>
        guard let cardView = cell.cellView else { return nil }
        
        return cardView
    }
}

// MARK: - UISearchBarDelegate -
extension ProductsListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
