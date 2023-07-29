//
//  AuthAppDelegate.swift
//
//  Auth
//
//  Created by hyerin on .
//

import UIKit

import AuthUserInterface
import AuthUserInterfaceImpl
import AuthDomain
import AuthDomainImpl
import AuthData

import RIBs
import RxSwift

@main
final class AuthAppDelegate: UIResponder, UIApplicationDelegate {
    
    private final class MockSignInListener: LoggedOutListener {
        func didCompleteAuth() {
            fatalError()
        }
    }
    private final class MockSignUpListener: SignUpListener {
        func didCompleteSignUp() {
            fatalError()
        }
    }
    
    var window: UIWindow?
    private var router: ViewableRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        router = LoggedOutBuilder(dependency: MOCKAuthComponent())
            .build(withListener: MockSignInListener())
//        router = SignUpBuilder(dependency: MockSignUpComponent())
//            .build(
//                withListener: MockSignUpListener(),
//                signInResponse: MOITSignInRespxonse(headerFields: [:])
//            )
        router?.interactable.activate()
        router?.load()
        
        window.rootViewController = self.router?.viewControllable.uiviewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
//
//final class MockSignUpComponent: Component<EmptyDependency>,
//                                 SignUpDependency,
//                                 ProfileSelectDependency
//{
//    
//    var fetchRandomNumberUseCase: FetchRandomNumberUseCase
//    
//    var signUpUseCase: SignUpUseCase
//    
//    lazy var profileSelectBuildable: ProfileSelectBuildable = ProfileSelectBuilder(dependency: self)
//    
//    init() {
//        self.fetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
//        self.signUpUseCase = SignUpUseCaseImpl(authRepository: AuthRepositoryim)
//        super.init(dependency: EmptyComponent())
//    }
//}
