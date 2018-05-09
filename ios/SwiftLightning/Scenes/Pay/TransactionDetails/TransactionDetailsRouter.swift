//
//  TransactionDetailsRouter.swift
//  SwiftLightning
//
//  Created by Howard Lee on 2018-05-08.
//  Copyright (c) 2018 BiscottiGelato. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol TransactionDetailsRoutingLogic
{
  func routeToWalletMain()
}

protocol TransactionDetailsDataPassing
{
  var dataStore: TransactionDetailsDataStore? { get }
}

class TransactionDetailsRouter: NSObject, TransactionDetailsRoutingLogic, TransactionDetailsDataPassing
{
  weak var viewController: TransactionDetailsViewController?
  var dataStore: TransactionDetailsDataStore?
  
  // MARK: Routing
  
  func routeToWalletMain() {
    //    let destinationVC = viewController! as! WalletMainViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToWalletMain(source: dataStore!, destination: &destinationDS)
    navigateToWalletMain(source: viewController!)
  }
  
  
  // MARK: Navigation
  
  func navigateToWalletMain(source: TransactionDetailsViewController) {
    guard let navigationController = source.navigationController else {
      SLLog.assert("\(type(of: source)).navigationController = nil")
      return
    }
    navigationController.popViewController(animated: true)
  }
  
  // MARK: Passing data
  
  func passDataToWalletMain(source: TransactionDetailsDataStore, destination: inout WalletMainDataStore) { }
}
