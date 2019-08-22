//
//  KTestTagTableVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/22.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KTestTagTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }

    private let records = ["Festival", "Salvador", "EuroVision", "Beer", "The Room", "The Disaster Movie", "Let's Go", "Bibofir", "The Shape of Water", "It", "American History", "Beautiful", "Sicario"]

   

}

extension KTestTagTableVC {
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(self.refreshButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeTapped))
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.allowsSelection = false
        tableView.register(TagsViewCell.self, forCellReuseIdentifier: String(describing: TagsViewCell.self))
    }
}

extension KTestTagTableVC {
    @objc func refreshButtonTapped() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @objc func closeTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension KTestTagTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TagsViewCell.self), for: indexPath) as? TagsViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        cell.tagsField.onDidChangeHeightTo = { [weak tableView] _, _ in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        
        return cell
    }
}

class TagsViewCell: UITableViewCell {
    
    let tagsField = KYLTagsField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tagsField.addTag("alksjlkasd")
        tagsField.addTag("alksjlkasd1")
        tagsField.addTag("alksjlkasd2")
        tagsField.addTag("alksjlkasd3")
        tagsField.addTag("alksjlkasd4")
        tagsField.addTag("alksjlkasdsds5")
        
        tagsField.placeholderAlwaysVisible = true
        tagsField.backgroundColor = .lightGray
        
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        
        tagsField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tagsField)
        
        NSLayoutConstraint.activate([
            tagsField.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagsField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tagsField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: tagsField.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

