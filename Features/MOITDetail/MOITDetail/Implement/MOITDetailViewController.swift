//
//  MOITDetailViewController.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import ResourceKit
import DesignSystem
import FlexLayout
import PinLayout
import SkeletonView

protocol MOITDetailPresentableListener: AnyObject {
    func didTapInfoButton(type: MOITDetailInfoViewButtonType)
    func viewDidLoad()
    func viewDidLayoutSubViews()
    func didTapParticipantsButton()
    func didTapShareButton()
    func didTapPager(at index: Int)
}

struct MOITDetailViewModel {
    let moitImage: String
    let moitName: String
    let moitDescription: String?
    let moitInfos: MOITDetailInfosViewModel
}

final class MOITDetailViewController: UIViewController,
                                      MOITDetailPresentable,
                                      MOITDetailViewControllable {
    func update(infoViewModel: MOITDetailInfosViewModel) {
        self.infoView.update(viewModel: infoViewModel)
        self.infoView.flex.markDirty()
        self.view.setNeedsLayout()
    }
    
    
    // MARK: - UIComponents
    
    private let flexRootView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let moitImageView = UIImageView()
    private let navigationTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        let image = ResourceKitAsset.Icon.arrowLeft.image.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let moitNameNavigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.h6
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let participantsButton: UIButton = {
        let button = UIButton()
        let image = ResourceKitAsset.Icon.user.image.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        let image = ResourceKitAsset.Icon.share.image.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.contentInsetAdjustmentBehavior = .never
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
//        view.isSkeletonable = true
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.isSkeletonable = true
        return view
    }()
    
    private let sheetContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
//        view.isSkeletonable = true
        return view
    }()
    
    private let moitNameLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.h3
        label.textColor = ResourceKitAsset.Color.gray900.color
//        label.isSkeletonable = true
        return label
    }()
    
    private let moitDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray500.color
//        label.isSkeletonable = true
        return label
    }()
    
    private let infoView = MOITDetailInfosView()
    private let tapPageView = MOITTabPager(pages: ["출결", "벌금"])
    private let childViewControllerContainer = UIView()
    
    // MARK: - Properties
    
    weak var listener: MOITDetailPresentableListener?
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycles
    
    override func loadView() {
        self.view = self.flexRootView
//        self.flexRootView.isSkeletonable = true
//        self.flexRootView.isUserInteractionDisabledWhenSkeletonIsActive = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.configureLayouts()
        self.bind()
        self.listener?.viewDidLoad()
        
//        self.flexRootView.showAnimatedGradientSkeleton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
        
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
        
        self.navigationBar.flex.layout()
        self.moitNameNavigationTitleLabel.pin.center(to: self.navigationBar.anchor.center)
        
        self.scrollView.pin.all()
        self.scrollView.contentSize = contentView.frame.size
        self.scrollView.flex.layout()
        self.listener?.viewDidLayoutSubViews()
    }
}

// MARK: - Private functions
extension MOITDetailViewController {
    
    private func configureLayouts() {
        
        self.flexRootView.flex
            .direction(.column)
            .justifyContent(.start)
            .alignItems(.stretch)
            .define { flex in
                flex.addItem(self.scrollView)
                    .position(.absolute)
                    .backgroundColor(.cyan)
                    .grow(1)
                
                flex.addItem(self.navigationTopView)
                    .backgroundColor(.blue)
                    .height(44) // TODO: safe area높이로 바꿔야함
                    
                flex.addItem(self.navigationBar)
                    .height(56)
            }
        
        self.navigationBar.flex
            .direction(.row)
            .alignItems(.center)
            .justifyContent(.spaceEvenly)
            .define { flex in
                flex.addItem(self.backButton)
                    .size(24)
                    .marginLeft(16)
                
                flex.addItem(self.moitNameNavigationTitleLabel)
                    .position(.absolute)
                    
                flex.addItem()
                    .grow(1)
                
                flex.addItem(self.participantsButton)
                    .size(24)
                    .marginRight(20)
                
                flex.addItem(self.shareButton)
                    .size(24)
                    .marginRight(16)
            }
        
        self.scrollView.flex
            .justifyContent(.start)
            .alignItems(.stretch)
            .define { flex in
                flex.addItem(contentView)
                    .grow(1)
            }
        
    self.contentView.flex
        .define { flex in
            flex.addItem(self.moitImageView)
                .backgroundColor(.brown)
                .height(285)
            
            flex.addItem(self.sheetContentView)
                .marginTop(-45)
                .height(2000)
        }
        .backgroundColor(.yellow)
        
        self.sheetContentView.flex
            .alignItems(.stretch)
            .define { flex in
                flex.addItem(self.moitNameLabel)
                    .marginTop(30)
                    .height(36)
                    .marginHorizontal(20)
                
                flex.addItem(self.moitDescriptionLabel)
                    .marginHorizontal(20)
                    .marginTop(10)
                    .height(22)
                
                flex.addItem(self.infoView)
                    .marginTop(20)
                    .marginHorizontal(20)
                    .minHeight(93)
                
                flex.addItem(self.tapPageView)
                    .marginTop(20)
                
                flex.addItem(self.childViewControllerContainer)
                    .marginTop(0)
                    .backgroundColor(.orange)
                    .marginBottom(0)
                    .grow(1)
            }
    }
    
