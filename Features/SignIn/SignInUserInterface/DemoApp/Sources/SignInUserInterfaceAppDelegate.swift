//
//  SignInAppDelegate.swift
//
//  SignIn
//
//  Created by hyerin on .
//

import UIKit

import SignInUserInterface
import SignInUserInterfaceImpl
import SignUpUserInterface
import SignUpUserInterfaceImpl
import SignUpDomain
import SignUpDomainImpl
import SignUpData
import MOITWeb
import MOITWebImpl

import RIBs
import RxSwift

@main
final class SignInAppDelegate: UIResponder, UIApplicationDelegate {
	
	
	final class MockJoinRepository: JoinRepository {
	 
		 func post(imageIndex: Int, name: String, inviteCode: String?) -> Single<Int> {
			 Single.just(3)
		 }
	 }

	
	private final class MockSignInComponent: Component<EmptyDependency>,
											 LoggedOutDependency,
											 SignUpDependency,
											 ProfileSelectDependency {
		
		init() {
			super.init(dependency: EmptyComponent())
		}
		
		lazy var signUpBuildable: SignUpBuildable = {
			return SignUpBuilder(dependency: self)
		}()
		
		var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
		
		var postJoinInfoUseCase: PostJoinInfoUseCase = PostJoinInfoUseCaseImpl(joinRepository: MockJoinRepository())
		
		lazy var profileSelectBuildable: ProfileSelectBuildable = {
			return ProfileSelectBuilder(dependency: self)
		}()
	}

	private final class MockSignInListener: LoggedOutListener {
		
	}
	
    var window: UIWindow?
	
	private var router: ViewableRouting?
	
    func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
		
		router = LoggedOutBuilder(dependency: MockSignInComponent())
			.build(withListener: MockSignInListener())
		router?.load()
		router?.interactable.activate()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window

		return true
    }
}

