//
//  MapViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 10.11.2022.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var coordinator: Coordinator?
    
    private var mapView = MKMapView()
    
    private let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        manager.delegate = self
        requestLoationAuthtorisation()
        addAnnotations()
        addRoute()
    }
    
    private func addAnnotations() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.760852, longitude: 37.619118)
        annotation.title = "Большой театр"
        mapView.addAnnotation(annotation)
    }
    
    private func addRoute() {
        let directionRequest = MKDirections.Request()
        
        guard let myLocation = manager.location?.coordinate else { return }
        let sourcePlaceMark = MKPlacemark(coordinate: myLocation)
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        
        let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.760852, longitude: 37.619118))
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            guard let route = response.routes.first else { return }
            self.mapView.delegate = self
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
        
    }
    
    private func requestLoationAuthtorisation() {
        let currentStatus = manager.authorizationStatus
        switch currentStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsScale = true
            mapView.showsUserLocation = true
            mapView.showsCompass = true
//            mapView.delegate = self
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Использование геолокации запрещено пользователем")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLoationAuthtorisation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .red
        return renderer
    }

}
