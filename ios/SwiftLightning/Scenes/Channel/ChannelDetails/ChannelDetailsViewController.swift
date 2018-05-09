//
//  ChannelDetailsViewController.swift
//  SwiftLightning
//
//  Created by Howard Lee on 2018-05-04.
//  Copyright (c) 2018 BiscottiGelato. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChannelDetailsDisplayLogic: class {
  func displayRefresh(viewModel: ChannelDetails.Refresh.ViewModel)
  func displayConnected(viewModel: ChannelDetails.Connect.ViewModel)
  func displayClosed(viewModel: ChannelDetails.Close.ViewModel)
  func displayError(viewModel: ChannelDetails.ErrorVM)
}

class ChannelDetailsViewController: UIViewController, ChannelDetailsDisplayLogic {
  var interactor: ChannelDetailsBusinessLogic?
  var router: (NSObjectProtocol & ChannelDetailsRoutingLogic & ChannelDetailsDataPassing)?
  
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
    let interactor = ChannelDetailsInteractor()
    let presenter = ChannelDetailsPresenter()
    let router = ChannelDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refreshView()
  }
  
  
  // MARK: Refresh Views
  
  @IBOutlet weak var nodeView: SLFormNodeView!
  @IBOutlet weak var statusLabelView: SLFormCompactView!
  @IBOutlet weak var channelPointView: SLFormLabelView!
  @IBOutlet weak var channelCapacityView: SLFormChSummaryView!
  
  @IBOutlet weak var confirmationsSpacer: UIView!
  @IBOutlet weak var confirmationsLabelView: SLFormCompactView!
  
  @IBOutlet weak var closingSpacer: UIView!
  @IBOutlet weak var closingLabelView: SLFormLabelView!
  
  @IBOutlet weak var blksTillMaturitySpacer: UIView!
  @IBOutlet weak var blksTillMaturityLabelView: SLFormCompactView!
  
  @IBOutlet weak var buttonView: UIView!
  @IBOutlet weak var leftButton: SLBarButton!
  @IBOutlet weak var rightButton: SLBarButton!
  
  
  private func refreshView() {
    let request = ChannelDetails.Refresh.Request()
    interactor?.refresh(request: request)
  }
  
  func displayRefresh(viewModel: ChannelDetails.Refresh.ViewModel) {
    DispatchQueue.main.async {
      self.nodeView.nodePubKeyLabel.text = viewModel.nodePubKey
      self.nodeView.ipAddressLabel.text = viewModel.ipAddr ?? ""
      self.nodeView.portNumberLabel.text = viewModel.port ?? ""
      self.nodeView.aliasNameLabel.text = viewModel.alias ?? ""
      
      self.statusLabelView.textLabel.text = viewModel.statusText
      self.statusLabelView.textLabel.textColor = viewModel.statusColor
      self.channelPointView.textLabel.text = viewModel.channelPoint
      
      if let confHeight = viewModel.confHeight {
        self.confirmationsSpacer.isHidden = false
        self.confirmationsLabelView.isHidden = false
        self.confirmationsLabelView.textLabel.text = confHeight
      } else {
        self.confirmationsSpacer.isHidden = true
        self.confirmationsLabelView.isHidden = true
      }
      
      if let closingTxID = viewModel.closingTxID {
        self.closingSpacer.isHidden = false
        self.closingLabelView.isHidden = false
        self.closingLabelView.textLabel.text = closingTxID
      } else {
        self.closingSpacer.isHidden = true
        self.closingLabelView.isHidden = true
      }
      
      if let blksTillMaturity = viewModel.blksTilMaturity {
        self.blksTillMaturitySpacer.isHidden = false
        self.blksTillMaturityLabelView.isHidden = false
        self.blksTillMaturityLabelView.textLabel.text = blksTillMaturity
      } else {
        self.blksTillMaturitySpacer.isHidden = true
        self.blksTillMaturityLabelView.isHidden = true
      }
      
      self.channelCapacityView.canPayAmtLabel.text = viewModel.canPayAmt
      self.channelCapacityView.canRcvAmtLabel.text = viewModel.canRcvAmt
      
      self.leftButton.isHidden = viewModel.leftButtonHidden
      self.rightButton.isHidden = viewModel.rightButtonHidden
      
      if viewModel.leftButtonHidden, viewModel.rightButtonHidden {
        self.buttonView.isHidden = true
      } else {
        self.buttonView.isHidden = false
      }
    }
  }
  
  
  let activityIndicator = SLSpinnerDialogView()
  
  // MARK: Connect Channel
  
  @IBAction func connectTapped(_ sender: SLBarButton) {
    activityIndicator.show(on: view)
    
    let request = ChannelDetails.Connect.Request()
    interactor?.connect(request: request)
  }
  
  func displayConnected(viewModel: ChannelDetails.Connect.ViewModel) {
    
//    let alertDialog = UIAlertController(title: "Connect Submitted",
//                                        message: "Are you now connected? If not, the remote node might not be currently online",
//                                        preferredStyle: .alert).addAction(title: "OK", style: .default) { action in
//
//      self.refreshView()  // Refresh again for good measures
//    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      self.refreshView()
      self.activityIndicator.remove()
      // self.present(alertDialog, animated: true, completion: nil)
    }
  }
  
  
  // MARK: (Force) Close Channel
  
  @IBAction func closeTapped(_ sender: SLBarButton) {
    let alertDialog = UIAlertController(title: "Close Channel?",
                                        message: "Are you sure you want to close this channel?",
                                        preferredStyle: .alert)
    
    _ = alertDialog.addAction(title: "Cancel", style: .cancel)
    _ = alertDialog.addAction(title: "Yes", style: .destructive) { (action) in
      self.activityIndicator.show(on: self.view)
      let request = ChannelDetails.Close.Request(force: false)
      self.interactor?.close(request: request)
    }

    present(alertDialog, animated: true, completion: nil)
  }
  
  @IBAction func closeLongPressed(_ sender: UILongPressGestureRecognizer) {
    let alertDialog = UIAlertController(title: "Force Close?",
                                        message: "Are you sure you want to 'Force Close' this channel?",
                                        preferredStyle: .alert)
    
    _ = alertDialog.addAction(title: "Cancel", style: .cancel)
    _ = alertDialog.addAction(title: "Force", style: .destructive) { (action) in
      self.activityIndicator.show(on: self.view)
      let request = ChannelDetails.Close.Request(force: true)
      self.interactor?.close(request: request)
    }
    
    present(alertDialog, animated: true, completion: nil)
  }
  
  func displayClosed(viewModel: ChannelDetails.Close.ViewModel) {
    let alertDialog = UIAlertController(title: "Close Submitted",
                                        message: "Note it will take several confirmations before you will see funds back on-chain",
                                        preferredStyle: .alert).addAction(title: "OK", style: .default) { (action) in
                                          self.router?.routeToWalletMain()
    }
    
    DispatchQueue.main.async {
      self.activityIndicator.remove()
      self.present(alertDialog, animated: true, completion: nil)
    }
  }
  
  // MARK: Error Display
  
  func displayError(viewModel: ChannelDetails.ErrorVM) {
    let alertDialog = UIAlertController(title: viewModel.errTitle,
                                        message: viewModel.errMsg, preferredStyle: .alert).addAction(title: "OK", style: .default)
    DispatchQueue.main.async {
      self.present(alertDialog, animated: true, completion: nil)
      self.activityIndicator.remove()
    }
  }
  
  
  // MARK: Close Cross Tapped
  
  @IBAction func closeCrossTapped(_ sender: UIBarButtonItem) {
    router?.routeToWalletMain()
  }
  
}
