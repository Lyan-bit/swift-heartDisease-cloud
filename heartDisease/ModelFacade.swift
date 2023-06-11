	                  
import Foundation
import SwiftUI

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
if typeName == "HeartDisease"
  { let x = try? decoder.decode(HeartDisease.self, from: jdata) 
  return x
}
  return nil
	}

class ModelFacade : ObservableObject {
		                      
	static var instance : ModelFacade? = nil
	var cdb : FirebaseDB = FirebaseDB.getInstance()
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> ModelFacade { 
		if instance == nil
	     { instance = ModelFacade() 
	      }
	    return instance! }
	                          
	init() { 
		// init
	}
	      
	@Published var currentHeartDisease : HeartDiseaseVO? = HeartDiseaseVO.defaultHeartDiseaseVO()
	@Published var currentHeartDiseases : [HeartDiseaseVO] = [HeartDiseaseVO]()

		func createHeartDisease(x : HeartDiseaseVO) {
		    if let obj = getHeartDiseaseByPK(val: x.id)
			{ cdb.persistHeartDisease(x: obj) }
			else {
			let item : HeartDisease = createByPKHeartDisease(key: x.id)
		      item.id = x.getId()
		      item.age = x.getAge()
		      item.sex = x.getSex()
		      item.cp = x.getCp()
		      item.trestbps = x.getTrestbps()
		      item.chol = x.getChol()
		      item.fbs = x.getFbs()
		      item.restecg = x.getRestecg()
		      item.thalach = x.getThalach()
		      item.exang = x.getExang()
		      item.oldpeak = x.getOldpeak()
		      item.slope = x.getSlope()
		      item.ca = x.getCa()
		      item.thal = x.getThal()
		      item.outcome = x.getOutcome()
			cdb.persistHeartDisease(x: item)
			}
			currentHeartDisease = x
	}
			
	func cancelCreateHeartDisease() {
		//cancel function
	}
	
	func deleteHeartDisease(id : String) {
		if let obj = getHeartDiseaseByPK(val: id)
		{ cdb.deleteHeartDisease(x: obj) }
	}
		
	func cancelDeleteHeartDisease() {
		//cancel function
	}
	
	func cancelEditHeartDisease() {
		//cancel function
	}

		func cancelSearchHeartDiseaseByAge() {
	//cancel function
}

    func classifyHeartDisease(x : String) -> String {
        guard let heartDisease = getHeartDiseaseByPK(val: x)
        else {
            return "Please selsect valid id"
        }
        
        guard let result = self.modelParser?.runModel(
          input0: Float((heartDisease.age - 29) / (77 - 29)),
          input1: Float(heartDisease.sex),
          input2: Float((heartDisease.cp - 0) / (3 - 0)),
          input3: Float((heartDisease.trestbps - 94) / (200 - 94)),
          input4: Float((heartDisease.chol - 126) / (564 - 126)),
          input5: Float(heartDisease.fbs),
          input6: Float((heartDisease.restecg - 0) / (2 - 0)),
          input7: Float((heartDisease.thalach - 71) / (202 - 71)),
          input8: Float(heartDisease.exang),
          input9: Float((heartDisease.oldpeak - 0) / (Int(6.2) - 0)),
          input10: Float((heartDisease.slope - 0) / (2 - 0)),
          input11: Float((heartDisease.ca - 0) / (4 - 0)),
          input12: Float((heartDisease.thal - 0) / (3 - 0))
        ) else{
            return "Error"
        }
        
        heartDisease.outcome = result
        persistHeartDisease(x: heartDisease)
        
        return result
	}
	
	func cancelClassifyHeartDisease() {
		//cancel function
	}
	    


    func listHeartDisease() -> [HeartDiseaseVO] {
		currentHeartDiseases = [HeartDiseaseVO]()
		let list : [HeartDisease] = HeartDiseaseAllInstances
		for (_,x) in list.enumerated()
		{ currentHeartDiseases.append(HeartDiseaseVO(x: x)) }
		return currentHeartDiseases
	}
			
	func loadHeartDisease() {
		let res : [HeartDiseaseVO] = listHeartDisease()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKHeartDisease(key: x.id)
	        obj.id = x.getId()
        obj.age = x.getAge()
        obj.sex = x.getSex()
        obj.cp = x.getCp()
        obj.trestbps = x.getTrestbps()
        obj.chol = x.getChol()
        obj.fbs = x.getFbs()
        obj.restecg = x.getRestecg()
        obj.thalach = x.getThalach()
        obj.exang = x.getExang()
        obj.oldpeak = x.getOldpeak()
        obj.slope = x.getSlope()
        obj.ca = x.getCa()
        obj.thal = x.getThal()
        obj.outcome = x.getOutcome()
			}
		 currentHeartDisease = res.first
		 currentHeartDiseases = res
	}
		
	func stringListHeartDisease() -> [String] { 
		var res : [String] = [String]()
		for (_,obj) in currentHeartDiseases.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
    func searchByHeartDiseaseid(val : String) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.id == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaseage(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.age == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasesex(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.sex == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasecp(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.cp == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasetrestbps(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.trestbps == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasechol(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.chol == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasefbs(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.fbs == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaserestecg(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.restecg == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasethalach(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.thalach == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaseexang(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.exang == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaseoldpeak(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.oldpeak == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaseslope(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.slope == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaseca(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.ca == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseasethal(val : Int) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.thal == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByHeartDiseaseoutcome(val : String) -> [HeartDiseaseVO] {
	    var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
	    let list : [HeartDisease] = HeartDiseaseAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.outcome == val) {
	    		resultList.append(HeartDiseaseVO(x: x))
	    	}
	    }
	  return resultList
	}
	
		
	func getHeartDiseaseByPK(val: String) -> HeartDisease?
		{ return HeartDisease.heartDiseaseIndex[val] }
			
	func retrieveHeartDisease(val: String) -> HeartDisease?
			{ return HeartDisease.heartDiseaseIndex[val] }
			
	func allHeartDiseaseids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentHeartDiseases.enumerated()
			{ res.append(item.id + "") }
			return res
	}
			
	func setSelectedHeartDisease(x : HeartDiseaseVO)
		{ currentHeartDisease = x }
			
	func setSelectedHeartDisease(i : Int) {
		if i < currentHeartDiseases.count
		{ currentHeartDisease = currentHeartDiseases[i] }
	}
			
	func getSelectedHeartDisease() -> HeartDiseaseVO?
		{ return currentHeartDisease }
			
	func persistHeartDisease(x : HeartDisease) {
		let vo : HeartDiseaseVO = HeartDiseaseVO(x: x)
		cdb.persistHeartDisease(x: x)
		currentHeartDisease = vo
	}
		
	func editHeartDisease(x : HeartDiseaseVO) {
		if let obj = getHeartDiseaseByPK(val: x.id) {
		 obj.id = x.getId()
		 obj.age = x.getAge()
		 obj.sex = x.getSex()
		 obj.cp = x.getCp()
		 obj.trestbps = x.getTrestbps()
		 obj.chol = x.getChol()
		 obj.fbs = x.getFbs()
		 obj.restecg = x.getRestecg()
		 obj.thalach = x.getThalach()
		 obj.exang = x.getExang()
		 obj.oldpeak = x.getOldpeak()
		 obj.slope = x.getSlope()
		 obj.ca = x.getCa()
		 obj.thal = x.getThal()
		 obj.outcome = x.getOutcome()
		cdb.persistHeartDisease(x: obj)
		}
	    currentHeartDisease = x
	}
			
	}
