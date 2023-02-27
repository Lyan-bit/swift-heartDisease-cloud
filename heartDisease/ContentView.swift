              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : ModelFacade
	                                       
	var body: some View {
		TabView {
            CreateHeartDiseaseScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+HeartDisease")} 
            ListHeartDiseaseScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListHeartDisease")} 
            EditHeartDiseaseScreen (model: model).tabItem { 
                        Image(systemName: "3.square.fill")
	                    Text("EditHeartDisease")} 
            DeleteHeartDiseaseScreen (model: model).tabItem { 
                        Image(systemName: "4.square.fill")
	                    Text("-HeartDisease")} 
            SearchHeartDiseaseByAgeageScreen (model: model).tabItem { 
                        Image(systemName: "5.square.fill")
	                    Text("SearchHeartDiseaseByAgeage")} 
            ClassifyHeartDiseaseScreen (model: model).tabItem { 
                        Image(systemName: "6.square.fill")
	                    Text("ClassifyHeartDisease")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ModelFacade.getInstance())
    }
}

