//
//  FineListInteractor.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

import FineUserInterface
import FineDomain
import MOITDetailDomain
import DesignSystem
import ResourceKit
import MOITFoundation

protocol FineListRouting: ViewableRouting {
}

protocol FineListPresentable: Presentable {
    var listener: FineListPresentableListener? { get set }
    
    func configure(_ viewModel: FineInfoViewModel)
}

public protocol FineListInteractorDependency {
    var fetchFineInfoUsecase: FetchFineInfoUseCase { get }
    var compareUserIDUseCase: CompareUserIDUseCase { get }
    var filterMyFineListUseCase: FilterMyFineListUseCase { get }
    var moitID: Int { get }
}

final class FineListInteractor: PresentableInteractor<FineListPresentable>, FineListInteractable, FineListPresentableListener {

    weak var router: FineListRouting?
    weak var listener: FineListListener?
    
    private let dependency: FineListInteractorDependency
    private var isMaster = false

    init(
        presenter: FineListPresentable,
        dependency: FineListInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
// MARK: - FineListPresentableListener
    
    func viewDidLoad() {
        fetchFineInfo()
    }
	
	func viewWillAppear() {
		fetchFineInfo()
	}
	
	func fineListDidTap(fineID: Int) {
		listener?.fineListViewDidTap(
			moitID: dependency.moitID,
			fineID: fineID,
			isMaster: isMaster
		)
	}
    
// MARK: - private
	
	private func fetchFineInfo() {
		dependency.fetchFineInfoUsecase.execute(moitID: dependency.moitID)
			.compactMap { [weak self] fineInfoEntity -> FineInfoViewModel? in
				// TODO: isMaster값 스트림에서받아서 수정 필요
				self?.isMaster = true
				return self?.convertToFineInfoViewModel(from: fineInfoEntity, isMaster: true)
			}
			.observe(on: MainScheduler.instance)
			.subscribe(
				onSuccess: { [weak self] fineInfoViewModel in
					debugPrint("------------FineInfoViewModel-------------")
					debugPrint(fineInfoViewModel)
					debugPrint("------------------------------------------")
					self?.presenter.configure(fineInfoViewModel)
				}
			)
			.disposeOnDeactivate(interactor: self)
	}
    
    /// FineInfoEntity -> FineInfoViewModel
    private func convertToFineInfoViewModel(
        from entity: FineInfoEntity,
        isMaster: Bool
    ) -> FineInfoViewModel {
        
        let filteredFineListEntity = dependency.filterMyFineListUseCase.execute(
            fineList: entity.notPaidFineList
        )
        
        return FineInfoViewModel(
			totalFineAmountText: entity.totalFineAmount.toDecimalString,
            myNotPaidFineListViewModel: filteredFineListEntity.myFineList.map { convertToNotPaidFineListViewModel(from: $0, isMaster: isMaster) },
            othersNotPaidFineListViewModel: filteredFineListEntity.othersFineList.map { convertToNotPaidFineListViewModel(from: $0, isMaster: isMaster) },
            paymentCompletedFineListViewModel: entity.paymentCompletedFineList.map { convertToPaymentCompletedFineListViewModel(from: $0) }
        )
    }
    
    /// FineItemEnitty -> 벌금미납부내역
    private func convertToNotPaidFineListViewModel(
        from entity: FineItemEntity,
        isMaster: Bool
    ) -> NotPaidFineListViewModel {
        
        let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
        let nickName = isMyFine ? "나" : entity.userNickname
        let buttonColorSet = convertFineApproveStatusToButtonColorSet(
            status: entity.fineApproveStatus,
            isMyFineItem: isMyFine,
            isMaster: isMaster
        )
        
        return NotPaidFineListViewModel(
            fineID: entity.id,
            fineAmount: entity.fineAmount,
            chipType: convertAttendanceStatusToMOITChipType(status: entity.attendanceStatus),
            isMyFine: isMyFine,
            userNickName: nickName,
            studyOrder: entity.studyOrder,
            imageURL: entity.imageURL,
            buttonTitle: convertFineApproveStatusToButtonTitle(
                status: entity.fineApproveStatus,
                isMyFineItem: isMyFine,
                isMaster: isMaster
            ),
            buttonBackgroundColor: buttonColorSet?.backgroundColor.color,
            buttonTitleColor: buttonColorSet?.titleColor.color
        )
    }
    
    /// FineItemEntity -> 벌금납부내역
    private func convertToPaymentCompletedFineListViewModel(
        from entity: FineItemEntity
    ) -> PaymentCompletedFineListViewModel {
        
        let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
        let nickName = isMyFine ? "나" : entity.userNickname
        
        return PaymentCompletedFineListViewModel(
            fineAmount: entity.fineAmount,
            chipType: convertAttendanceStatusToMOITChipType(status: entity.attendanceStatus),
            useNickName: nickName,
            // TODO: Date 변환 필요
            approvedDate: entity.approveAt
        )
    }
    
    private func convertFineApproveStatusToButtonTitle(
        status: FineApproveStatus,
        isMyFineItem: Bool,
        isMaster: Bool
    ) -> String? {
        
        if isMaster {
            switch status {
            case .new:
                return isMyFineItem ? "납부 인증하기" : nil
            case .inProgress, .rejected:
                return "인증 확인하기"
            default:
                return nil
            }
        } else {
            switch status {
			case .new, .rejected:
                return isMyFineItem ? "납부 인증하기" : nil
            case .inProgress:
                return isMyFineItem ? "인증 대기 중" : nil
            default:
                return nil
            }
        }
    }
    
    private func convertFineApproveStatusToButtonColorSet(
        status: FineApproveStatus,
        isMyFineItem: Bool,
        isMaster: Bool
    ) -> ButtonColorSet? {
        
        if isMaster {
            switch status {
            case .new:
                return isMyFineItem ? .active : nil
            case .inProgress, .rejected:
                return .active
            default:
                return nil
            }
        } else {
            switch status {
            case .new, .rejected:
                return isMyFineItem ? .active : nil
            case .inProgress:
                return isMyFineItem ? .waiting : nil
            default:
                return nil
            }
        }
    }

    func convertAttendanceStatusToMOITChipType(
        status: AttendanceStatus
    ) -> MOITChipType {
        switch status {
            case .LATE:
                return .late
            case .ABSENCE:
                return .absent
            default:
                return .absent
        }
    }
}

extension FineListInteractor {
    enum ButtonColorSet {
        case active
        case waiting
        
        var backgroundColor: ResourceKitColors {
            switch self {
            case .active: return ResourceKitAsset.Color.gray900
            case .waiting: return ResourceKitAsset.Color.gray200
            }
        }
        
        var titleColor: ResourceKitColors {
            switch self {
            case .active: return ResourceKitAsset.Color.white
            case .waiting: return ResourceKitAsset.Color.gray700
            }
        }
    }
}

extension FineListInteractor {
    enum StringResource {
        case successConfirmFine
        case successRejectFine
        case successEvaluateFine
        
        var value: String {
            switch self {
            case .successConfirmFine:
                return "납부 완료 확인이 완료되었어요!"
            case .successRejectFine:
                // TODO: 닉네임 받아야함
                return "김모잇님께 납부 요청 알림이 다시 갔어요!"
            case .successEvaluateFine:
                return "벌금 납부 인증이 업로드되었어요!"
            }
        }
    }
}
