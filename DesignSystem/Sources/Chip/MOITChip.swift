//
//  MOITChip.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxSwift
import RxRelay

public final class MOITChip: UIView {
	
// MARK: - UI
	
	private let flexRootView = UIView()
	private let titleLabel = UILabel()
	
// MARK: - property
	
	private let type = PublishRelay<MOITChipType>()
	private let disposeBag = DisposeBag()

// MARK: - init
	
	public init(
		type: MOITChipType
	) {
		super.init(frame: .zero)
		
		bind()
		self.type.accept(type)
	}
	
	public convenience init() {
		self.init(type: .absent)
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		flexRootView.pin.all()
		flexRootView.flex.layout(mode: .adjustWidth)
	}
	
// MARK: - public

	public func setType(to type: MOITChipType) {
		self.type.accept(type)
	}
	
// MARK: - private
	
	private func bind() {
		type
		.subscribe(
			onNext: { [weak self] type in
				guard let self else { return }
				
				self.configureLayout(type: type)
				self.configureFlexRootView(type: type)
				self.configureComponent(type: type)
			}
		)
		.disposed(by: disposeBag)
	}
	
	private func configureFlexRootView(type: MOITChipType) {
		flexRootView.backgroundColor = type.backgroundColor
		flexRootView.layer.cornerRadius = type.cornerRadius
		flexRootView.clipsToBounds = true
	}
	
	private func configureComponent(type: MOITChipType) {
		titleLabel.textColor = type.textColor
		titleLabel.text = type.title
		titleLabel.font = type.font
	}
	
	private func configureLayout(type: MOITChipType) {
		addSubview(flexRootView)
		
		flexRootView.flex
			.alignItems(.center)
			.justifyContent(.center)
			.direction(.row)
			.define { flex in
				flex.addItem(titleLabel).marginHorizontal(type.marginHorizontal)
			}
			.height(type.height)
	}
}
