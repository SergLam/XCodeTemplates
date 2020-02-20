//___FILEHEADER___

import CoreLocation
import Foundation

final class URLBuilder {
    
    // MARK: - Open location URL
    static func appleMapsLocationURL(_ location: CLLocationCoordinate2D) -> URL {
        
        let urlString = "http://maps.apple.com/?ll=\(location.latitude),\(location.longitude)&z=12&t=m"
        guard let url = URL(string: urlString) else {
            preconditionFailure("Unable to create url")
        }
        return url
    }
    
    static func googleMapsLocationURL(_ location: CLLocationCoordinate2D) -> URL {
        
        let urlString = "center=\(location.latitude),\(location.longitude)&zoom=14&views=satellite"
        let fullString = "comgooglemaps://?\(urlString)"
        guard let url = URL(string: fullString) else {
            preconditionFailure("Unable to create url")
        }
        return url
    }
    
    static func yandexMapsLocationURL(_ location: CLLocationCoordinate2D) -> URL {
        
        let str = "yandexmaps://maps.yandex.ru/?ll=\(location.latitude),\(location.longitude)&z=12&l=map"
        guard let url = URL(string: str) else {
            preconditionFailure("Unable to create url")
        }
        return url
    }
    
    // MARK: - Open route URL
    static func googleMapsRouteURL(_ from: CLLocationCoordinate2D,
                                   _ to: CLLocationCoordinate2D,
                                   _ toAddress: String) -> URL {
        guard let address = toAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            preconditionFailure("Unable to encode string")
        }
        let coordinatesString = "q=\(address)&saddr=\(from.latitude),\(from.longitude)&daddr=\(to.latitude),\(to.longitude)"
        let routeString = "comgooglemaps://?\(coordinatesString)&directionsmode=driving"
        guard let routeURL = URL(string: routeString) else {
            preconditionFailure("Unable to create url")
        }
        return routeURL
    }
    
    static func yandexMapsRouteURL(_ from: CLLocationCoordinate2D, _ to: CLLocationCoordinate2D) -> URL {
        
        let coordinatesString = "whatshere[point]=\(to.latitude),\(to.longitude)&lat_from=\(from.latitude)&lon_from=\(from.longitude)&lat_to=\(to.latitude)&lon_to=\(to.longitude)"
        guard let routeURL = URL(string: "yandexmaps://build_route_on_map/?\(coordinatesString)") else {
            preconditionFailure("Unable to create url")
        }
        return routeURL
    }
    
    static func yandexNavigatorRouteURL(_ from: CLLocationCoordinate2D, _ to: CLLocationCoordinate2D) -> URL {
        
        let coordinatesString = "whatshere[point]=\(to.latitude),\(to.longitude)&lat_from=\(from.latitude)&lon_from=\(from.longitude)&lat_to=\(to.latitude)&lon_to=\(to.longitude)"
        guard let routeURL = URL(string: "yandexnavi://build_route_on_map/?\(coordinatesString)") else {
            preconditionFailure("Unable to create url")
        }
        return routeURL
    }
    
}
