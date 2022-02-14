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
}

