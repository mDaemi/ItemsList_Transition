//
//  ProductDetailsVC.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import UIKit
import Combine

class ProductDetailsVC: AbstractViewController, UIScrollViewDelegate {
    
    // MARK: - Properties -
    private var cardViewModel: ProductUIModel
    private(set) var cardView: CardView?
    private var observers: [AnyCancellable] = []
    var viewModel: ProductDetailsViewModel?
    var productID: Int?
   
    // MARK: - Views -
    lazy var snapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 10.0
        imageView.layer.shadowOffset = CGSize(width: -1, height: 2)
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var qualityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewsAreHidden: Bool = false {
        didSet {
            closeButton.isHidden = viewsAreHidden
            cardView?.isHidden = viewsAreHidden
            priceLabel.isHidden = viewsAreHidden
            qualityLabel.isHidden = viewsAreHidden
            commentLabel.isHidden = viewsAreHidden

            view.backgroundColor = viewsAreHidden ? .clear : .white
        }
    }
    
    // MARK: - Inits -
    init(cardViewModel: ProductUIModel) {
        self.cardViewModel = cardViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides -
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("View deinit.")
    }
}

// MARK: - View configuration -
extension ProductDetailsVC {
    
    private func configureView() {
        configureScrollView()
        configureCardView()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCardView() {
        let cardModel = cardViewModel
        cardViewModel.viewMode = .full
        cardView = CardView(cardModel: cardModel)
        cardView?.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardView!)
        
        NSLayoutConstraint.activate([
            cardView!.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1),
            cardView!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView!.heightAnchor.constraint(equalToConstant: CGFloat(constraint.cardHeight)),
            cardView!.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1.0),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0)
        ])
        
        closeButton.setImage(UIImage(named: "darkOnLight")!, for: UIControl.State.normal)
    }
    
    private func addLablesViews() {

        // priceLabel
        scrollView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 50),
            priceLabel.topAnchor.constraint(equalTo: cardView!.bottomAnchor, constant: -20.0)
        ])
        
        // qualityLabel
        scrollView.addSubview(qualityLabel)
        qualityLabel.anchor(top: priceLabel.bottomAnchor, left: priceLabel.leftAnchor, bottom: nil, right: priceLabel.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        // commentLabel
        scrollView.addSubview(commentLabel)
        commentLabel.anchor(top: qualityLabel.bottomAnchor, left: priceLabel.leftAnchor, bottom: scrollView.bottomAnchor, right: priceLabel.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 20.0, paddingRight: 0)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Transition helper -
extension ProductDetailsVC {
    func createSnapshotOfView() {
        let snapshotImage = view.createSnapshot()
        snapshotView.image = snapshotImage
        scrollView.addSubview(snapshotView)
        
        let topPadding = UIWindow.topPadding
        snapshotView.frame = CGRect(x: 0, y: -topPadding, width: view.frame.size.width, height: view.frame.size.height)
        
        scrollView.delegate = self
    }
}

// MARK: - ScrollView -
extension ProductDetailsVC {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPositionForDismissal: CGFloat = 20.0
        var yContentOffset = scrollView.contentOffset.y
        let topPadding = UIWindow.topPadding
        
        yContentOffset += topPadding
        
        updateCloseButton(yContentOffset: yContentOffset)
        
        if scrollView.isTracking {
            scrollView.bounces = true
        } else {
            scrollView.bounces = yContentOffset > 500
        }
        
        if yContentOffset < 0 && scrollView.isTracking {
            viewsAreHidden = true
            snapshotView.isHidden = false
            
            let scale = (100 + yContentOffset) / 100
            snapshotView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            snapshotView.layer.cornerRadius = -yContentOffset > yPositionForDismissal ? yPositionForDismissal : -yContentOffset
            
            if yPositionForDismissal + yContentOffset <= 0 {
                self.close()
            }
            
        } else {
            viewsAreHidden = false
            snapshotView.isHidden = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = true
    }
    
    func updateCloseButton(yContentOffset: CGFloat) {
       
        closeButton.setImage(UIImage(named: "darkOnLight"), for: .normal)
    }
}

// MARK: Data
extension ProductDetailsVC {
    // MARK: - Private
    private func bindViewModel() {
        viewModel?.$product
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.addLablesViews()
                self.configureLabelsView()
                self.view.layoutIfNeeded()
            }
            .store(in: &observers)
    }

    private func loadData() {
        guard let viewModel = viewModel,
              let id = productID else {
            print("View Model is NULL.")
            return
        }
        Task {
            do {
                try await viewModel.fetchDetails(for: id)
            } catch {
                displaySnack(text: localized("error.service"))
            }
        }
    }
    
    private func configureLabelsView() {
        guard let product = viewModel?.product else { return }
        priceLabel.configureHeroLabel(withText: product.salePrice)
        priceLabel.textColor = UIColor.red
        qualityLabel.configureHeaderLabel(withText: product.quality)
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attribute: [NSAttributedString.Key: Any] = [
            .font : UIFont.systemFont(ofSize: 17, weight: .regular),
            .foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributString = NSMutableAttributedString(string: product.sellerComment + product.sellerComment+product.sellerComment, attributes: attribute)
        
        commentLabel.attributedText = NSMutableAttributedString(attributedString: attributString)
        commentLabel.textAlignment = .justified
        commentLabel.numberOfLines = 0
    }
}
