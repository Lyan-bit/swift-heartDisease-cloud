import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDB
{ static var instance : FirebaseDB? = nil
  var database : DatabaseReference? = nil

  static func getInstance() -> FirebaseDB
  { if instance == nil
    { instance = FirebaseDB() }
    return instance!
  }

  init() {
	  //cloud database link
      connectByURL("https://patient-161e1-default-rtdb.europe-west1.firebasedatabase.app/")
  }

  func connectByURL(_ url: String)
  { self.database = Database.database(url: url).reference()
    if self.database == nil
    { print("Invalid database url")
      return
    }
    self.database?.child("heartDiseases").observe(.value,
      with:
      { (change) in
        var keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let einst = v.1 as! [String : AnyObject]
            let ex : HeartDisease? = HeartDiseaseDAO.parseJSON(obj: einst)
            keys.append(ex!.id)
          }
        }
        var runtimeheartDiseases : [HeartDisease] = [HeartDisease]()
        runtimeheartDiseases.append(contentsOf: HeartDiseaseAllInstances)

        for (_,obj) in runtimeheartDiseases.enumerated()
        { if keys.contains(obj.id) {
        	//check
        }
          else
          { killHeartDisease(key: obj.id) }
        }
      })
  }

func persistHeartDisease(x: HeartDisease)
{ let evo = HeartDiseaseDAO.writeJSON(x: x) 
  if let newChild = self.database?.child("heartDiseases").child(x.id)
  { newChild.setValue(evo) }
}

func deleteHeartDisease(x: HeartDisease)
{ if let oldChild = self.database?.child("heartDiseases").child(x.id)
  { oldChild.removeValue() }
}

}
