import UIKit
import Alamofire
import DropDown
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    var apimanager: ApiManager = ApiManager(urlLink: "http://data.fixer.io/api/latest?access_key=e495167586ff929ca03db8c2c900ff94&format=1")
    var currencyRates = [Double]()
    var rateAtIndex = 0.0
    let months = ["01 Jan", "07 Jun", "15 Jun", "23 Jun", "30 Jun"]
    let unitsSold = [50.0, 25.0, 50.0, 75.0, 100.0, 75.0]
    var dataEntries: [ChartDataEntry] = []
    lazy var viewModel = CurrencyViewModel(apiManager: apimanager)
    lazy var firstCurrencyLogo = [String]()
    lazy var secondCurrencyLogo = [String]()
    let secondCurrencyDropDown = DropDown()
    lazy var firstCurrencyDropDown = DropDown()

    var dataEntry = ChartDataEntry()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        disableConvertedTextFieldUserInteraction()
        configureLineChartDelegate()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayoutViews()
        configureLineChartView()
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstDropDownView: UIView!
    @IBOutlet weak var firstDropDownLabel: UILabel!
    @IBAction func firstDropDownButton(_ sender: Any) {
        firstCurrencyDropDown.show()
    }
    @IBOutlet weak var secondDropDownView: UIView!
    @IBOutlet weak var secondDropDownLabel: UILabel!
    @IBAction func secondDropDownButton(_ sender: Any) {
        secondCurrencyDropDown.show()
    }
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var BottomUIView: UIView!
    @IBOutlet weak var labelOfCurrencyToBeConverted: UILabel!
    @IBOutlet weak var labelOfCurrencyDesired: UILabel!
    @IBOutlet weak var thirtyDaysImage: UIImageView!
    @IBOutlet weak var thirtyDaysButton: UIButton!
    @IBOutlet weak var sixtyDaysImage: UIImageView!
    @IBOutlet weak var sixtyDaysButton: UIButton!
    @IBOutlet weak var textFieldOfAmountToBeConverted: UITextField!
    @IBOutlet weak var convertedCurrencyTextField: UITextField!
    @IBOutlet weak var currentTime: UILabel!
    
    @IBAction func convertButton(_ sender: Any) {
        guard let firstCurrencyText = textFieldOfAmountToBeConverted.text else {
            return
        }
        guard let firstCurrencyValue = Double(firstCurrencyText) else {
            return
        }
        convertedCurrencyTextField.text = "\(firstCurrencyValue * rateAtIndex)"
    }
    
    @IBAction func past30DaysChartButton(_ sender: Any) {
        sixtyDaysButton.alpha = 0.5
        sixtyDaysImage.alpha = 0
        thirtyDaysButton.alpha = 1
        thirtyDaysImage.alpha = 1
    }
    
    @IBAction func past60DaysChartButton(_ sender: Any) {
        thirtyDaysButton.alpha = 0.5
        thirtyDaysImage.alpha = 0
        sixtyDaysButton.alpha = 1
        sixtyDaysImage.alpha = 1
    }
    
    @IBAction func currencyShuffleButton(_ sender: Any) {
        let currencyShuffleTuple = (secondDropDownLabel.text, firstDropDownLabel.text)
        firstDropDownLabel.text = currencyShuffleTuple.0
        secondDropDownLabel.text = currencyShuffleTuple.1
    }
    
    @objc func dismissKeyboardWhenTapped() {
        self.view.endEditing(true)
    }
    
}

