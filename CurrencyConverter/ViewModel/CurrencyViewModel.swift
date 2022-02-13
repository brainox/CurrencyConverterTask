import Foundation
import RealmSwift

class CurrencyViewModel {
    
    var persistedRateList: Results<Currency>?
    var persistRate: CurrencyDictionary?
    var currency = Currency()
    var currencyObject: [CurrencyDictionary]?
    var timeStamp = 0
    var date = ""
    var loadCurrencyDropDown: [String] = []
    let persistRealm = RealmPersistenceStore()
    var base: [String] = [String]()
    var urlString: String?
    var apiClass: ApiManager?
    var readDataSaved : ((Bool) -> Void)?
    var rateArray = [Double]()
    var getConversionRate: (([Double]) -> Void)?
    var getDate: ((Int) -> Void)?
    
    init(apiString: String){
        self.urlString = apiString
        apiClass = ApiManager(urlLink: urlString ?? "")
    }
    
    func saveData(){
        
        apiClass?.getData(completionHandler: { [self] result in
            switch result {
                
            case .success(let data):
                self.base.append(data.base)
                self.date = data.date
                self.timeStamp = data.timestamp
                
                for (key, value) in data.rates{
                    persistRate = CurrencyDictionary()
                    persistRate?.currency = key
                    persistRate?.rate = value
                    currency.currency.append(persistRate!)
                    rateArray.append(value)
                    getDate?(timeStamp)
                    getConversionRate?(rateArray)
                }
                
                persistRealm.delete()
                persistRealm.saveData(of: currency)
                readDataSaved?(true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func passRetreivedData(completionHandler: ( @escaping (Container) -> Void )){
        var a : Container?
        readDataSaved = { dataAvailable in
            if dataAvailable {
                self.fetchDataFromRealm()
                a = Container(base: self.base, currency: self.loadCurrencyDropDown)
                completionHandler(a!)
            }
        }
    }
    
    func fetchDataFromRealm(){
        self.persistedRateList = persistRealm.readData()
        let data = persistedRateList?.first?.currency
        if let keys = data {
            for i in 0..<keys.count {
                loadCurrencyDropDown.append(keys[i].currency)
            }
        }
    }
}
