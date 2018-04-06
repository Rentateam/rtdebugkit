import Foundation
import UIKit

public class BackendEndpointSelectController: UITableViewController {
    private var endpointList: [String:String] = [:]
    private var selectedEndpoint: String?
    var backendEndpointService: BackendEndpointService!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        endpointList = self.backendEndpointService.getBackendEndpointList()
        self.selectedEndpoint = self.backendEndpointService.getCurrentBackendPoint()
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return endpointList.values.count
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BackendEndpointIdentifier", for: indexPath)
        let endpointKey = Array(endpointList.keys)[indexPath.row]
        let endpointValue = endpointList[endpointKey]
        cell.textLabel?.text = endpointValue
        if endpointValue == self.selectedEndpoint {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let endpointKey = Array(endpointList.keys)[indexPath.row]
        let actionSheet = UIAlertController(title: "Переключение сервера", message: "Сменить сервер?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(
            title: "Отмена",
            style: .cancel,
            handler: nil
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Переключить",
            style: .default,
            handler: {(alert: UIAlertAction!) in
                self.setBackendAlias(endpointKey)
            }
        ))

        self.present(
            actionSheet,
            animated: true
        )
    }
    
    private func setBackendAlias(_ alias: String) {
        self.backendEndpointService.setCurrentAlias(alias)
        self.dismiss(animated: true, completion: nil)
    }
}
