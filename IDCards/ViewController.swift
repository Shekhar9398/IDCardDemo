import UIKit
import FirebaseFirestore

class ViewControler: UIViewController {
    @IBOutlet weak var idcardTableView: UITableView!
    var names = [String]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTable()
    }
    
    func reloadTable() {
        names = [String]()
        db.collection("People").getDocuments { querySnapshot, err in
            if let err = err {
                print("error getting document \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) = \(document.data())")
                    if let name = document.data()["name"] as? String {
                        print("name is \(name)")
                        self.names.append(name)
                    }
                }
                self.idcardTableView.reloadData()
            }
            
        }
    }
    @IBAction func addName(_ sender: UIButton) {
        var ref: DocumentReference? = nil
        ref = db.collection("People").addDocument(data: ["name":  "new name"], completion: { err in
            if let err = err {
                print("error adding document \(err)")
            } else {
                print("error adding document \(ref!.documentID)")
            }
        })

       reloadTable()
        
    }
}

extension ViewControler: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("names.count \(names.count)")
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IDCardsTableViewCell = idcardTableView.dequeueReusableCell(withIdentifier: "idcards", for: indexPath)  as! IDCardsTableViewCell
        
        cell.nameLabel.text = names[indexPath.row]

        cell.profileStudent.image = UIImage(named: "profile")
        
        cell.backgroundColor = .yellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           let sourseItem = names[indexPath.row]
           db.collection("People").document(sourseItem).delete() { err in
               if let err = err {
                   print("Error removing document: \(err)")
               } else {
                   print("Document successfully removed!")
               }
           }
           reloadTable()
           
       }
   }
    
    
}



