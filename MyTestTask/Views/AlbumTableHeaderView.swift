//
//  AlbumTableHeaderView.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 29/09/2022.
//

import UIKit

class AlbumTableHeaderView: UIView {
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameAlbumLable: UILabel = {
        let lable = UILabel()
        lable.text = "NameAlbum"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let nameArtistLable: UILabel = {
        let lable = UILabel()
        lable.text = "NameArtist"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let dateReleaseLable: UILabel = {
        let lable = UILabel()
        lable.text = "DateRelease"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private var lableStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        lableStackView = UIStackView(arrangedSubviews: [nameAlbumLable,
                                                        nameArtistLable,
                                                       dateReleaseLable],
                                     axis: .vertical,
                                     spacing: 5,
                                     distribution: .fillProportionally)
        addSubview(albumLogo)
        albumLogo.addSubview(lableStackView)
    }

    private func setConstrains() {
        NSLayoutConstraint.activate([
            albumLogo.topAnchor.constraint(equalTo: topAnchor),
            albumLogo.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumLogo.bottomAnchor.constraint(equalTo: bottomAnchor),
            albumLogo.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lableStackView.leadingAnchor.constraint(equalTo: albumLogo.leadingAnchor, constant: 10),
            lableStackView.bottomAnchor.constraint(equalTo: albumLogo.bottomAnchor, constant: -20),
            lableStackView.widthAnchor.constraint(equalTo: albumLogo.widthAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
