//
//  ViewController.swift
//  TableViewPrefetchingDemo
//
//  Created by Genusys Inc on 6/27/22.
//

import UIKit

class ViewController: UIViewController {

    
    private let tableView = UITableView()
    private let viewModels = Array(1...100).map{_ in ViewModel()}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTVCell.self, forCellReuseIdentifier: ImageTVCell.identifire)
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.separatorStyle = .none
        tableView.prefetchDataSource = self
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTVCell.identifire, for: indexPath) as! ImageTVCell
        
        cell.configure(viewModels[indexPath.row])
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            let viewmodel = viewModels[indexPath.row]
            viewmodel.downloadImage(completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

