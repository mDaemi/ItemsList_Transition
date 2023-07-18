//
//  ProductCardView.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//
import UIKit

class CardView: UIView {
    
    // MARK: - Properties -
    var cardModel: ProductUIModel
    private var leftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var rightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var topConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var headlineTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var imageTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var appViewTop: NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK: - Views -
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var starView: StarView = {
        let view = StarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nbReviewLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightTextColor
        return label
    }()
    
    lazy var usedPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightTextColor
        return label
    }()
    
    // MARK: - init -
    init(cardModel: ProductUIModel) {
        self.cardModel = cardModel
        
        super.init(frame: .zero)
        
        leftConstraint = containerView.leftAnchor.constraint(equalTo: self.leftAnchor)
        rightConstraint = containerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        topConstraint = containerView.topAnchor.constraint(equalTo: self.topAnchor)
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Shadow -
    private func addShadow() {
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 2)
    }
    
    private func removeShadow() {
        shadowView.layer.shadowColor = UIColor.clear.cgColor
        shadowView.layer.shadowOpacity = 0
        shadowView.layer.shadowRadius = 0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    // MARK: - handle full and card mode -
    func updateLayout(for viewMode: CardViewMode) {
        switch viewMode {
        case .card:
            leftConstraint.constant = 20
            rightConstraint.constant = -20
            topConstraint.constant = 15
            bottomConstraint.constant = -15
            
            headlineTopConstraint.constant = 20
            imageTopConstraint.constant = 20
            appViewTop.constant = 25
            
            addShadow()
        case .full:
            
            let topPadding = UIWindow.topPadding
            
            leftConstraint.constant = 0
            rightConstraint.constant = 0
            topConstraint.constant = 0
            bottomConstraint.constant = 0
            
            headlineTopConstraint.constant = max(20, topPadding)
            imageTopConstraint.constant = max(20, topPadding)
            appViewTop.constant = max(25, topPadding + 5)
           
            removeShadow()
        }
    }
    
    private func convertContainerViewToCardView() {
        updateLayout(for: .card)

        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
    }
    
    private func convertContainerViewToFullScreen() {
        updateLayout(for: .full)

        containerView.layer.cornerRadius = 0
        containerView.layer.masksToBounds = true
    }
    
    // MARK: - Configure View -
    private func configureViews() {
        backgroundColor = .clear
        addSubview(shadowView)
        addSubview(containerView)
        
        if cardModel.viewMode == .card {
            convertContainerViewToCardView()
        } else {
            convertContainerViewToFullScreen()
        }
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: containerView.topAnchor),
            shadowView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            shadowView.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        ])
        
        addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        
        addProductImage()
        addHeadlineLabel()
        addStarView()
        addPricesLabel()
    }
    
    func configure(with viewModel: ProductUIModel) {
        self.cardModel = viewModel
        addProductImage()
        addHeadlineLabel()
        addStarView()
        addPricesLabel()
    }
    
    // MARK: - product image -
    private func addProductImage() {
        configureProductImage()
        containerView.addSubview(imageView)
        
        imageTopConstraint = imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topPadding())
        
        NSLayoutConstraint.activate([
            imageTopConstraint,
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20.0),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(constraint.cardHeight) * 0.5)
        ])
    }
    
    private func configureProductImage() {
        imageView.loadImage(urlString: cardModel.imageUrl, placeholderImage: UIImage(named: "place_holder"), errorImage: UIImage(named: "place_holder"))
    }
    
    // MARK: - headLine Label -
    private func addHeadlineLabel() {
        configureheadlineLabel()
        containerView.addSubview(headlineLabel)
        
        headlineTopConstraint = headlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topPadding())
        
        NSLayoutConstraint.activate([
            headlineTopConstraint,
            headlineLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12.0),
            headlineLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25.0)
        ])
    }
    
    private func configureheadlineLabel() {
        headlineLabel.configureHeaderLabel(withText: cardModel.headline)
    }
    
    // MARK: - star view -
    private func addStarView() {
        configureusedStarView()
        containerView.addSubview(starView)
        containerView.addSubview(nbReviewLable)
        
        starView.anchor(top: headlineLabel.bottomAnchor, left: imageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 110, height: 20)
        
        NSLayoutConstraint.activate([
            nbReviewLable.leftAnchor.constraint(equalTo: starView.rightAnchor, constant: 5.0),
            nbReviewLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0),
            nbReviewLable.centerYAnchor.constraint(equalTo: starView.centerYAnchor)
        ])
    }
    
    private func configureusedStarView() {
        starView.configure(starRating: cardModel.reviewsAverageNote)
        nbReviewLable.configureAppSubHeaderLabel(withText: "\(cardModel.nbReviews) Avis")
    }
    
    // MARK: - prices Label -
    private func addPricesLabel() {
        configureusedPriceLabel()
        containerView.addSubview(newPriceLabel)
        containerView.addSubview(usedPriceLabel)

        newPriceLabel.anchor(top: starView.bottomAnchor, left: imageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: -20)
        
        usedPriceLabel.anchor(top: newPriceLabel.bottomAnchor, left: imageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: -20)
    }
    
    private func configureusedPriceLabel() {
        newPriceLabel.configureSubHeaderLabel(withText: "Neuf dès \(cardModel.newBestPrice)")
        usedPriceLabel.configureSubHeaderLabel(withText: "Occasion dès \(cardModel.usedBestPrice)")
    }
    
    private func topPadding() -> CGFloat {
        let topPadding = UIWindow.topPadding
        var top: CGFloat = 20.0
        if cardModel.viewMode == .full {
            top = max(top, topPadding)
        }
        return top
    }
}
