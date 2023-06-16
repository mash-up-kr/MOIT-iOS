//
//  ParticipationSuccessViewController.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import RIBs
import RxSwift

protocol ParticipationSuccessPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

public final class ParticipationSuccessViewController: UIViewController, ParticipationSuccessPresentable, ParticipationSuccessViewControllable {

    weak var listener: ParticipationSuccessPresentableListener?
	
	private let closeButton: UIButton = {
		let button = UIButton()
		return button
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private let profileImageView = MOITProfileView(
		urlString: "",
		profileType: .large,
		addButton: false
	)
	
	private let moitNameLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private let showStudyDetailButton = MOITButton(
		type: .large,
		title: StringResource.button.value,
		titleColor: ResourceKitAsset.Color.white.color,
		backgroundColor: ResourceKitAsset.Color.blue800.color
	)
}

extension ParticipationSuccessViewController {
	private enum StringResource {
		case button
		
		var value: String {
			switch self {
				case .button:
					return "스터디 둘러보기"
			}
		}
	}
}