    private func bind() {
        
        self.tapPageView.rx.tapIndex
            .bind(onNext: { [weak self] index in
                self?.listener?.didTapPager(at: index)
            })
            .disposed(by: self.disposeBag)
        
        self.participantsButton.rx.tap
            .throttle(
                .milliseconds(400),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .bind(onNext: { [weak self] _ in
                self?.listener?.didTapParticipantsButton()
            })
            .disposed(by: self.disposeBag)
        
        self.shareButton.rx.tap
            .throttle(
                .milliseconds(400),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .bind(onNext: { [weak self] _ in
                self?.listener?.didTapShareButton()
            })
            .disposed(by: self.disposeBag)
        
//        let didTapButton = self.infoView.rx.didTapButton
//            .share(replay: 1)
//            .debug("😲")
        
        self.infoView.rx.didTapButton
            .debug("😲")
            .bind(onNext: { [weak self] in
                self?.listener?.didTapInfoButton(type: $0)
            })
            .disposed(by: self.disposeBag)
        
        self.moitImageView
            .rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                print("image tap")
            })
            .disposed(by: self.disposeBag)
        
        self.tapPageView.rx.tapIndex
            .subscribe(onNext: { index in
                print("\(index)번쨰")
            })
            .disposed(by: self.disposeBag)
        
        self.scrollView.rx.contentOffset
            .map(\.y)
            .map { [weak self] yPoint -> Bool in
                guard let self = self else { return false }
                let navigationHeight: CGFloat = 56
                let navigationFrameY = self.navigationBar.frame.minY
                let betweenFrameY: CGFloat = 240
                let value = betweenFrameY - navigationHeight - navigationFrameY
                return yPoint >= value
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak self] isSticky in
                print(isSticky, "isSticky")
                guard let self = self else { return }
                if isSticky {
                    self.sheetContentView.layer.cornerRadius = .zero
                    self.sheetContentView.clipsToBounds = false
                } else {
                    self.sheetContentView.layer.cornerRadius = 20
                    self.sheetContentView.clipsToBounds = true
                }
            })
            .disposed(by: self.disposeBag)
        
        self.scrollView.rx.contentOffset
            .map(\.y)
            .distinctUntilChanged()
            .compactMap { [weak self] yPoint -> CGFloat? in
                guard let self = self else { return nil }
                let navigationHeight: CGFloat = 56
                
                let navigationFrameY = self.navigationBar.frame.minY
                let betweenFrameY: CGFloat = 240
                let value = betweenFrameY - navigationHeight - navigationFrameY
                let alpha = yPoint / value
                return min(alpha, 1.0)
            }
            .bind(onNext: { [weak self] alpha in
                if alpha <= 0 {
                    self?.navigationBar.backgroundColor = .clear
                    self?.navigationTopView.backgroundColor = .clear
                    self?.moitNameNavigationTitleLabel.textColor = .white
                    self?.backButton.tintColor = .white
                    self?.participantsButton.tintColor = .white
                    self?.shareButton.tintColor = .white
                } else if alpha <= 0.15 {
                    self?.navigationBar.backgroundColor = .white.withAlphaComponent(alpha)
                    self?.navigationTopView.backgroundColor = .white.withAlphaComponent(alpha)
                    self?.moitNameNavigationTitleLabel.textColor = .white
                    self?.backButton.tintColor = .white
                    self?.participantsButton.tintColor = .white
                    self?.shareButton.tintColor = .white
                } else {
                    self?.navigationBar.backgroundColor = .white.withAlphaComponent(alpha)
                    self?.navigationTopView.backgroundColor = .white.withAlphaComponent(alpha)
                    self?.moitNameNavigationTitleLabel.textColor = .black
                    self?.backButton.tintColor = .black
                    self?.participantsButton.tintColor = .black
                    self?.shareButton.tintColor = .black
                }
            })
            .disposed(by: self.disposeBag)
    }
}

extension MOITDetailViewController {
    func addChild(viewController: ViewControllable) {
        self.addChild(viewController.uiviewController)
        self.childViewControllerContainer.addSubview(viewController.uiviewController.view)
        viewController.uiviewController.willMove(toParent: self)
    }
}

// MARK: - MOITDetailPresentable

extension MOITDetailViewController {
    func configure(_ viewModel: MOITDetailViewModel) {
        
//        self.flexRootView.hideSkeleton()
        print("👀", viewModel)
//        self.moitImageView.image = viewModel.moitImage
        self.moitNameLabel.text = viewModel.moitName
        self.moitNameNavigationTitleLabel.text = viewModel.moitName
        self.navigationBar.flex.markDirty()
        
        if viewModel.moitDescription == nil {
            self.moitDescriptionLabel.flex.display(.none)
            self.moitDescriptionLabel.isHidden = true
        } else {
            self.moitDescriptionLabel.text = viewModel.moitDescription
        }
        
        self.infoView.configure(viewModel: viewModel.moitInfos)
        
        self.moitNameLabel.flex.markDirty()
        self.moitDescriptionLabel.flex.markDirty()
        self.infoView.flex.markDirty()

        self.view.setNeedsLayout()
    }
}
