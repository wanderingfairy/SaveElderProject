import UIKit
import MapKit
import Firebase
import UserNotifications
class ElderMainViewController: UIViewController {
    
        //MARK: 변수 선언
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var ref: DatabaseReference!
    var interval: TimeInterval = 60 //노티 보낼 간격
    let bgView = UIView()
    let bgBottomView = UIView()
    let elderNameLabel = UILabel()
    let elderLabel1 = UILabel()
    let elderLabel2 = UILabel()
    let helperView = UIView()
    let helperTitleLabel = UILabel()
    let helperNameLabel = UILabel()
    let helperPhoneNumberLabel = UILabel()
    var helperCallBtn = UIButton()
    var helperMessageBtn = UIButton()
    var emergencyCallBtn = UIButton()
    var myName = ""
    var helperName = ""
    var helperNumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        checkAuthorizationStatus()
        locationManager.delegate = self
        notificationShoot()
        setInfoAndSetupUI()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(checkAuthorizationStatus), userInfo: nil, repeats: true)
    }
    
    func setInfoAndSetupUI() {
        guard let elderCode = UserDefaults.standard.string(forKey: "elderCode") else {return}
        Database.database().reference().child("users").child(elderCode).observeSingleEvent(of: .value) { snapshop in
            let datas = snapshop.value as? [String:Any] ?? ["fail":"fail"]
            guard let myName = datas["ElderName"] as? String else { return }
            guard let helperName = datas["HelperName"] as? String else {return}
            guard let helperPhonNumber = datas["HelperPhoneNumber"] as? String else { return }
            self.myName = myName
            self.helperName = helperName
            self.helperNumber = helperPhonNumber
            self.setupUI()
        }
    }
    
    private func notificationShoot() {
        print("노티가 예약되었습니다.")
        let content = UNMutableNotificationContent()
        content.title = "Save Elder"
        content.body = "알림을 눌러 보호자를 안심시켜주세요."
        content.badge = 1
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Success")
            }
        }
    }
    
    private func setupUI() {
        bgView.shadow()
        bgView.backgroundColor = .white
        helperView.shadow()
        helperView.backgroundColor = .white
        helperView.layer.cornerRadius = 4
//        elderLabel.numberOfLines = 0
        elderNameLabel.text = myName
        elderNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        elderNameLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        elderLabel1.text = "님"
        elderLabel1.font = .systemFont(ofSize: 28)
        elderLabel1.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        elderLabel2.text = "안녕하세요?"
        elderLabel2.font = .systemFont(ofSize: 28)
        elderLabel2.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        helperTitleLabel.text = "보호자 정보"
        helperTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        helperTitleLabel.textColor = .lightGray
        helperNameLabel.text = helperName
        helperNameLabel.font = .systemFont(ofSize: 28)
        helperNameLabel.textColor = .darkGray
        helperPhoneNumberLabel.text = helperNumber
        helperPhoneNumberLabel.font = .systemFont(ofSize: 28)
        helperPhoneNumberLabel.textColor = .darkGray
        helperCallBtn = self.btnStyle(title: "전화 하기")
        helperCallBtn.shadow()
        helperCallBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        helperCallBtn.addTarget(self, action: #selector(helperCallAction(_:)), for: .touchUpInside)
        helperMessageBtn = self.btnStyle(title: "문자 보내기")
        helperMessageBtn.shadow()
        helperMessageBtn.backgroundColor = #colorLiteral(red: 0.1877941191, green: 0.4580045938, blue: 0.9603970647, alpha: 1)
        helperMessageBtn.addTarget(self, action: #selector(helperMessageAction(_:)), for: .touchUpInside)
        emergencyCallBtn = self.btnStyle(title: "긴급전화 하기")
        emergencyCallBtn.shadow()
        emergencyCallBtn.backgroundColor = #colorLiteral(red: 0.9768529534, green: 0.3592768908, blue: 0.3947588801, alpha: 1)
        emergencyCallBtn.addTarget(self, action: #selector(emergencyCallAction(_:)), for: .touchUpInside)
        bgBottomView.alpha = 0
        bgBottomView.backgroundColor = .black
        [bgView, helperView, elderNameLabel, elderLabel1, elderLabel2, helperTitleLabel, helperNameLabel, helperPhoneNumberLabel, helperCallBtn, helperMessageBtn, emergencyCallBtn, bgBottomView].forEach {
            view.addSubview($0)
        }
        setupConstraint()
    }
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        bgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bgView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1),
            bgView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.9)
        ])
        bgBottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgBottomView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 0),
            bgBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            bgBottomView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1)
        ])
        elderNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderNameLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            elderNameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 26)
        ])
        elderLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderLabel1.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            elderLabel1.leadingAnchor.constraint(equalTo: elderNameLabel.trailingAnchor, constant: 3)
        ])
        elderLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elderLabel2.topAnchor.constraint(equalTo: elderNameLabel.bottomAnchor),
            elderLabel2.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 26)
        ])
        helperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 140),
            helperView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            helperView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            helperView.heightAnchor.constraint(equalTo: bgView.heightAnchor, multiplier: 0.4)
        ])
        helperTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperTitleLabel.topAnchor.constraint(equalTo: helperView.topAnchor, constant: 20),
            helperTitleLabel.centerXAnchor.constraint(equalTo: helperView.centerXAnchor)
        ])
        helperNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperNameLabel.leadingAnchor.constraint(equalTo: helperView.leadingAnchor, constant: 20),
            helperNameLabel.centerYAnchor.constraint(equalTo: helperView.centerYAnchor, constant: -20)
        ])
        helperPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperPhoneNumberLabel.leadingAnchor.constraint(equalTo: helperView.leadingAnchor, constant: 20),
            helperPhoneNumberLabel.centerYAnchor.constraint(equalTo: helperView.centerYAnchor, constant: 40)
        ])
        helperCallBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperCallBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            helperCallBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            helperCallBtn.heightAnchor.constraint(equalTo: helperView.heightAnchor, multiplier: 0.28),
            helperCallBtn.topAnchor.constraint(equalTo: helperView.bottomAnchor, constant: 20)
        ])
        helperMessageBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperMessageBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            helperMessageBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            helperMessageBtn.heightAnchor.constraint(equalTo: helperView.heightAnchor, multiplier: 0.28),
            helperMessageBtn.topAnchor.constraint(equalTo: helperCallBtn.bottomAnchor, constant: 20)
        ])
        emergencyCallBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emergencyCallBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            emergencyCallBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            emergencyCallBtn.heightAnchor.constraint(equalTo: helperView.heightAnchor, multiplier: 0.28),
            emergencyCallBtn.centerYAnchor.constraint(equalTo: bgBottomView.centerYAnchor)
        ])
    }

