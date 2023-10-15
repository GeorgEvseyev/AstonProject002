//
//  ViewModel.swift
//  AstonTask
//
//  Created by Георгий Евсеев on 4.10.23.
//

import Foundation
import RxSwift
import RxCocoa

// Создаем вью-модель для связи модели и представления
class WeatherViewModel {
// Свойство для хранения сервиса
private let weatherService = WeatherService()

// Свойство для хранения модели погоды с биндингом
private let weatherSubject = PublishSubject<Weather>()

// Свойство для получения модели погоды как observable
var weather: Observable<Weather> {
return weatherSubject.asObservable()
}

//// Метод для обновления погоды по названию города
//func updateWeather(for city: String) {
//// Вызываем сервис и обновляем модель погоды при получении ответа
//weatherService.fetchWeather(for: city)
//.subscribe(onNext: { [weak self] weather in
//self?.weatherSubject.onNext(weather)
//}, onError: { error in
//print("Ошибка получения данных о погоде:", error)
//})
//.disposed(by: disposeBag)
//}

// Свойство для управления подписками и освобождения ресурсов
private let disposeBag = DisposeBag()
}


