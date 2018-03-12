import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var laCity: UITextField!
    @IBOutlet weak var laResult: UILabel!
    @IBAction func GetYourTime(_ sender: Any) {
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(laCity.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        GetSunSet(url: url)
    }
 
    func GetSunSet (url:String){
        DispatchQueue.global().async {
        do {
            let appurl = URL(string:url)!
            let data = try Data(contentsOf : appurl)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let query = json["query"] as! [String:Any]
            let results = query["results"] as! [String:Any]
            let channel = results["channel"] as! [String:Any]
            let astronomy = channel["astronomy"] as! [String:Any]
            DispatchQueue.global().sync {
            self.laResult.text! = "SunSet in \(self.laCity.text!) is : \(astronomy["sunset"]!)"
            }
        }catch {
            print("cannot provide service")
            }
            }
}
}
