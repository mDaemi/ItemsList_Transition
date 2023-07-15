//
//  UIView+Loader.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit

extension UIView {
    // MARK: - Properties
    private static let loadingViewTag: Int = 666

    // MARK: - Public
    /// display loadingView if not already display
    public func showLoader(loaderColor: UIColor = .gray) {
        var currentLoadingView: LoadingView?
        if let loadingView = self.loadingView() {
            currentLoadingView = loadingView
            self.bringSubviewToFront(loadingView)
        } else {
            let viewLoading = self.createLoadingView()
            viewLoading.tag = UIView.loadingViewTag
            self.addSubview(viewLoading)
            viewLoading.constraintToSuperview()
            currentLoadingView = viewLoading
        }
        currentLoadingView!.start()
    }

    /// hide current loadingView or do nothing
    public func hideLoader() {
        self.loadingView()?.stop()
        self.loadingView()?.removeFromSuperview()
    }

    // MARK: - Private
    private func createLoadingView() -> LoadingView {
        let loadingView = LoadingView(frame: self.bounds)
        return loadingView
    }

    /// Loading view getter. Get view in self.subviews with tag 666 define for LoadingViewClass
    /// - Returns: LoadingView or nil
    private func loadingView() -> LoadingView? {
        var loading: LoadingView?
        if self.subviews.count > 0 {
            for viewIndex in 0...(self.subviews.count - 1) {
                let currentView = self.subviews[viewIndex]
                if currentView.tag == UIView.loadingViewTag, let currentView = currentView as? LoadingView {
                    loading = currentView
                    break
                }
            }
            return loading
        }
        return nil
    }
}

