import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self //델리게이트를 self로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() //위치 데이터를 추적하기 위해 사용자에게 승인을 요청
        locationManager.startUpdatingLocation() //위치 업데이트를 시작
        myMap.showsUserLocation = true //위치 보기 값을 true로 설정
    }
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last //위치가 업데이트 되면 먼저 마지막 위치 값을 찾아낸다.
        //마지막 위치의 위도와 경도 값을 가지고 함수를 호출 한다.
        //이때 delta 값은 지도의 크기를 정하고, 값이 작을수록 확대된다. 0.01로 설정해쓰니 지도의 100배로 확대해서 보여준다.
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
}

