//
//  GetDataModel.swift
//  YandexWeatherApp
//
//  Created by gleba on 25.08.2022.
//

import Foundation
import UIKit
import SVGKit

struct Constants{
    var url = "https://api.weather.yandex.ru/v2/informers?"
    let APIKey = "X-Yandex-API-Key"
    let APIValue = "5ae30283-a564-4d06-b66e-0db576cc130b  delete"
    init (lat: String, long:String){
        self.url += "lat=" + lat + "&lon=" + long
    }
}
class GetDataFromAPI{
    private var url: URL?
    func getDataByLocation(latitude: String,longtitude: String, completion: @escaping (Weather) -> Void){
        var results: Weather?
        let constant = Constants.init(lat: latitude, long: longtitude)
        url = URL(string: constant.url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(constant.APIValue, forHTTPHeaderField: constant.APIKey)
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    let res = try decoder.decode(Weather.self, from: data!)
                    results = res
                }catch{
                    print(error)
                }
                DispatchQueue.main.async {
                    if results != nil{
                        completion(results!)
                    }else{
                        return
                    }
                }
            }
        }.resume()
    }
    func downloadImage(imageName: String) -> UIImage{
        let imageURL = "https://yastatic.net/weather/i/icons/funky/dark/\(imageName).svg"
        let mySVGImage: SVGKImage = SVGKImage(contentsOf: URL(string: imageURL))
        guard let image = mySVGImage.uiImage else { return UIImage() }
        return image
    }
}
