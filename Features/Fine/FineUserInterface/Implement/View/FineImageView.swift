//
//  FineImageView.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import RxSwift
import RxCocoa
import RxGesture
import Kingfisher

final class FineImageView: UIImageView {
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let uploadIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = ResourceKitAsset.Icon.upload.image
		return imageView
	}()
	
	private let uploadGuideLabel: UILabel = {
		let label = UILabel()
		label.setTextWithParagraphStyle(
			text: StringResource.uploadGuide.value,
			alignment: .center,
			font: ResourceKitFontFamily.p2,
			textColor: ResourceKitAsset.Color.gray500.color
		)
		label.numberOfLines = 0
		return label
	}()
	
// MARK: - init
	
	init(
		imageUrl: String? = nil
	) {
		super.init(frame: .zero)
		
		configureView(imageUrl: imageUrl)
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override func layoutSubviews() {
		super.layoutSubviews()
	
		flexRootContainer.pin.all()
		flexRootContainer.flex.layout()
	}
	
// MARK: - private
	
	private func configureView(
		imageUrl: String?
	) {
		self.addSubview(flexRootContainer)
		
		self.backgroundColor = ResourceKitAsset.Color.gray50.color
		self.layer.cornerRadius = 20
		self.clipsToBounds = true
		self.layer.borderColor = ResourceKitAsset.Color.gray200.color.cgColor
		self.layer.borderWidth = 1
		
		if let imageUrl {
			self.kf.setImage(
				with: URL(string: imageUrl),
				placeholder: nil) { [weak self] _ in
					self?.hideGuideComponents()
				}
		}
	}
	
	private func configureLayout() {
		flexRootContainer.flex
			.aspectRatio(335/440)
			.justifyContent(.center)
			.define { flex in
				
				flex.addItem()
					.alignItems(.center)
					.define { flex in
						flex.addItem(uploadIconImageView).aspectRatio(1).width(48)
						flex.addItem(uploadGuideLabel).marginTop(10)
					}
			}
	}
	
	private func hideGuideComponents() {
		uploadIconImageView.flex.isIncludedInLayout(false).markDirty()
		uploadGuideLabel.flex.isIncludedInLayout(false).markDirty()
	}
	
// MARK: - internal
	
	func setImage(with image: UIImage) {
		self.image = image
		hideGuideComponents()
	}
	
}

extension FineImageView {
	enum StringResource {
		case uploadGuide
		
		var value: String {
			switch self {
			case .uploadGuide:
				return "여기를 눌러 벌금을 납부한\n스크린샷을 업로드해주세요!"
			}
		}
	}
}

extension Reactive where Base: FineImageView {
	var tap: Observable<Void> {
		tapGesture()
			.when(.recognized)
			.throttle(
				.milliseconds(400),
				latest: false,
				scheduler: MainScheduler.instance
			)
			.map { _ in return }
	}
}
