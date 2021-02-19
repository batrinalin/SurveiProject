//
//  ContentView.swift
//  SurveiProject
//
//  Created by Alin Batrin on 06.01.2021.
//  Second change, just for commit.

import SwiftUI

class Survei :ObservableObject{
    @Published var quizText:[String];
    @Published var answers :[Bool];
    @Published var multipleAnsers : Bool;
    
    init(quizText:[String],answers:[Bool], multipleAnsers:Bool){
        self.quizText = quizText;
        self.answers = answers;
        self.multipleAnsers = multipleAnsers;
    }
}


struct ContentView: View {
    @State private var isNight=false
    @StateObject var surveiObject = Survei(quizText:["Ce tendinţă prezintă un autoturism cu tracţiune pe spate, dacă acceleraţi prea puternic în curbă?","autoturismul urmează, fără deviere, cursa volanului","autoturismul tinde să derapeze cu spatele spre exteriorul curbei","roţile din faţă se învârtesc în golroţile din faţă se învârtesc în gol"],answers:[false,true,false],multipleAnsers:false);
    
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
    @EnvironmentObject var surveiObject:Survei;
    
    var body:some View {
    
            Text(surveiObject.quizText[0])
                .frame(alignment: .top)
                .font(.system(size: 20,weight:.bold,design:.default))
                .padding(10)
                .background(Color.yellow)
                .cornerRadius(15)
    }
}

struct QuestionAnswers: View {
    @EnvironmentObject var surveiObject:Survei;
    
    var body: some View {
        
        VStack(alignment: .leading){
            CheckBox(quizText:surveiObject.quizText[1], checkState:$surveiObject.answers[0])
            CheckBox(quizText:surveiObject.quizText[2], checkState:$surveiObject.answers[1])
            CheckBox(quizText:surveiObject.quizText[3], checkState:$surveiObject.answers[2])
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
                        checkState = !checkState
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

    @EnvironmentObject var surveiObject:Survei;
    var body: some View {
        Button{
            print("Schimba la modul de noapte Jonule")
            if(surveiObject.answers[1] == true) {
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
