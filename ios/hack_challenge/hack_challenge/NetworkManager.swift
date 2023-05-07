//
//  NetworkManager.swift
//  hack_challenge
//
//  Created by David Vizueth on 5/5/23.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    let urlReal = URL(string: "http://35.199.32.240:8000/api/locations")!
    var url = URL(string: "http://35.199.32.240:8000/api/locations")!

    func getAllLocations(completion: @escaping ([Location]) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        request.setValue("jdv72", forHTTPHeaderField: "netid")
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Locations.self, from: data)
                    completion(response.locations)
                }
                catch (let error){
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getLocationSpecific(region: String, completion: @escaping ([Location]) -> Void) {
        let newURLString = "http://35.199.32.240:8000/api/locations/" + region
        let newURL = URL(string: newURLString)!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Locations.self, from: data)
                    completion(response.locations)
                }
                catch (let error){
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func updateOccupacy(id: Int, user_id: Int, completion: @escaping (Location) -> Void) {
        let newURLString = "http://35.199.32.240:8000/api/locations/" + String(id) + "/" + String(user_id)
        let newURL = URL(string: newURLString)!
        var request = URLRequest(url: newURL)
        request.httpMethod = "POST"
//
//        let body: [String: Any] = [
//            "id": id,
//            "occupier_id": user_id
//        ]
        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Location.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func registerUser(email: String, password: String, name: String, completion: @escaping (User) -> Void) {
        let newURL = URL(string: "http://35.199.32.240:8000/register/")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "POST"
        
        let body: [String: Any] = [
            "email": email,
            "password": password,
            "name": name
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(User.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
//
//    func changeMessage(id: Int, body: String, sender: String, completion: @escaping (Message) -> Void) {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("jdv72", forHTTPHeaderField: "netid")
//        let body: [String: Any] = [
//            "id": id,
//            "message": body,
////            "fromNetId": fromNetId,
////            "toNetId": toNetId,
//            "sender": sender
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, err in
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(Message.self, from: data)
//                    completion(response)
//                }
//                catch (let error) {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        task.resume()
//
//    }
//
    //    func createMessage(body: String, sender: String, to:String?="", completion: @escaping (Message) -> Void) {
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.setValue("jdv72", forHTTPHeaderField: "netid")
    //        var toSomeone = to
    //        if (to == "") {
    //            toSomeone = sender
    //        }
    //        let body: [String: Any] = [
    //            "message": body,
    //            "toNetId": toSomeone ?? sender,
    //            "sender": sender
    //        ]
    //
    //        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, err in
    //            if let data = data {
    //                do {
    //                    let decoder = JSONDecoder()
    //                    let response = try decoder.decode(Message.self, from: data)
    //                    completion(response)
    //                }
    //                catch (let error) {
    //                    print(error.localizedDescription)
    //                }
    //            }
    //        }
    //        task.resume()
    //
    //    }
//    func deleteMessage(id: Int, completion: @escaping (Message) -> Void) {
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("jdv72", forHTTPHeaderField: "netid")
//        let body: [String: Any] = [
//            "id": id
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, err in
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(Message.self, from: data)
//                    completion(response)
//                }
//                catch (let error) {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        task.resume()
//
//    }

}

