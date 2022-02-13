import UIKit
import Alamofire
import RealmSwift

protocol Api {
    
}

class ApiManager{
    
    let realm = try! Realm()
    fileprivate var urlLink: String
    
    init(urlLink: String){
        self.urlLink = urlLink
    }
    func getData(completionHandler: @escaping (Result<CurrencyModel, AFError>) -> Void){
        AF.request(urlLink).responseDecodable(of: CurrencyModel.self) { result in
            if let error = result.error {
                completionHandler(.failure(error))
            }
            if let response = result.value{
                completionHandler(.success(response))
            }
        }
    }
}


