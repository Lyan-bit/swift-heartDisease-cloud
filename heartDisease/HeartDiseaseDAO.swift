import Foundation

class HeartDiseaseDAO
{ static func getURL(command : String?, pars : [String], values : [String]) -> String
  { var res : String = "base url for the data source"
    if command != nil
    { res = res + command! }
    if pars.count == 0
    { return res }
    res = res + "?"
    for (i,v) in pars.enumerated()
    { res = res + v + "=" + values[i]
      if i < pars.count - 1
      { res = res + "&" }
    }
    return res
  }

  static func isCached(id : String) -> Bool
    { let x : HeartDisease? = HeartDisease.heartDiseaseIndex[id]
    if x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> HeartDisease
    { return HeartDisease.heartDiseaseIndex[id]! }

  static func parseCSV(line: String) -> HeartDisease?
  { if line.count == 0
    { return nil }
    let line1vals : [String] = Ocl.tokeniseCSV(line: line)
    var heartDiseasex : HeartDisease? = nil
      heartDiseasex = HeartDisease.heartDiseaseIndex[line1vals[0]]
    if heartDiseasex == nil
    { heartDiseasex = createByPKHeartDisease(key: line1vals[0]) }
    heartDiseasex!.id = line1vals[0]
    heartDiseasex!.age = Int(line1vals[1]) ?? 0
    heartDiseasex!.sex = Int(line1vals[2]) ?? 0
    heartDiseasex!.cp = Int(line1vals[3]) ?? 0
    heartDiseasex!.trestbps = Int(line1vals[4]) ?? 0
    heartDiseasex!.chol = Int(line1vals[5]) ?? 0
    heartDiseasex!.fbs = Int(line1vals[6]) ?? 0
    heartDiseasex!.restecg = Int(line1vals[7]) ?? 0
    heartDiseasex!.thalach = Int(line1vals[8]) ?? 0
    heartDiseasex!.exang = Int(line1vals[9]) ?? 0
    heartDiseasex!.oldpeak = Int(line1vals[10]) ?? 0
    heartDiseasex!.slope = Int(line1vals[11]) ?? 0
    heartDiseasex!.ca = Int(line1vals[12]) ?? 0
    heartDiseasex!.thal = Int(line1vals[13]) ?? 0
    heartDiseasex!.outcome = line1vals[14]

    return heartDiseasex
  }

  static func parseJSON(obj : [String : AnyObject]?) -> HeartDisease?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["id"] as! String?
      var heartDiseasex : HeartDisease? = HeartDisease.heartDiseaseIndex[id!]
      if (heartDiseasex == nil)
      { heartDiseasex = createByPKHeartDisease(key: id!) }

       heartDiseasex!.id = jsonObj["id"] as! String
       heartDiseasex!.age = jsonObj["age"] as! Int
       heartDiseasex!.sex = jsonObj["sex"] as! Int
       heartDiseasex!.cp = jsonObj["cp"] as! Int
       heartDiseasex!.trestbps = jsonObj["trestbps"] as! Int
       heartDiseasex!.chol = jsonObj["chol"] as! Int
       heartDiseasex!.fbs = jsonObj["fbs"] as! Int
       heartDiseasex!.restecg = jsonObj["restecg"] as! Int
       heartDiseasex!.thalach = jsonObj["thalach"] as! Int
       heartDiseasex!.exang = jsonObj["exang"] as! Int
       heartDiseasex!.oldpeak = jsonObj["oldpeak"] as! Int
       heartDiseasex!.slope = jsonObj["slope"] as! Int
       heartDiseasex!.ca = jsonObj["ca"] as! Int
       heartDiseasex!.thal = jsonObj["thal"] as! Int
       heartDiseasex!.outcome = jsonObj["outcome"] as! String
      return heartDiseasex!
    }
    return nil
  }

  static func writeJSON(x : HeartDisease) -> NSDictionary
  { return [    
       "id": x.id as NSString, 
       "age": NSNumber(value: x.age), 
       "sex": NSNumber(value: x.sex), 
       "cp": NSNumber(value: x.cp), 
       "trestbps": NSNumber(value: x.trestbps), 
       "chol": NSNumber(value: x.chol), 
       "fbs": NSNumber(value: x.fbs), 
       "restecg": NSNumber(value: x.restecg), 
       "thalach": NSNumber(value: x.thalach), 
       "exang": NSNumber(value: x.exang), 
       "oldpeak": NSNumber(value: x.oldpeak), 
       "slope": NSNumber(value: x.slope), 
       "ca": NSNumber(value: x.ca), 
       "thal": NSNumber(value: x.thal), 
       "outcome": x.outcome as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [HeartDisease]
  { var res : [HeartDisease] = [HeartDisease]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0 {
    	//check
    }
      else
      { let x : HeartDisease? = parseCSV(line: row)
        if (x != nil)
        { res.append(x!) }
      }
    }
    return res
  }
}

