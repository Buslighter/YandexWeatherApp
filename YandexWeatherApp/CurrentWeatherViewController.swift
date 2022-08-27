//
//  ViewController.swift
//  YandexWeatherApp
//
//  Created by gleba on 24.08.2022.
//

import UIKit
import CoreLocation
import SVGKit
class CurrentWeatherViewController: UIViewController{
    private var currentWeatherIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private var someView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var locationManager = CLLocationManager()
    lazy private var downloader = GetDataFromAPI()
    
    private var weatherData: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        askForLocation()
        getLocationParameters()
        setUI()
        setConstraints()
    }
    private func askForLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    private func getLocationParameters(){
        locationManager.startUpdatingLocation()
    }
    private func setUI(){
        view.backgroundColor = .white
        view.addSubview(currentWeatherIconImage)
        view.addSubview(someView)
    }

    
}

// MARK: - Location extension
extension CurrentWeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                downloader.getDataByLocation(latitude: String(location.coordinate.latitude), longtitude: String(location.coordinate.longitude), completion: {data in
                    self.weatherData = data
                })
                print("Location data received.")
            }
        locationManager.stopUpdatingLocation()
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get users location.")
        }
}
extension CurrentWeatherViewController{
    private func setConstraints(){
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            currentWeatherIconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherIconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentWeatherIconImage.heightAnchor.constraint(equalToConstant: 40),
            currentWeatherIconImage.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            someView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            someView.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            someView.widthAnchor.constraint(equalToConstant: view.frame.width/2)
        ])
    }
}
