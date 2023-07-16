//
//  ProductCardView.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//
import UIKit

class CardView: UIView {
    
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
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var featuredTitleCenter: NSLayoutConstraint = NSLayoutConstraint()
    lazy var featuredTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowOffset = CGSize(width: -1, height: 1)
        label.layer.shadowOpacity = 0.1
        label.layer.shadowRadius = 5
        label.textColor = .heroTextColor
        return label
    }()
    
    var leftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var rightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var topConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    var cardModel: ProductUIModel
    
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
    func addShadow() {
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 2)
    }
    
    func removeShadow() {
        shadowView.layer.shadowColor = UIColor.clear.cgColor
        shadowView.layer.shadowOpacity = 0
        shadowView.layer.shadowRadius = 0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func updateLayout(for viewMode: CardViewMode) {
        switch viewMode {
        case .card:
            leftConstraint.constant = 20
            rightConstraint.constant = -20
            topConstraint.constant = 15
            bottomConstraint.constant = -15
            featuredTitleCenter.constant = 20
            
            addShadow()
            
        case .full:
            let topPadding = 8
            leftConstraint.constant = 0
            rightConstraint.constant = 0
            topConstraint.constant = 0
            bottomConstraint.constant = 0
            featuredTitleCenter.constant = CGFloat(max(20, topPadding))

            removeShadow()
        }
    }
    
    func convertContainerViewToCardView() {
        updateLayout(for: .card)

        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
    }
    
    func convertContainerViewToFullScreen() {
        updateLayout(for: .full)

        containerView.layer.cornerRadius = 0
        containerView.layer.masksToBounds = true
    }
    
    // MARK: - Configure View -
    func configureViews() {
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
        
        addBackgroundImage(withApp: true)
        addFeaturedTitle()
    }
    
    // MARK: - Background Image -
    private func addBackgroundImage(withApp hasApp: Bool) {
        configureBackgroundImage()

        containerView.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        ])

        let topPadding = 8
        var top: CGFloat = 25.0
        
        if cardModel.viewMode == .full {
            top = max(top, CGFloat(topPadding + 5))
        }
    }
    
    private func configureBackgroundImage() {
        // TODO: 
//        guard let backgroundImage = cardModel.backgroundImage else { return }
//        backgroundImageView.image = backgroundImage
    }
    
    // MARK: - Featured Title -
    private func addFeaturedTitle() {

        containerView.addSubview(featuredTitleLabel)
        
        let topPadding = 8
        var center: CGFloat = 20.0
        
        if cardModel.viewMode == .full {
            center = max(center, CGFloat(topPadding))
        }
        
        featuredTitleCenter = featuredTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: center)
        
        NSLayoutConstraint.activate([
            featuredTitleCenter,
            featuredTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
            featuredTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6)
        ])

        configureFeaturedTitle()
    }
    
    private func configureFeaturedTitle() {
        featuredTitleLabel.configureHeroLabel(withText: "APP\nOF THE\nDAY")
    }
    
    func configure(with viewModel: ProductUIModel) {
        
        self.cardModel = viewModel
        
        // TODO:
//        hide(views: [self.titleLabel, self.subtitleLabel, self.descriptionLabel, self.tableView])
        addBackgroundImage(withApp: true)
        addFeaturedTitle()
    }
    
    func hide(views: [UIView]) {
        views.forEach{ $0.removeFromSuperview() }
    }
    
    func show(views: [UIView]) {
        views.forEach{ $0.isHidden = false }
    }
}
