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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = cardModel.backgroundType.titleTextColor
        return label
    }()
    
    var subtitleTop: NSLayoutConstraint = NSLayoutConstraint()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = cardModel.backgroundType.subtitleTextColor
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = cardModel.backgroundType.subtitleTextColor
        return label
    }()
    
    var leftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var rightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var topConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    var appViewTop: NSLayoutConstraint = NSLayoutConstraint()
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
            
            subtitleTop.constant = 20
            appViewTop.constant = 25
            
            addShadow()
        case .full:
            
            let topPadding = UIWindow.topPadding
            
            leftConstraint.constant = 0
            rightConstraint.constant = 0
            topConstraint.constant = 0
            bottomConstraint.constant = 0
            
            subtitleTop.constant = max(20, topPadding)
            appViewTop.constant = max(25, topPadding + 5)
           
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
        
        addBackgroundImage()
        addTopTitleLabels()
        addDescriptionLabel()
    }
    
    // MARK: - Description Label -
    private func addDescriptionLabel() {
        configureDescriptionLabel()
        containerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -40.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0)
        ])
        
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.configureAppSubHeaderLabel(withText: "Salam")
    }
    
    // MARK: - Background Image -
    private func addBackgroundImage() {
        configureBackgroundImage()

        containerView.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        ])
    }
    
    private func configureBackgroundImage() {
        backgroundImageView.image = UIImage(named: "SplashImage")
    }
    
    // MARK: - Top Title Labels -
    private func addTopTitleLabels() {
        configureTopTitleLabels()

        containerView.addSubview(subtitleLabel)
        containerView.addSubview(titleLabel)
        
        let topPadding = UIWindow.topPadding
        var top: CGFloat = 20.0
        if cardModel.viewMode == .full {
            top = max(top, topPadding)
        }
        
        subtitleTop = subtitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top)
        
        NSLayoutConstraint.activate([
            subtitleTop,
            subtitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
            subtitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20.0),
        
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5.0),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20.0),
            
        ])
        
    }
    
    private func configureTopTitleLabels() {
        subtitleLabel.configureSubHeaderLabel(withText: "BY")
        titleLabel.configureHeaderLabel(withText: "HI")
    }
    
    func configure(with viewModel: ProductUIModel) {
    
        self.cardModel = viewModel
        addBackgroundImage()
        addTopTitleLabels()
        addDescriptionLabel()
    }
    
    func hide(views: [UIView]) {
        views.forEach{ $0.removeFromSuperview() }
    }
    
    func show(views: [UIView]) {
        views.forEach{ $0.isHidden = false }
    }
}
