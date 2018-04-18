//
//  PasswordCreatePresenter.swift
//  SwiftLightning
//
//  Created by Howard Lee on 2018-04-17.
//  Copyright (c) 2018 BiscottiGelato. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PasswordCreatePresentationLogic
{
  func presentSceneUpdate(response: PasswordCreate.ValidatePasswords.Response)
}

class PasswordCreatePresenter: PasswordCreatePresentationLogic
{
  weak var viewController: PasswordCreateDisplayLogic?
  
  // MARK: Do something
  
  func presentSceneUpdate(response: PasswordCreate.ValidatePasswords.Response)
  {
    let passwordLabelText = response.passwordFieldStatus.rawValue
    var passwordLabelColor: UIColor
    
    switch response.passwordFieldStatus {
    case .needMoreCharacters, .passwordOk:
      passwordLabelColor = .normalText
    case .tooManyCharacters:
      passwordLabelColor = .jellyBeanRed
    }
    
    let confirmLabelText = response.confirmFieldStatus.rawValue
    var confirmLabelColor: UIColor
    
    switch response.confirmFieldStatus {
    case .confirmationOk, .needsConfirmation:
      confirmLabelColor = .normalText
    case .passwordMismatch:
      confirmLabelColor = .jellyBeanRed
    }
    
    let enableProceedButton = response.passwordFieldStatus == .passwordOk && response.confirmFieldStatus == .confirmationOk
    
    let viewModel = PasswordCreate.ValidatePasswords.ViewModel(passwordFieldLabelText: passwordLabelText,
                                                               passwordFieldLabelColor: passwordLabelColor,
                                                               confirmFieldLabelText: confirmLabelText,
                                                               confirmFieldLabelColor: confirmLabelColor,
                                                               proceedButtonEnabled: enableProceedButton)
    viewController?.updateSceneView(viewModel: viewModel)
  }
}
