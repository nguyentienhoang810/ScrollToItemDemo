//
//  ViewController.swift
//  ScrollDemo
//
//  Created by nguyentienhoang on 1/3/19.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let cellID = "cellID"
    private let scrHeight = UIScreen.main.bounds.height
    private let scrWidth = UIScreen.main.bounds.width
    private let scrollBtn = UIButton()
    private let lbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
        configCollectionViewLayout()
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: scrWidth, height: scrHeight - 100)
        addBtn()
    }
    
    private func configCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configCollectionViewLayout() {
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func addBtn() {
        view.addSubview(scrollBtn)
        scrollBtn.translatesAutoresizingMaskIntoConstraints = false
        scrollBtn.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        NSLayoutConstraint.activate([
            scrollBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollBtn.heightAnchor.constraint(equalToConstant: 30),
            scrollBtn.widthAnchor.constraint(equalToConstant: 100),
            scrollBtn.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)
        ])
        scrollBtn.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc private func didTap(_ sender: UIButton) {
        scroll(to: [0 , 30])
    }
    
    private func scroll(to indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        cell.setLbl("\(indexPath.item)")
        return cell
    }
}

class CustomCell: UICollectionViewCell {
    private let lbl = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lbl)
        lbl.frame = contentView.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLbl(_ text: String) {
        lbl.text = text
    }
}
