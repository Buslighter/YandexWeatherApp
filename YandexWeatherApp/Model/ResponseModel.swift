//
//  ResponseModel.swift
//  YandexWeatherApp
//
//  Created by gleba on 25.08.2022.
import Foundation

// MARK: - Weather
struct Weather: Codable {
    let now: Int?
    let nowDt: String
    let info: Info
    let fact: Fact
    let forecast: Forecast

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case info, fact, forecast
    }
}

// MARK: - Fact
struct Fact: Codable {
    let obsTime, temp, feelsLike, tempWater: Int?
    let icon, condition: String
    let windSpeed: Double
    let windDir: String
    let pressureMm, pressurePa, humidity: Int
    let daytime: String
    let polar: Bool
    let season: String
    let windGust: Double

    enum CodingKeys: String, CodingKey {
        case obsTime = "obs_time"
        case temp
        case feelsLike = "feels_like"
        case tempWater = "temp_water"
        case icon, condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity, daytime, polar, season
        case windGust = "wind_gust"
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs, week: Int
    let sunrise, sunset: String
    let moonCode: Int
    let moonText: String
    let parts: [Part]

    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case week, sunrise, sunset
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case parts
    }
}

// MARK: - Part
struct Part: Codable {
    let partName: String
    let tempMin, tempAvg, tempMax, tempWater: Int?
    let windSpeed, windGust: Double
    let windDir: String
    let pressureMm, pressurePa, humidity, precMm: Int
    let precProb, precPeriod: Int
    let icon, condition: String
    let feelsLike: Int
    let daytime: String
    let polar: Bool

    enum CodingKeys: String, CodingKey {
        case partName = "part_name"
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
        case tempWater = "temp_water"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case precMm = "prec_mm"
        case precProb = "prec_prob"
        case precPeriod = "prec_period"
        case icon, condition
        case feelsLike = "feels_like"
        case daytime, polar
    }
}

// MARK: - Info
struct Info: Codable {
    let url: String
    let lat, lon: Double
}
