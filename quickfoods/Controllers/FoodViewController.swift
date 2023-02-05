//
//  FoodViewController.swift
//  quickfoods
//
//  Created by shafrin on 04/02/2023.
//

import UIKit
import SnapKit
import Kingfisher

class FoodViewController: UIViewController {

        var datas : [Data] = [Data]()
        
        let tableView : UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
        
        private let searchField: UITextField = {
            let field = UITextField()
            field.leftViewMode = .always
            field.placeholder = "Search food"
            field.autocapitalizationType = .none
            field.autocorrectionType = .no
            field.backgroundColor = .secondarySystemBackground
            field.layer.cornerRadius = 8
            field.layer.masksToBounds = true
            field.font = .systemFont(ofSize: 25)
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .white
            tableView.delegate = self
            tableView.dataSource =  self
            tableView.register(MyCellView.self, forCellReuseIdentifier: "cell")
            tableView.backgroundColor = .clear
            view.addSubview(searchField)
            view.addSubview(tableView)
            setupContraint()
            downloadMoview()
        }
        
     
        func setupContraint(){
            
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 2).isActive = true
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            
        }

        func downloadMoview(){
            let url = URL(string:
                            "http://stnamt.rbdemo.live/api/all_foods")!
            
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
              "Content-Type": "application/json",
              "X-Tenant": "3C3JyDINMjDK9Me",
              "Referer" : "http://zara.rbdemo.live/"
            ]
                          
              let dataTask = URLSession.shared.dataTask(with: request) { data, res, error in
                  if let foodData = data{
                      let json = try? JSONDecoder().decode(FoodModel.self, from: foodData)

                      if let foods = json?.data {
                          self.datas = foods
                      }

                      DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
                  }
              }

              dataTask.resume()
            }
        }
        
        extension FoodViewController : UITableViewDataSource , UITableViewDelegate {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return datas.count
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell : MyCellView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as! MyCellView
                cell.titleLabel.text = datas[indexPath.row].name
                cell.descriptionLabel.text = datas[indexPath.row].price
                cell.caloryLabel.text = datas[indexPath.row].calories
                
                let imageURL = datas[indexPath.row].imagePath
                if let url = URL(string: imageURL) {
                    cell.MyImage.kf.setImage(with:url)
                }
                
                return cell
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
                return 120
            }
            
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let vc = FoodDetailViewController()
                vc.selectedFood = datas[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }

    class MyCellView : UITableViewCell{
        
        let MyImage : UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        let baseView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let titleLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = .white
            label.font = .systemFont(ofSize: 20, weight: .bold)
            return label
        }()
        
        let descriptionLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14, weight: .light)
            label.textColor = .black
            return label
        }()
        
        let caloryLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14, weight: .light)
            label.textColor = .black
            return label
        }()
        
        let lableHolder : UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 10
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let contentHolder : UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 10
            stack.alignment = .leading
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            layComponent()
            setupConstraint()
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented ")
        }
        func layComponent(){
            lableHolder.addArrangedSubview(titleLabel)
            lableHolder.addArrangedSubview(descriptionLabel)
            lableHolder.addArrangedSubview(caloryLabel)
            contentHolder.addArrangedSubview(MyImage)
            contentHolder.addArrangedSubview(lableHolder)
            baseView.addSubview(contentHolder)
            contentView.addSubview(baseView)
        }
        
        private func setupConstraint(){
            baseView.snp.makeConstraints { make in
                make.leading.top.equalToSuperview().offset(20)
                make.trailing.bottom.equalToSuperview().offset(-20)
            }
            
            MyImage.snp.makeConstraints { make in
                make.height.equalTo(80)
                make.width.equalTo(80)
            }
        }

}
