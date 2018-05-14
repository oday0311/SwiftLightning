//
//  NeutrinoPeersViewController.swift
//  SwiftLightning
//
//  Created by Howard Lee on 2018-05-13.
//  Copyright (c) 2018 BiscottiGelato. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NeutrinoPeersDisplayLogic: class {
  func displayCurrentPeers(viewModel: NeutrinoPeers.CurrentPeers.ViewModel)
  func displayPeersWritten(viewModel: NeutrinoPeers.WritePeers.ViewModel)
}


class NeutrinoPeersViewController: SLViewController, NeutrinoPeersDisplayLogic, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
  var interactor: NeutrinoPeersBusinessLogic?
  var router: (NSObjectProtocol & NeutrinoPeersRoutingLogic & NeutrinoPeersDataPassing)?

  
  // MARK: Constants
  
  struct Constants {
    static let peerCellReuseID = "PeerCell"
  }
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = NeutrinoPeersInteractor()
    let presenter = NeutrinoPeersPresenter()
    let router = NeutrinoPeersRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  
  // MARK: IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Manage keyboard bottom adjustment
    keyboardScrollView = tableView
    
    // TableView registrations
    let nib = UINib(nibName: "PeerAddrTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: Constants.peerCellReuseID)
    tableView.allowsSelection = false
    tableView.delegate = self
    tableView.dataSource = self
    
    let request = NeutrinoPeers.CurrentPeers.Request()
    interactor?.fetchCurrentPeers(request: request)
  }


  // MARK: TableView Delegates
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return PeerAddrTableViewCell.Constants.preferredHeight
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return neutrinoPeerAddrs.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.peerCellReuseID, for: indexPath) as? PeerAddrTableViewCell else {
      SLLog.fatal("Dequeued cell with identifier \(Constants.peerCellReuseID) not of PeerAddrTableViewCell type")
    }
    
    cell.setPeerAddrLabel(withIdx: indexPath.row + 1)
    cell.peerAddrTextField.text = neutrinoPeerAddrs[indexPath.row]
    return cell
  }
  
  
  // MARK: TextField Delegates
  
  func textFieldDidEndEditing(_ textField: UITextField) {

  }
  
  
  // MARK: Fetch Current Peers
  
  var neutrinoPeerAddrs = [String]()
  
  func displayCurrentPeers(viewModel: NeutrinoPeers.CurrentPeers.ViewModel) {
    
  }
  
  
  // MARK: Add Neutrino Peer
  
  @IBAction func addPeersTapped(_ sender: UIBarButtonItem) {

  }
 
  
  // MARK: Remove Peer
  
  
  // MARK: Write Neutrino Peers
  
  @IBAction func updatePeersTapped(_ sender: SLBarButton) {
  }
  
  func displayPeersWritten(viewModel: NeutrinoPeers.WritePeers.ViewModel) {
    
  }
  
  // MARK: Display Error Dialog
  
  
  // MARK: Close Cross Tapped
  
  @IBAction func closeCrossTapped(_ sender: UIBarButtonItem) {
  }
  
}
