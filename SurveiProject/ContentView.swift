//
//  ContentView.swift
//  SurveiProject
//
//  Created by Alin Batrin on 06.01.2021.
//  26 questions 30m time.
//  multiple ansers

//  TODO: Do a list of surveys
//  TODO: show corect answers
//  TODO: if answer is corect go to the next question
//  TODO: when press Inainte, show right awnser if the anwser is not correct
//  TODO: if answer is corect go to the next question

import SwiftUI

class Survey :ObservableObject{
    @Published var surveyQuestionText:String;
    @Published var surveyAnswersText:[String];
    @Published var userAnswers :[Bool];
    @Published var answers :[Bool];
    @Published var questionNumber :Int;

    
    init(surveyQuestionText:String,surveyAnswersText:[String],userAnswers:[Bool],answers:[Bool],questionNumber:Int){
        self.surveyQuestionText = surveyQuestionText;
        self.surveyAnswersText = surveyAnswersText;
        self.userAnswers = userAnswers;
        self.answers = answers;
        self.questionNumber = questionNumber;
    }
}

class SurveyList :ObservableObject{
   
    @Published var survezList:[Survey];
    var title: String
    
    init(title: String,survey: Survey) {
        self.title = title;
        self.survezList = [];
        self.survezList.append(survey)
    }
    
    func addToList(survey:Survey) {
        survezList.append(survey)
    }
}

struct ContentView: View {
    @State private var isNight=false
    @StateObject var surveiObject = Survey(surveyQuestionText:"Ce tendinţă prezintă un autoturism cu tracţiune pe spate, dacă acceleraţi prea puternic în curbă?",surveyAnswersText:["autoturismul urmează, fără deviere, cursa volanului","autoturismul tinde să derapeze cu spatele spre exteriorul curbei","roţile din faţă se învârtesc în golroţile din faţă se învârtesc în gol"],userAnswers:[false,false,false],answers:[false,true,false],questionNumber:1);
    
//    @StateObject var surveiList = SurveyList(title:"B",survey:surveiObject);
    
    
    var body: some View {
        
        Text("Întrebarea \(surveiObject.questionNumber) din 26");
        Text("3 Răspunsuri corecte | 1 Răspuns greșit");
        NavigationView{
            
            VStack{
                BackgroundView(isNight: $isNight)
                SurveyBody()
                .offset(y:-100)
                NavigationLink(destination: SecondPage(), label: {
    //                ButtonStyle(title: "Inainte", textColor: Color.blue, backgroundColor: Color.white)
                    Text("Inainte")
                        .bold()
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
        .environmentObject(surveiObject)
    }
}

struct SecondPage: View {
   
    var body: some View {
        SurveyBody()
//        Text("Second page")
//            .frame(alignment: .top)
//            .font(.system(size: 20,weight:.bold,design:.default))
//            .padding(10)
//            .background(Color.yellow)
//            .cornerRadius(15)
        //this propertz hide the back button
        .navigationBarBackButtonHidden(true)
    }
    
}

struct SurveyBody:View{
    
    var body:some View {
        ZStack {
            
            VStack{
                QuestionBody(questionColor:Color("questionGradient"))
                QuestionAnswers()
            }
        }
    }
}

struct QuestionBody:View{
    var questionColor: Color
    @EnvironmentObject var surveyObject:Survey;
    
    var body:some View {
    
            Text(surveyObject.surveyQuestionText)
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
            CheckBox(quizText:surveyObject.surveyAnswersText[0], checkState:$surveyObject.userAnswers[0])
            CheckBox(quizText:surveyObject.surveyAnswersText[1], checkState:$surveyObject.userAnswers[1])
            CheckBox(quizText:surveyObject.surveyAnswersText[2], checkState:$surveyObject.userAnswers[2])
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
            print("Handler for button -Inainte-")
            
            //Todo: here do the logic that is validating the ansers
            if(surveiObject.answers[1] == true && surveiObject.answers[1] == surveiObject.userAnswers[1]) {
                print("Corect answer")
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
