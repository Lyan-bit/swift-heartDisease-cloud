
import Foundation

class ClassifyHeartDiseaseVO {
  var heartDisease : String = ""

  static var defaultInstance : ClassifyHeartDiseaseVO? = nil
  var errorList : [String] = [String]()

  var result : String = ""

  init() {
  	//init
  }
  
  static func defaultClassifyHeartDiseaseVO() -> ClassifyHeartDiseaseVO
  { if defaultInstance == nil
    { defaultInstance = ClassifyHeartDiseaseVO() }
    return defaultInstance!
  }

  init(heartDiseasex: String)  {
  heartDisease = heartDiseasex
  }

  func toString() -> String
  	{ return "" + "heartDisease = " + heartDisease }

  func getHeartDisease() -> HeartDisease
  	{ return HeartDisease.heartDiseaseIndex[heartDisease]! }
  	
  func setHeartDisease(x : HeartDisease)
  	{ heartDisease = x.id }
			  
  func setResult (x: String) {
    result = x }
          
  func resetData()
  	{ errorList = [String]() }

  func isClassifyHeartDiseaseError() -> Bool
  	{ resetData()
  
 if HeartDisease.heartDiseaseIndex[heartDisease] == nil
	{ errorList.append("Invalid heartDisease id: " + heartDisease) }


    if errorList.count > 0
    { return true }
    
    return false
  }

  func errors() -> String
  { var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}

