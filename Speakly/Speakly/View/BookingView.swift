//
//  BookingView.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import SwiftUI

struct BookingView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Konsultasi")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 10) {
                    Image(systemName: "target")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    Text("Cari terapis")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .bold()
                        .font(.system(size: 12))
                }
                .padding()
                
            }
            .padding(.top, 30)
            
            ScrollView(.horizontal) {
                HStack(spacing: 25) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(width: 120, height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        
                        Text("Berlangsung")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(width: 120, height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        
                        Text("Diproses")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(width: 120, height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        
                        Text("Selesai")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
            }
            
            .scrollIndicators(.hidden)
            
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .frame(width: 350, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("23")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("24")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("25")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("26")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("27")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("28")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("29")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Text("Nov")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
           
            VStack {
            HStack {
                    Text("Jadwal")
                        .font(.title2)
                        .bold()
                        .padding(.top, 20)
                    Spacer()
                }
                
                Text("Tidak ada jadwal konsultasi")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.top, 50)
            }
            
            Spacer()
            
            
        }
        .padding(.leading, 30)
    }
}

#Preview {
    BookingView()
}
