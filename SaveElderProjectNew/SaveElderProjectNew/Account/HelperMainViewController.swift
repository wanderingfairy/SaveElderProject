//
//  HelperMainViewController.swift
//  SaveElderProjectNew
//
//  Created by 정의석 on 2020/01/15.
//  Copyright © 2020 정의석. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class HelperMainViewController: UIViewController, CLLocationManagerDelegate {
    
        //MARK: 변수 선언
    private var mapView = MKMapView()
    var locationManager: CLLocationManager!
    var updateLocationButton = UIButton()
    var updateButtonBackgroundView = UIView()
    
    
    var accountButton = UIButton(type: .system)
    var menuButton = UIButton()
    
    let elderCode = UserDefaults.standard.string(forKey: "elderCode")
    var elderPhoneNumber = ""
    
    var lastTime = ""
    var elderPinName = ""
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLocationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        updateLocationButton.layer.cornerRadius = 35
        updateLocationButton.setPreferredSymbolConfiguration(.init(pointSize: 70), forImageIn: .normal)
        updateLocationButton.tintColor = UIColor(named: "mypink")
        updateLocationButton.addTarget(self, action: #selector(updateLocation), for: .touchUpInside)
        updateLocationButton.backgroundColor = .white
        updateLocationButton.layer.cornerRadius = 40.5
        updateLocationButton.shadow()
        
        accountButton.setImage(UIImage(named: "account"), for: .normal)
        accountButton.backgroundColor = .white
        accountButton.addTarget(self, action: #selector(didTapAccountButton), for: .touchUpInside)
        accountButton.layer.cornerRadius = 25
        accountButton.shadow()
        
        //        mapView.showsUserLocation = true
        
        //        UNUserNotification
        afterLoginDataSave()
        exportPhoneNumber()
    }
    
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    
    //MARK: ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        elderCheck()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(elderCheck), userInfo: nil, repeats: true)
    }
    
    
    //MARK: Objc - ElderCheck
    @objc private func elderCheck() {
        
        guard let elderCode = self.elderCode else { return }
        print(elderCode)
        
        let rootRef = Database.database().reference()
        rootRef.child("users").child(elderCode).child("lastTime").observeSingleEvent(of: .value) { snapshop in
            
            let elderLastTime = snapshop.value as? [String : Any] ?? ["fail":"fail"]
            print(elderLastTime)
            
            guard let lastTime = elderLastTime["lastUpdatingTime"] as? String else { return }
            self.lastTime = lastTime
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMddhh"
            let stringDate = dateFormatter.string(from: date)
            
            print(stringDate, lastTime)
            if Int(stringDate)! - Int(lastTime)! >= 6 {
                self.alertControl()
            }
        }
    }
    
    
    //MARK: ExportPhoneNumber Function
    private func exportPhoneNumber() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let rootRef = Database.database().reference()
        
        rootRef.child("users").child(uid).child("ElderInfo").observeSingleEvent(of: .value) { snapshop in
            
            guard let datas = snapshop.value as? [String : Any] else { return }
            print(datas)
            
            guard let elderNames = datas["ElderName"] as? String else { return }
            print(elderNames)
            
            self.elderPinName = elderNames
            
            guard let elderPhoneNumbers = datas["ElderPhoneNumber"] as? String else { return }
            self.elderPhoneNumber = elderPhoneNumbers
            print(elderPhoneNumbers)
            
            self.updateLocation()
        }
    }
    
    
    //MARK: DidTapAccountButton
    @objc private func didTapAccountButton() {
        
        let vc = HelperAccountViewController()
        
        guard let inviteCode = UserDefaults.standard.string(forKey: "elderCode") else { return }
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let email = Auth.auth().currentUser?.email else {return}
        let rootRef = Database.database().reference()
        
        rootRef.child("users").child(uid).child("ElderInfo").observeSingleEvent(of: .value) { snapshop in
            
            guard let datas = snapshop.value as? [String : Any] else { return }
            print(datas)
            
            guard let elderNames = datas["ElderName"] as? String else { return }
            print(elderNames)
            
            guard let elderPhoneNumbers = datas["ElderPhoneNumber"] as? String else { return }
            print(elderPhoneNumbers)
            
            vc.inviteCode = inviteCode
            vc.elderName = elderNames
            vc.elderPhoneNumber = elderPhoneNumbers
            vc.userEmail = email
            
            self.present(vc, animated: true)
        }
    }
    
    
    //MARK: Save When after Login
    private func afterLoginDataSave() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var elderCode = ""
        var count = 0
        
        for i in uid {
            count += 1
            elderCode.append(i)
            if count == 6 {
                break
            }
        }
        count = 0
        
        let values = elderCode
        Database.database().reference().child("users").child(elderCode).child("ElderCode").setValue(values) { (err, ref) in
            if err == nil {
                UserDefaults.standard.setValue(values, forKey: "elderCode")
                print("ElderCode save complete")
            } else {
                print("ElderCode save fail.")
            }
        }
    }
    
    
    //MARK: ViewSafeAreaInsetsDidChange
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        view.addSubview(mapView)
        view.addSubview(updateLocationButton)
        view.addSubview(accountButton)
        view.addSubview(menuButton)
        setupUI()
    }
    
    
    //MARK: Setup UI
    private func setupUI() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        updateLocationButton.translatesAutoresizingMaskIntoConstraints = false
        updateButtonBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        accountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            updateLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            updateLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            accountButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            accountButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            accountButton.widthAnchor.constraint(equalToConstant: 50),
            accountButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        //        updateLocationButton.layer.cornerRadius = updateLocationButton.frame.width / 2
    }
    
    
    //MARK: UpdateLocation
    var firstDatas: [String : Any] = ["":""]
    @objc private func updateLocation() {
        
        let elderCurrentAnnotation = MKPointAnnotation()
        elderCurrentAnnotation.title = lastTime
        
        var count = 0
        var lastTimeLabel = ""
        for i in lastTime {
            count += 1
            
            if count == 1 && i == "0" {
                
            } else if count == 2 {
                lastTimeLabel.append(i)
                lastTimeLabel.append("월 ")
            } else if count == 3 && i == "0" {
                
            } else if count == 4 {
                lastTimeLabel.append(i)
                lastTimeLabel.append("일 ")
            } else if count == 5 && i == "0" {
                
            } else if count == 6 {
                lastTimeLabel.append(i)
                lastTimeLabel.append("시")
            } else {
                lastTimeLabel.append(i)
            }
        }
        
        elderCurrentAnnotation.title = lastTimeLabel
        elderCurrentAnnotation.subtitle = "\(elderPinName)님"
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var elderCode = ""
        var count1 = 0
        for i in uid {
            count1 += 1
            elderCode.append(i)
            if count1 == 6 {
                break
            }
        }
        
        print(elderCode)
        print(lastTimeLabel)
        
        let rootRef = Database.database().reference()
        rootRef.child("users").child(elderCode).child("elderLocation").observeSingleEvent(of: .value) { snapshop in
            
            self.firstDatas = snapshop.value as? [String : Any] ?? ["fail":"fail"]
            print(self.firstDatas)
            
            guard let longitude = self.firstDatas["longitude"] as? String else { return }
            
            guard let latitude = self.firstDatas["latitude"] as? String else {return}
            print(latitude)
            
            elderCurrentAnnotation.coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: elderCurrentAnnotation.coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(elderCurrentAnnotation)
            
            
            
        }
    }
    
    
    //MARK: AlertControl Setup
    private func alertControl() {
        let alertController = UIAlertController(title: "경고", message: "피보호자가 6시간 동안\n알림을 누르지 않았습니다!", preferredStyle: .alert)
        
        
        let callAction = UIAlertAction(title: "전화 걸기", style: .destructive) { alertAction in
            
            
            func helperCallAction() {
                print("\n---------- [ helperCall ] ----------\n")
                let url = URL(string: "tel:\(self.elderPhoneNumber)")!
                print(url)
                guard UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            }
            helperCallAction()
        }
        alertController.addAction(callAction)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}


//MARK: Extention: MKMapViewDelegate
//MARK: Custom Annotation Image Setup
extension HelperMainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        let pinImage = UIImage(named: "PinImage")
        annotationView!.image = pinImage
        
        return annotationView
    }
}
