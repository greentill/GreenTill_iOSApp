//
//  ServiceFactory.swift
//  Green Receipts
//
//  Created by Mansur on 01/12/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class ServiceFactory: NSObject {
    
    typealias CallBackGet = (AnyObject?, Error?, Bool) -> Void
    typealias CallBackPost = (AnyObject?, Error?, Bool) -> Void
    
    func callGetWithURL(strURL:String?, parameters: [String: Any]?, callBack:@escaping CallBackGet) {
        
        var responceDictinary: AnyObject?
        let url: URL
        if let unwrappedURLString = strURL
        {
             url = URL(string: unwrappedURLString)!
        }
        else
        {
            url = URL(string: "")!
        }
        
        
        var request: URLRequest? = nil
//        if let url = url {
//            request = URLRequest(url: url)
//        }
        request = URLRequest(url: url)
        request?.httpMethod = "GET"
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        sessionConfiguration.timeoutIntervalForRequest = 60
        
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue:OperationQueue.main)
        if let urlRequest = request
        {
            
            let sessionTask = session.dataTask(with: urlRequest) { data, responce, error in
                guard let data = data, let response = responce as? HTTPURLResponse, error == nil else{
                    return
                }
                
                do {
                    let jsonDictinoary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    responceDictinary = jsonDictinoary as AnyObject
                    if (response.statusCode >= 200 && response.statusCode <= 299)
                    {
                        callBack(responceDictinary,nil,true)
                    }
                    else
                    {
                        callBack(responceDictinary,nil,false)
                    }
                } catch {
                    callBack(nil,error,false)
                }
                
            }
            
            sessionTask.resume()
        }
        
    }
    
    func postServiceCallWithServiceURL(serviceURL: String, dict: [String : Any]?, callBack: @escaping CallBackPost) {
        
        var reponseDictionary: AnyObject?
        
        let url = URL(string: serviceURL)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
            let response = response as? HTTPURLResponse,
                error == nil else {
                    return
            }
            
            if response.statusCode == 403 {
                print("ServiceAAAPPII: \(serviceURL)")
                return
            } else {
                
                do {
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    reponseDictionary = jsonDictionary as AnyObject
                    
                    if(response.statusCode >= 200 && response.statusCode <= 209)
                    {
                        callBack(reponseDictionary,nil,true)
                    }
                    else{
                        callBack(reponseDictionary,error,false)
                    }
                } catch {
                    callBack(nil,error,false)
                }
            }
        }
        task.resume()
    }
    
    func multipartRequest(serviceURL:String, parameters: [String:String]?, imgData: Data, callBack: @escaping CallBackPost) {
        
        var reponseDictionary: AnyObject?
        let request : URLRequest
        
        do {
             request = try createRequestWithParameters(url: serviceURL, parameters: parameters, imgData: imgData)
        } catch {
            print(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {
                    return
            }
            
            if response.statusCode == 403 {
                print("ServiceAAAPPII: \(serviceURL)")
                return
            } else {
                do {
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    reponseDictionary = jsonDictionary as AnyObject
                    
                    if(response.statusCode >= 200 && response.statusCode <= 209)
                    {
                        callBack(reponseDictionary,nil,true)
                    }
                    else{
                        callBack(reponseDictionary,error,false)
                    }
                } catch {
                    callBack(nil,error,false)
                }
            }
        }
        
        task.resume()
    }
    
    func createRequestWithParameters(url: String, parameters: [String: String]?,imgData:Data) throws -> URLRequest {
        
        let boundary = generateBoundaryString()
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try createBody(with: parameters, filePathKey: "bill_img", imageData: imgData, boundary: boundary)
        
        return request
    }
    
    private func createBody(with parameters: [String: String]?, filePathKey: String, imageData:Data, boundary:String) throws -> Data {
        var body: Data = Data()

        parameters?.forEach { (key, value) in
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        let filename = "image1.jpg"
        let data = imageData
        let mimetype = "image/jpg"

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(data)
        body.append("\r\n")
        body.append("--\(boundary)\r\n")
        
        return body
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}

extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8)
    {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
