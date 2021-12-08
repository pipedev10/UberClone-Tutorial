//
//  ContainerController.swift
//  UberClone-Tutorial
//
//  Created by Pipe Carrasco on 03-12-21.
//

import UIKit
import Firebase

class ContainerController: UIViewController {
    
    // MARK: - Properties
    
    private var homeController = HomeController()
    private var menuController: MenuController!
    private var isExpand = false
    
    private var user: User? {
        didSet {
            guard let user = user else {return}
            homeController.user = user
            configureMenuController(withUser: user)
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        configureHomeController()
        fetchUserData()

    }
    // MARK: - Selectors
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { user in
            self.user = user
        }
    }
    
    // MARK: - Helper Functions
    
    func configureHomeController(){
        addChild(homeController)
        homeController.didMove(toParent: self)
        view.addSubview(homeController.view)
        homeController.delegate = self
    }
    
    func configureMenuController(withUser user: User){
        menuController = MenuController(user: user)
        addChild(menuController)
        menuController.didMove(toParent: self)
        view.insertSubview(menuController.view, at: 0)
    }
    
    func animateMenu(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.homeController.view.frame.origin.x = self.view.frame.width - 80
            }, completion: nil)

        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.homeController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle() {
        isExpand.toggle()
        animateMenu(shouldExpand: isExpand)
    }
}
