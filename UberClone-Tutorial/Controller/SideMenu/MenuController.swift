//
//  MenuController.swift
//  UberClone-Tutorial
//
//  Created by Pipe Carrasco on 03-12-21.
//

import UIKit

private let reuseIdentifier = "MenuCell"

enum MenuOptions: Int, CaseIterable, CustomStringConvertible {
    case yourTrips = 0
    case settings
    case logout
    
    var description: String {
        switch self {
        case .yourTrips: return "Your trips"
        case .settings: return "Settings"
        case .logout: return "Log out"
        }
    }
}

protocol MenuControllerDelegate: AnyObject {
    func didSelect(option: MenuOptions)
}

class MenuController: UITableViewController {
    
    // MARK: - Properties

    private let user: User
    
    private lazy var menuHeader: MenuHeader = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.width - 80,
                           height: 140)
        let view = MenuHeader(user: user, frame: frame)
        return view
    }()
    
    weak var delegate: MenuControllerDelegate?
    
    // MARK: - LifeCycle
    
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableVIew()
    }
    // MARK: - Selectors
    
    // MARK: - Helper Functions
    
    func configureTableVIew(){
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = menuHeader
    }
}

// MARK: - UITableViewDelegate/Datasource

extension MenuController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        guard let option = MenuOptions(rawValue: indexPath.row) else { return UITableViewCell()}
        cell.textLabel?.text = option.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = MenuOptions(rawValue: indexPath.row) else { return }
        print("DEBUG: option is \(option.description)")
        delegate?.didSelect(option: option)
    }
}
