//
//  NeutrinoPeersRouter.swift
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

@objc protocol NeutrinoPeersRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol NeutrinoPeersDataPassing
{
  var dataStore: NeutrinoPeersDataStore? { get }
}

class NeutrinoPeersRouter: NSObject, NeutrinoPeersRoutingLogic, NeutrinoPeersDataPassing
{
  weak var viewController: NeutrinoPeersViewController?
  var dataStore: NeutrinoPeersDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: NeutrinoPeersViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: NeutrinoPeersDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
