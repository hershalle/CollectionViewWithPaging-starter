//
//  ViewController.swift
//  CollectionViewWithPaging
//
//  Created by Shai Balassiano on 28/07/2017.
//  Copyright © 2017 Shai Balassiano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    private var dataSource: [[UIColor]] = [[.bittersweet(), .blizzardBlue(), .blue(), .blueBell(), .blueGreen(), .blueViolet(), .blush(), .brickRed()],
                                           [.almond(), .antiqueBrass(), .apricot(), .aquamarine(), .asparagus(), .atomicTangerine(), .bananaMania(), .beaver()],
                                           [.brilliantRose(), .brown(), .burntOrange(), .burntSienna(), .cadetBlue(), .canary(), .caribbeanGreen(), .carnationPink()],
                                           [.cerise(), .cerulean(), .chestnut(), .copperCrayolaAlternateColor(), .copper(), .cornflowerBlue(), .cottonCandy(), .dandelion()],
                                           [.denim(), .desertSand(), .eggplant(), .electricLime(), .fern(), .forestGreen(), .fuchsia(), .fuzzyWuzzy()],
                                           [.gold(), .goldenrod(), .grannySmithApple(), .gray(), .green(), .greenBlue(), .greenYellow(), .hotMagenta()],
                                           [.inchworm(), .indigo(), .jazzberryJam(), .jungleGreen(), .laserLemon(), .lavender(), .lemonYellow(), .lightBlue()]]
    
    private var indexOfCellBeforeDragging = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewLayout.minimumLineSpacing = 0
        configureCollectionViewLayoutItemSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
    }
    
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)
        
        let buttonWidth: CGFloat = 50
        
        let inset = (collectionViewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionViewLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewLayout.collectionView!.frame.size.height)
        collectionViewLayout.collectionView!.reloadData()
    }
    
    // ===================================
    // MARK: - UICollectionViewDataSource:
    // ===================================
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsPaletteCollectionViewCell", for: indexPath) as! ColorsPaletteCollectionViewCell
        
        cell.configure(colors: dataSource[indexPath.row]) { (selectedColor: UIColor) in
            self.view.backgroundColor = selectedColor
        }
        
        // You can color the cells so you could see how they behave:
        //        let isEvenCell = CGFloat(indexPath.row).truncatingRemainder(dividingBy: 2) == 0
        //        cell.backgroundColor = isEvenCell ? UIColor(white: 0.9, alpha: 1) : .white
        
        return cell
    }
}
