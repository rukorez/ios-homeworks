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
    
    private let deleteButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(removeAnnotation), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        view.addSubview(deleteButton)
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        deleteButton.frame = CGRect(x: view.bounds.width - 50, y: view.bounds.height - 150, width: 35, height: 35)
        manager.delegate = self
        requestLoationAuthtorisation()
        addGestureForAddAnnotations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeAnnotation()
    }
    
    private func addGestureForAddAnnotations() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(foundTap(_ :)))
        mapView.addGestureRecognizer(gesture)
    }
    
    @objc private func foundTap(_ recognizer: UILongPressGestureRecognizer) {
        removeAnnotation()
        let point: CGPoint = recognizer.location(in: mapView)
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: view)
        let annotation = MKPointAnnotation()
        annotation.coordinate = tapCoordinate
        annotation.title = "Новая метка"
        mapView.addAnnotation(annotation)
        addRoute(destination: tapCoordinate)
    }
    
    @objc private func removeAnnotation() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    private func addRoute(destination location: CLLocationCoordinate2D) {
        let directionRequest = MKDirections.Request()
        
        guard let myLocation = manager.location?.coordinate else { return }
        let sourcePlaceMark = MKPlacemark(coordinate: myLocation)
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        
        let destinationPlaceMark = MKPlacemark(coordinate: location)
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
