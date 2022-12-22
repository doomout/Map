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
        //위도 값과 경도 값을 매개변수로 하여 함수를 호출하고 리턴값을 저장
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        
        //범위 값을 매개변수로 하여 함수를 호출하고 리턴값을 저장
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
    
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last //위치가 업데이트 되면 먼저 마지막 위치 값을 찾아낸다.
        //마지막 위치의 위도와 경도 값을 가지고 함수를 호출 한다.
        //이때 delta 값은 지도의 크기를 정하고, 값이 작을수록 확대된다. 0.01로 설정해쓰니 지도의 100배로 확대해서 보여준다.
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in //장소 표시, 에러를 파라미터로 받으면
            let pm = placemarks!.first //장소 표시의 첫 부분만 상수에 저장
            let country = pm!.country //나라 값을 상수에 저장
            var address:String = country! //지역 값이 있으면 주소 문자열에 추가
            if (pm!.locality != nil) { //pm상수에서 지역 값이 존재하면..
                address += " " //빈칸 넣고
                address += pm!.locality! //문자열에 추가
            }
            if (pm!.thoroughfare != nil) { //pm상수에서 도로 값이 존재하면...
                address += " "//빈칸 넣고
                address += pm!.thoroughfare! //문자열에 추가
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address //문자열의 값을 레이블에 표시
        })
        
        locationManager.stopUpdatingLocation() //마지막으로 위치 업데이트 되는 것을 정지
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
}

