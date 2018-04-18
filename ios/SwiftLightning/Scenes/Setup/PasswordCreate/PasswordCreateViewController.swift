//
//  PasswordCreateViewController.swift
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

protocol PasswordCreateDisplayLogic: class
{
  func updateSceneView(viewModel: PasswordCreate.ValidatePasswords.ViewModel)
}

class PasswordCreateViewController: UIViewController, PasswordCreateDisplayLogic, UITextFieldDelegate
{
  var interactor: PasswordCreateBusinessLogic?
  var router: (NSObjectProtocol & PasswordCreateRoutingLogic & PasswordCreateDataPassing)?

  
  // MARK: Common IBOutlets
  
  @IBOutlet weak var passwordField: SLPasswordField!
  @IBOutlet weak var confirmField: SLPasswordField!
  @IBOutlet weak var proceedButton: SLBarButton!
  
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = PasswordCreateInteractor()
    let presenter = PasswordCreatePresenter()
    let router = PasswordCreateRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    passwordField.textField.delegate = self
    confirmField.textField.delegate = self
    passwordField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    confirmField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    validatePasswords()
  }
  
  
  // MARK: Text fields
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    textField.resignFirstResponder()
    
    if textField == passwordField.textField {
      confirmField.textField.becomeFirstResponder()
    }
    return true
  }
  
  
  // MARK: Validate passwords
  
  @objc private func textFieldDidChange(_ textField: UITextField) {
    validatePasswords()
  }
  
  func validatePasswords()
  {
    let passwordText = passwordField.textField.text ?? ""
    let confirmText = confirmField.textField.text ?? ""
    let request = PasswordCreate.ValidatePasswords.Request(passwordText: passwordText,
                                                           confirmText: confirmText)
    interactor?.validatePasswords(request: request)
  }
  
  func updateSceneView(viewModel: PasswordCreate.ValidatePasswords.ViewModel)
  {
    passwordField.infoLabel.text = viewModel.passwordFieldLabelText
    passwordField.infoLabel.textColor = viewModel.passwordFieldLabelColor
    confirmField.infoLabel.text = viewModel.confirmFieldLabelText
    confirmField.infoLabel.textColor = viewModel.confirmFieldLabelColor
    
    if viewModel.proceedButtonEnabled {
      proceedButton.setTitleColor(UIColor.disabledText, for: .normal)
      proceedButton.backgroundColor = UIColor.medAquamarine
      proceedButton.shadowColor = UIColor.medAquamarineShadow
      proceedButton.isEnabled = true
    } else {
      proceedButton.setTitleColor(UIColor.disabledText, for: .normal)
      proceedButton.backgroundColor = UIColor.disabledGray
      proceedButton.shadowColor = UIColor.disabledGrayShadow
      proceedButton.isEnabled = false
    }
  }
  
  
  // MARK: Proceed
  
  @IBAction func proceedTapped(_ sender: SLBarButton) {
    
  }
}
