//
//  ViewController.swift
//  AstonProject002
//
//  Created by Георгий Евсеев on 25.09.23.
//

import CoreLocation
import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    let locationManager = CLLocationManager()

    var myLabel1: UILabel!

    var main = Main()
    var weatherData = WeatherData()
    var weatherService = WeatherService()

    private let viewModel = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        startLocationManager()
//        updateWeatherInfo(latitude: 44.34, longtitude: 10.99)
    }

    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.pausesLocationUpdatesAutomatically = false
                self.locationManager.startUpdatingLocation()
            }
        }
    }

//    func updateWeatherInfo(latitude: Double, longtitude: Double) {
//        let session = URLSession.shared
//        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(weatherService.apiKey)")
//        let task = session.dataTask(with: url!) { data, _, error in
//            guard error == nil else {
//                print("Data error")
//                return
//            }
//            do {
//                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
//                print(self.weatherData)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
    func updateWeatherInfo(latitude: Double, longtitude: Double) -> Observable<Weather> {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(weatherService.apiKey)")

        let task = session.dataTask(with: url!) { data, _, error in
            guard error == nil else {
                print("Data error")
                return
            }
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                print(self.weatherData)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        return URLSession.shared.rx.data(request: URLRequest(url: url!))
            // Преобразуем данные в модель Weather
            .map { data in
                try JSONDecoder().decode(Weather.self, from: data)
            }
    }

    func drawLabel1() {
            myLabel1.frame = CGRect(x: view.frame.width / 2 - 150, y: view.frame.height - 410, width: 100, height: 40)
            myLabel1.tintColor = UIColor.orange
            myLabel1.text = "\(weatherData.name)"
            view.addSubview(myLabel1)
        }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
                self.updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
                print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
            }
    }
}
