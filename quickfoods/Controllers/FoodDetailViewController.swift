//
//  FoodDetailViewController.swift
//  quickfoods
//
//  Created by shafrin on 04/02/2023.
//

import UIKit
import SnapKit
import Kingfisher

class FoodDetailViewController: UIViewController {

    var selectedFood : Data?
        
    //    let poster : UIView = {
    //        let poster = UIView()
    //        poster.translatesAutoresizingMaskIntoConstraints = false
    //        return poster
    //    }()
        
        
        let poster : UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        let titleLabel : UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 30)
            label.textAlignment = .center
            return label
        }()
        
        let descriptionLabel : UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 10
            label.font = .systemFont(ofSize: 20)
            return label
        }()
    
        let caloryLabel : UILabel = {
           let label = UILabel()
            label.font = .systemFont(ofSize: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        let ratingLabel : UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 10)
            return label
        }()
    
        let nutritionLabel : UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 20)
            return label
        }()
        
        let detailStack : UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 12
            stack.translatesAutoresizingMaskIntoConstraints = false
           return stack
        }()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            //print(selectedFood!)
            
            //view.addSubview(titleLabel)
            detailStack.insertArrangedSubview(titleLabel, at: 0)
            detailStack.insertArrangedSubview(ratingLabel, at: 1)
            detailStack.insertArrangedSubview(caloryLabel, at: 2)
            detailStack.insertArrangedSubview(nutritionLabel, at: 3)
            detailStack.insertArrangedSubview(descriptionLabel, at: 4)
            
            view.addSubview(poster)
            view.addSubview(detailStack)
            
            
            setupConstraints()
            loadContent()

            // Do any additional setup after loading the view.
        }
        
        func setupConstraints() {
            
//            poster.snp.makeConstraints { make in
//                make.top.equalToSuperview()
//                make.height.equalTo(150)
//                make.leading.trailing.equalToSuperview()
//            }
            
            poster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            poster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            poster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            poster.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            detailStack.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 8).isActive = true
            detailStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            detailStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            //detailStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            
//            let holder = UIStackView(arrangedSubviews:  [titleLabel,descriptionLabel])
//            holder.spacing = 10
//            holder.axis = .vertical
//            self.view.addSubview(holder)
//            
//            holder.snp.makeConstraints { make in
//                make.top.equalTo(poster.snp_bottomMargin).offset(40)
//                make.leading.equalTo(view.snp_leadingMargin).offset(20)
//                make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
//            }
        }
        
        func loadContent() {
            if let food = selectedFood {
                let imageLink =  food.imagePath
                if let imageURL = URL(string: imageLink) {
                    poster.kf.setImage(with: imageURL)
                }
                
                titleLabel.text = food.name
                descriptionLabel.text = food.description
                caloryLabel.text = "Calories: " + food.calories
                //ratingLabel.text = food?.ratings
                nutritionLabel.text = "Nutrition Level: " + food.nutritionLevel
            }
            
            
        }
        

}
