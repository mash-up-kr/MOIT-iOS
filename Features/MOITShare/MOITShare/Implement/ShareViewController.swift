//
//  ShareViewController.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import DesignSystem
import ResourceKit
import PinLayout
import FlexLayout

protocol SharePresentableListener: AnyObject {
    func didTapLinkCopyButton()
    func didTapDimmedView()
    func didTapShareButton()
}

public final class ShareViewController: BottomSheetViewController,
                                 SharePresentable,
                                ShareViewControllable {

    private var contentview: MOITShareView?
    private let disposeBag = DisposeBag()
    weak var listener: SharePresentableListener?
    
    public override init(contentView: UIView) {
        if let contentView = contentView as? MOITShareView {
            self.contentview = contentView
        }
        
        super.init(contentView: contentView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        contentview?.rx.didTapLinkCopyButton
            .bind(onNext: { [weak self] in
                self?.listener?.didTapLinkCopyButton()
            })
            .disposed(by: self.disposeBag)
        
        self.rx.didTapDimmedView
            .bind(onNext: { [weak self] in
                self?.listener?.didTapDimmedView()
            })
            .disposed(by: self.disposeBag)
        
        contentview?.rx.didTapKakaoTalkShareButton
            .bind(onNext: { [weak self] in
                self?.listener?.didTapShareButton()
            })
            .disposed(by: self.disposeBag)
    }
}
