//
//  HomeVC.swift
//  CoreML2
//
//  
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var homeTblView: UITableView!
    var titleArr = ["Text Recognition","Text to Speech","Object Detection","Motion Detection"]
    var iconArr: [UIImage] = [#imageLiteral(resourceName: "find"),#imageLiteral(resourceName: "icons8-speech-to-text-100"),#imageLiteral(resourceName: "focus"),#imageLiteral(resourceName: "Group 309")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()

    }
    func setupTableview() {
        homeTblView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        homeTblView.delegate = self
        homeTblView.dataSource = self
        homeTblView.reloadData()
        homeTblView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTblView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier , for: indexPath) as! HomeTableViewCell
        let bgColorView = UIView()
        bgColorView.backgroundColor = .systemBackground
        cell.selectedBackgroundView = bgColorView
        cell.titlelbl.text = titleArr[indexPath.row]
        cell.iconimg.image = iconArr[indexPath.row]
        cell.nextImg.image = #imageLiteral(resourceName: "next (2)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(identifier: "TextRecognitionVC") as! TextRecognitionVC
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(identifier: "TextAudioVC") as! TextAudioVC
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(identifier: "ObjectDetectionVC") as! ObjectDetectionVC
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else  if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewController(identifier: "MotionDetectionVC") as! MotionDetectionVC
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
   
}
