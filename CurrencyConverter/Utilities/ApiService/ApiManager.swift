import UIKit
import Alamofire
import RealmSwift

protocol Api {
    
}


class ApiManager{
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        return Session(configuration: configuration)
    }()
    
    let realm = try! Realm()
    fileprivate var urlLink: String
    
    init(urlLink: String){
        self.urlLink = urlLink
    }
    
    
    func getData(completionHandler: @escaping (Result<CurrencyModel, Error>) -> Void){
        
        sessionManager.request(urlLink).responseDecodable(of: CurrencyModel.self) { result in
            
            if let error = result.error {
                
                let errors = NSError(domain: error.url?.absoluteString ?? "", code: error.responseCode ?? 0, userInfo: ["description": error.localizedDescription])
                completionHandler(.failure(errors))
            }
            
            
            if let response = result.value{
                completionHandler(.success(response))
            }
        }
    }
    
    func fetchData(completionHandler: @escaping (Result<CurrencyModel, Error>) -> Void){
        
        sessionManager.request(urlLink).responseDecodable(of: CurrencyModel.self) { result in
            
            var statusCode = result.response?.statusCode
            if let error = result.error {
                statusCode = error._code
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                        statusCode = code
                    case .customValidationFailed(let error):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }
                default: break
                }
                print("Underlying error: \(String(describing: error.underlyingError))")
                
            } else {
                print("Unknown error: \(String(describing: result.error))")
            }
        }
    }
    
}

