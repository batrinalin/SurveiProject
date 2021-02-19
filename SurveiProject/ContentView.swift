//
//  ContentView.swift
//  SurveiProject
//
//  Created by Alin Batrin on 06.01.2021.
//

import SwiftUI

class Survey :ObservableObject{
    @Published var surveyText:[String];
    @Published var userAnswers :[Bool];
    @Published var answers :[Bool];
    @Published var multipleAnsers : Bool;
    
    init(surveyText:[String],userAnswers:[Bool],answers:[Bool], multipleAnsers:Bool){
        self.surveyText = surveyText;
        self.userAnswers = userAnswers;
        self.answers = answers;
        self.multipleAnsers = multipleAnsers;
    }
}


struct ContentView: View {
    @State private var isNight=false
    @StateObject var surveiObject = Survey(surveyText:["Ce tendinţă prezintă un autoturism cu tracţiune pe spate, dacă acceleraţi prea puternic în curbă?","autoturismul urmează, fără deviere, cursa volanului","autoturismul tinde să derapeze cu spatele spre exteriorul curbei","roţile din faţă se învârtesc în golroţile din faţă se învârtesc în gol"],userAnswers:[false,false,false],answers:[false,true,false],multipleAnsers:false);
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack{
                QuestionBody(questionColor:Color("questionGradient"))
                QuestionAnswers()
                ButtonStyle(title: "Inainte", textColor: Color.blue, backgroundColor: Color.white)
            }
            
        }
        .environmentObject(surveiObject)
    }
}

struct QuestionBody:View{
    var questionColor: Color
    @EnvironmentObject var surveyObject:Survey;
    
    var body:some View {
    
            Text(surveyObject.surveyText[0])
                .frame(alignment: .top)
                .font(.system(size: 20,weight:.bold,design:.default))
                .padding(10)
                .background(Color.yellow)
                .cornerRadius(15)
    }
}

struct QuestionAnswers: View {
    @EnvironmentObject var surveyObject:Survey;
    
    var body: some View {
        
        VStack(alignment: .leading){
            CheckBox(quizText:surveyObject.surveyText[1], checkState:$surveyObject.userAnswers[0])
            CheckBox(quizText:surveyObject.surveyText[2], checkState:$surveyObject.userAnswers[1])
            CheckBox(quizText:surveyObject.surveyText[3], checkState:$surveyObject.userAnswers[2])
        }
        .background(Color("lightBlue"))
        .cornerRadius(15)
    }
}

struct BackgroundView: View {
    @Binding var isNight:Bool
        
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ?.black:.blue,isNight ?.gray:Color("lightBlue")])
                       ,startPoint: .topLeading
                       ,endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CheckBox:View{
    var quizText: String
    @Binding var checkState:Bool;
    
    var body:some View {
        Button(action:
                    {
                        //1. Save state
                        self.checkState = !self.checkState
                    }) {
            HStack(spacing: 10) {

                                //2. Will update according to state
                        Image(systemName:checkState ?"checkmark.circle.fill":"checkmark.circle")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width:40, height: 40)

                           Text(quizText)
                            .frame(alignment: .center)
                            .foregroundColor(.black)
                            .font(.system(size: 20,weight:.light,design:.default))
                            .cornerRadius(15)
                            .padding(10)

                    
            }
        }
    }
}

struct ButtonStyle: View {
    var title:String
    var textColor:Color
    var backgroundColor:Color

    @EnvironmentObject var surveiObject:Survey;
    var body: some View {
        Button{
            print("Schimba la modul de noapte Jonule")
            
            //Todo: here do the logic that is validating the ansers
            if(surveiObject.answers[1] == true && surveiObject.answers[1] == surveiObject.userAnswers[1]) {
                print("SSS")
            }
        } label:{
            Text(title)
                .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(backgroundColor)
                .foregroundColor(textColor)
                .font(.system(size: 20,weight:.bold,design:.default))
                .cornerRadius(15)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
