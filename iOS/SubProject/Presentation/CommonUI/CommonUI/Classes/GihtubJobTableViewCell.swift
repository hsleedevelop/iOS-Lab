//
//  GihtubJobTableViewCell.swift
//  CustomUI
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import Domain
import NetworkProvider
import RxSwift

public final class GihtubJobTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        //self.imageView?.image = nil
        disposeBag = DisposeBag()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUIControls()
    }
    
    private func setupUIControls() {
        logoImageView.contentMode = .scaleAspectFill
    }
    
    public func configure(_ job: GithubJob) {
        self.companyLabel?.text = job.company
        self.jobLabel?.text = job.title
        
        if let url = job.companyLogo {
            ImageProvider.shared.get(url)
                .observeOn(MainScheduler.instance)
                .bind(to: logoImageView.rx.image)
                .disposed(by: disposeBag)
        } else {
            logoImageView.image = nil
        }
    }
}
