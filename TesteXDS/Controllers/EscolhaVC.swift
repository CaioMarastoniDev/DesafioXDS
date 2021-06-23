//
//  EscolhaVC.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 17/06/21.
//

import UIKit

class EscolhaVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBOutlet weak var escolhaTableView: UITableView!
    
    let networkingService = NetworkingService()
    fileprivate var cardData: [CardResponse] = []
    fileprivate var segueData: CardResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerNibs()
        setupTableView()
        jsonRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        escolhaTableView.reloadData()
    }
    
    //MARK: - SetDataAndDelegate
    private func setDelegate() {
        self.escolhaTableView?.delegate = self
        self.escolhaTableView.dataSource = self
    }
    
    //MARK: - RegisterNib
    private func registerNibs() {
        let escolhaNib = UINib(nibName: "EscolhaTVC", bundle: nil)
        escolhaTableView.register(escolhaNib, forCellReuseIdentifier: "escolhaCell")
        
    }
    
    //MARK: - SetupTableView
    private func setupTableView() {
        escolhaTableView.backgroundColor = KAppColor.init().cardsBackGround
        escolhaTableView.showsVerticalScrollIndicator = false
        escolhaTableView.refreshControl = UIRefreshControl()
        escolhaTableView.refreshControl?.tintColor = .lightGray
        escolhaTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        jsonRequest()
        
    }
    
    //MARK: - FetchCardData
    func jsonRequest() {
        networkingService.requestCard(endpoint: "/pizza") { [weak self] result in
            guard let `self` = self else {return}
            defer { DispatchQueue.main.async {
                self.escolhaTableView.refreshControl?.endRefreshing()
                
                }
            }
            switch result {
            case .success(let card):
                DispatchQueue.main.async {
                    self.cardData = card
                    self.escolhaTableView.reloadData()
                }
                
                print("Sucesso ao retornar os cards")
                
            case.failure(let error):
                print(error)
                
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? CompraViewController
        destinationVC?.name = segueData?.name ?? ""
        destinationVC?.image = segueData?.imageUrl ?? ""
        destinationVC?.rating = segueData?.rating ?? 0.0
        destinationVC?.priceP = segueData?.priceP ?? 0.0
        destinationVC?.priceM = segueData?.priceM ?? 0.0
        destinationVC?.priceG = segueData?.priceG ?? 0.0
    }
    
}

extension EscolhaVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueData = cardData[indexPath.row]
        performSegue(withIdentifier: "compraSegue", sender: segueData)
    }
    
}

extension EscolhaVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = escolhaTableView.dequeueReusableCell(withIdentifier: "escolhaCell") as? EscolhaTVC else {return UITableViewCell()}
        guard let getUrl = URL(string: cardData[indexPath.row].imageUrl) else {return UITableViewCell()}
        let getName = cardData[indexPath.row].name
        let getPrice = cardData[indexPath.row].priceP
        let rating = cardData[indexPath.row].rating
        
        cell.configCell(url: getUrl, name: getName, price: getPrice, rating: rating)
        
        return cell
        
    }

}
