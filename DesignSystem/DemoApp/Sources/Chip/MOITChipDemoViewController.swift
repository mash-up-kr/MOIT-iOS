//
//  MOITChipDemoViewController.swift
//  DesignSystemDemoApp
//
//  Created by 최혜린 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import FlexLayout
import PinLayout

public final class MOITChipDemoViewController: UIViewController {
	
	private let flexRootContainer = UIView()
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		configure()
	}
	
	override public func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout(mode: .adjustWidth)
	}
	
	private func configure() {
		view.addSubview(flexRootContainer)
		view.backgroundColor = . white
		
		addChips()
	}
	
	private func addChips() {
		self.flexRootContainer.flex.define { (flex) in
			flex.addItem(attendChip())
				.margin(10)
			
			flex.addItem(lateChip())
				.margin(10)
			
			flex.addItem(absentChip())
				.margin(10)
			
			flex.addItem(dueDateChip(date: 10))
				.margin(10)
			
			flex.addItem(dueDateChip(date: 1000000))
				.margin(10)
			
			flex.addItem(finishChip())
				.margin(10)
		}
	}
	
	private func attendChip() -> MOITChip {
		MOITChip(type: .attend)
	}
	
	private func lateChip() -> MOITChip {
		MOITChip(type: .late)
	}
	
	private func absentChip() -> MOITChip {
		MOITChip(type: .absent)
	}
	
	private func dueDateChip(date: Int) -> MOITChip {
		MOITChip(type: .dueDate(date: date))
	}
	
	private func finishChip() -> MOITChip {
		MOITChip(type: .finish)
	}
}
