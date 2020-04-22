
//  productImageViewController.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.


import SwiftUI
import UIKit

struct ProductImageViewController: UIViewControllerRepresentable {
    
    var controllers: [UIViewController]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let productImageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        productImageViewController.dataSource = context.coordinator
        productImageViewController.delegate = context.coordinator
        
        return productImageViewController
    }
    
    func updateUIViewController(_ productImageViewController: UIPageViewController, context: Context) {
        productImageViewController.setViewControllers(
            [controllers[currentPage]], direction: .forward, animated: true)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: ProductImageViewController
        
        init(_ productImageViewController: ProductImageViewController) {
            self.parent = productImageViewController
        }
        
        func pageViewController(
            _ productImageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return parent.controllers.last
            }
            return parent.controllers[index - 1]
        }
        
        func pageViewController(
            _ productImageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            return parent.controllers[index + 1]
        }
        
        func pageViewController(_ productImageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = productImageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
    }
    
}