@objc private func helperCallAction(_ sender: UIButton) {
        print("\n---------- [ helperCall ] ----------\n")
        let url = URL(string: "tel:\(helperNumber)")!
        print(url)
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func helperMessageAction(_ sender: UIButton) {
        print("\n---------- [ openMessage ] ----------\n")
        let url = URL(string: "sms:\(helperNumber)&body=hello")!
        print(url)
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func emergencyCallAction(_ sender: UIButton) {
        print("\n---------- [ emergencyCallCall ] ----------\n")
        let url = URL(string: "tel:119")!
        print(url)
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied: break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            startUpdatingLocation()
        @unknown default: break
        }
    }
    
    func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedWhenInUse || status == .authorizedAlways else { return }
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.startUpdatingLocation() //위치 업데이트 실행하도록 하는 매소드
    }
    
    private func btnStyle(title: String) -> UIButton { // 버튼 스타일 함수
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        return button
    }
}


extension ElderMainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Authorized")
        default:
            print("Unauthorized")
        }
    }
    
    
    //MARK: Location Upload to Firebase
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations.last!
        let elderLocation = current.coordinate
        ref = Database.database().reference()
        
        //MARK: latitude & longitude Upload to Firebase
        guard let elderCode = UserDefaults.standard.string(forKey: "elderCode") else {return}
        let values = ["latitude": String(elderLocation.latitude),
                      "longitude": String(elderLocation.longitude)]
        self.ref.child("users").child(elderCode).child("elderLocation").setValue(values) { (error, ref) in
            if error == nil {
                Timer.cancelPreviousPerformRequests(withTarget: self.checkAuthorizationStatus())
                print("success")
            } else {
                print("fail")
                fatalError(error!.localizedDescription)
            }
        }
        
        
        //MARK: Date Info Upload to Firebase
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddHH"
        let stringDate = dateFormatter.string(from: date)
//        print(stringDate)
        let timeInfo = ["lastUpdatingTime": stringDate]
        self.ref.child("users").child(elderCode).child("lastTime").setValue(timeInfo) { (error, ref) in
            if error == nil {
                print("timeUpdating Success")
            } else {
                print("timeUpdating fail")
                fatalError()
            }
        }
    }
}
