//
//  AuthorizePaymentViewController.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit
import PhotosUI

import DesignSystem
import ResourceKit

import RIBs
import RxSwift
import FlexLayout
import PinLayout
import Kingfisher

protocol AuthorizePaymentPresentableListener: AnyObject {
	func dismissButtonDidTap()
	func viewDidLoad()
	func authorizeButtonDidTap(with data: Data?)
	func masterAuthorizeButtonDidTap(isConfirm: Bool)
	func didSwipeBack()
}

final class AuthorizePaymentViewController: UIViewController, AuthorizePaymentPresentable, AuthorizePaymentViewControllable {

// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let navigationBar = MOITNavigationBar(
		leftItems: [.back],
		title: StringResource.title.value,
		rightItems: []
	)
	
	private var fineDetailList = MOITList(
		type: .sendMoney,
		title: "김모잇",
		detail: "15,000원",
		chipType: .late,
		studyOrder: 1,
		button: MOITButton(
			type: .mini,
			title: "사진 재등록하기",
			titleColor: ResourceKitAsset.Color.white.color,
			backgroundColor: ResourceKitAsset.Color.gray900.color
		)
	)
	
	private let fineImageView = FineImageView()
	
	private let authenticateButton = MOITButton(
		type: .large,
		image: nil,
		title: StringResource.title.value,
		titleColor: ResourceKitAsset.Color.gray700.color,
		backgroundColor: ResourceKitAsset.Color.gray200.color
	)
	
	private var fineImage: UIImage? {
		didSet {
			activateAuthorizeButton()
			fineImageView.hideGuideComponents()
		}
	}
	
	private var masterAuthorizationView = MasterAuthorizationView(userNickname: "")
	
// MARK: - property
	
    weak var listener: AuthorizePaymentPresentableListener?
	private let disposeBag = DisposeBag()
	
// MARK: - override
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureLayout()
		bind()
		
		listener?.viewDidLoad()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		if self.isMovingFromParent {
			listener?.didSwipeBack()
		}
	}
	
	
// MARK: - AuthorizePaymentPresentable
	
	func configure(_ viewModel: AuthorizePaymentViewModel) {
		debugPrint("viewModel: \(viewModel)")

		fineDetailList.configure(
			title: viewModel.userNickName,
			detail: viewModel.fineAmount,
			chipType: viewModel.chipType,
			isButtonHidden: viewModel.buttonTitle == nil,
			buttonTitle: viewModel.buttonTitle,
			studyOrder: viewModel.studyOrder
		)
		
		if let imageURL = viewModel.imageURL {
			fineImageView.kf.setImage(
				with: URL(string: imageURL)) { [weak self] result in
					switch result {
					case .success(let imageResult):
						self?.fineImage = imageResult.image.imageWithoutBaseline()
					case .failure:
						break
					}
				}
		}
		
		if viewModel.isMaster && viewModel.approveStatus == .new || !viewModel.isMaster {
			authenticateButton.flex.display(.flex)
			masterAuthorizationView.flex.display(.none)
		} else {
			authenticateButton.flex.display(.none)
			masterAuthorizationView.flex.display(.flex)
			masterAuthorizationView.configure(nickName: viewModel.userNickName)
		}
		
		self.view.setNeedsLayout()
	}
	
	func activateAuthorizeButton() {
		authenticateButton.configure(
			titleColor: ResourceKitAsset.Color.white,
			backgroundColor: ResourceKitAsset.Color.blue800
		)
	}
	
	func showErrorToast() {
		print("에러 발생....ㅜㅜ")
	}
	
// MARK: - private
	
	private func configureView() {
		view.backgroundColor = .white
		view.addSubview(flexRootContainer)
	}
	
	private func configureLayout() {
		flexRootContainer.flex.define { flex in
			flex.addItem(navigationBar)
			
			flex.addItem()
				.marginTop(20)
				.marginHorizontal(20)
				.grow(1)
				.define { flex in
					
					flex.addItem(fineDetailList)
					flex.addItem(fineImageView).marginTop(20)
				}
			
			flex.addItem(authenticateButton).marginHorizontal(20)
			flex.addItem(masterAuthorizationView).marginHorizontal(20)
		}
	}
	
	private func bind() {
		navigationBar.leftItems?.first?.rx.tap
			.bind(onNext: { [weak self] _ in
				self?.listener?.dismissButtonDidTap()
			})
			.disposed(by: self.disposeBag)
		
		fineImageView.rx.tap
			.subscribe(
				onNext: { [weak self] in
					if self?.fineImage == nil {
						self?.presentImagePicker()
					}
				}
			)
			.disposed(by: disposeBag)
		
		authenticateButton.rx.tap
			.bind(onNext: { [weak self] in
				guard let self else { return }
				if let image = self.fineImage {
					self.listener?.authorizeButtonDidTap(with: image.pngData())
				}
			})
			.disposed(by: disposeBag)
		
		masterAuthorizationView.rx.didTapCancelButton
			.bind(onNext: { [weak self] in
				self?.listener?.masterAuthorizeButtonDidTap(isConfirm: false)
			})
			.disposed(by: disposeBag)
		
		masterAuthorizationView.rx.didTapOkButton
			.bind(onNext: { [weak self] in
				self?.listener?.masterAuthorizeButtonDidTap(isConfirm: true)
			})
			.disposed(by: disposeBag)
		
		fineDetailList.rx.tap
			.bind(onNext: { [weak self] in
				self?.presentImagePicker()
			})
			.disposed(by: disposeBag)
	}
	
	private func presentImagePicker() {
		var configuration = PHPickerConfiguration()
		configuration.selectionLimit = 1
		configuration.filter = .images
		
		let picker = PHPickerViewController(configuration: configuration)
		picker.delegate = self
		self.present(picker, animated: true, completion: nil)
	}
}

extension AuthorizePaymentViewController: PHPickerViewControllerDelegate {
	func picker(
		_ picker: PHPickerViewController,
		didFinishPicking results: [PHPickerResult]
	) {
		picker.dismiss(animated: true)
				
		let itemProvider = results.first?.itemProvider

		if let itemProvider = itemProvider,
		   itemProvider.canLoadObject(ofClass: UIImage.self) {
			itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
				DispatchQueue.main.async {
					
					let resultImage = image as? UIImage
					
					self.fineImageView.image = resultImage
					self.fineImage = resultImage
				}
			}
		} else {
			self.showAlert(
				message: "에러발생~ 다시 해주세염~",
				type: .single
			)
		}
	}
}

extension AuthorizePaymentViewController {
	enum StringResource {
		case title
		case uploadGuide
		
		var value: String {
			switch self {
			case .title:
				return "벌금 납부 인증하기"
			case .uploadGuide:
				return "여기를 눌러 벌금을 납부한\n스크린샷을 업로드해주세요!"
			}
		}
	}
}
