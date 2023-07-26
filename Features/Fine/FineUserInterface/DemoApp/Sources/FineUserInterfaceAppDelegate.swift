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
import MOITNetworkImpl

import RIBs

@main
final class FineAppDelegate: UIResponder, UIApplicationDelegate {
	
	private final class MockFineDependency: FineListDependency,
											FineListInteractorDependency {
		var fetchFineInfoUseCase: FetchFineInfoUseCase
		
		init(
			fetchFineInfoUseCase: FetchFineInfoUseCase
		) {
			self.fetchFineInfoUseCase = fetchFineInfoUseCase
		}
	}
	
	private final class MockFineListener: FineListListener { }
	
    var window: UIWindow?
	
	private var router: ViewableRouting?
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
		let fetchFineInfoUseCase = FetchFineInfoUseCaseImpl(fineRepository: FineRepositoryImpl(network: NetworkImpl()))
		
		router = FineListBuilder(
			dependency: MockFineDependency(fetchFineInfoUseCase: fetchFineInfoUseCase)
		)
			.build(withListener: MockFineListener(), moitID: "2")
		router?.interactable.activate()
		router?.load()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window
		
        return true
    }
}

// TODO: 추후 삭제
//	fileprivate let myDefaulterList = [
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 15000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .late,
//				studyOrder: 3,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 20000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .absent,
//				studyOrder: 4,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 15000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .late,
//				studyOrder: 3,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 15000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .late,
//				studyOrder: 3,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 15000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .late,
//				studyOrder: 3,
//				isApproved: false,
//				approveAt: ""
//			)
//		),
//		FineList(
//			fineItem: FineItem(
//				id: 0,
//				fineAmount: 15000,
//				userID: 0,
//				userNickname: "전자군단대장",
//				attendanceStatus: .late,
//				studyOrder: 3,
//				isApproved: false,
//				approveAt: ""
//			)
//		)
//	]

