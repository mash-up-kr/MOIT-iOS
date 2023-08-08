//
//  FineAppDelegate.swift
//
//  Fine
//
//  Created by hyerin on .
//

import UIKit

import FineUserInterface
import FineUserInterfaceImpl
import FineDomain
import FineDomainImpl
import FineData
import FineDataImpl
import MOITDetailDomain
import MOITDetailDomainImpl
import MOITNetworkImpl
import TokenManagerImpl

import RIBs

@main
final class FineAppDelegate: UIResponder, UIApplicationDelegate {
	
	private final class MockFineDependency: FineListDependency {
		var postFineEvaluateUseCase: PostFineEvaluateUseCase
		var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase
		var compareUserIDUseCase: CompareUserIDUseCase
		var fetchFineInfoUseCase: FetchFineInfoUseCase
		var filterMyFineListUseCase: FilterMyFineListUseCase
		var fetchFineItemUseCase: FetchFineItemUseCase
		var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase
		
		init(
			fetchFineInfoUseCase: FetchFineInfoUseCase,
			compareUserIDUseCase: CompareUserIDUseCase,
			filterMyFineListUseCase: FilterMyFineListUseCase,
			fetchFineItemUseCase: FetchFineItemUseCase,
			convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase,
			postFineEvaluateUseCase: PostFineEvaluateUseCase,
			postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase
		) {
			self.fetchFineInfoUseCase = fetchFineInfoUseCase
			self.compareUserIDUseCase = compareUserIDUseCase
			self.filterMyFineListUseCase = filterMyFineListUseCase
			self.fetchFineItemUseCase = fetchFineItemUseCase
			self.convertAttendanceStatusUseCase = convertAttendanceStatusUseCase
			self.postFineEvaluateUseCase = postFineEvaluateUseCase
			self.postMasterAuthorizeUseCase = postMasterAuthorizeUseCase
		}
	}
	
	private final class MockFineListener: FineListListener {
		func fineListViewDidTap(moitID: Int, fineID: Int, isMaster: Bool) {
			//
		}
	}
	
    var window: UIWindow?
	
	private var router: ViewableRouting?
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
		let fetchFineInfoUseCase = FetchFineInfoUseCaseImpl(fineRepository: FineRepositoryImpl(network: NetworkImpl()))
		let compareUserIDUseCase = CompareUserIDUseCaseImpl(tokenManager: TokenManagerImpl())
		let filterMyFineListUseCase = FilterMyFineListUseCaseImpl(tokenManager: TokenManagerImpl())
		let fetchFineItemUseCase = FetchFineItemUseCaseImpl(fineRepository: FineRepositoryImpl(network: NetworkImpl()))
		let convertAttendanceStatusUseCase = ConvertAttendanceStatusUseCaseImpl()
		let postFineEvaluateUseCase = PostFineEvaluateUseCaseImpl(repository: FineRepositoryImpl(network: NetworkImpl()))
		let postMasterAuthorizeUseCase = PostMasterAuthorizeUseCaseImpl(repository: FineRepositoryImpl(network: NetworkImpl()))
		
		router = FineListBuilder(
			dependency: MockFineDependency(
				fetchFineInfoUseCase: fetchFineInfoUseCase,
				compareUserIDUseCase: compareUserIDUseCase,
				filterMyFineListUseCase: filterMyFineListUseCase,
				fetchFineItemUseCase: fetchFineItemUseCase,
				convertAttendanceStatusUseCase: convertAttendanceStatusUseCase,
				postFineEvaluateUseCase: postFineEvaluateUseCase,
				postMasterAuthorizeUseCase: postMasterAuthorizeUseCase
			)
		)
			.build(withListener: MockFineListener(), moitID: 2)
		router?.interactable.activate()
		router?.load()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window
		
        return true
    }
}
