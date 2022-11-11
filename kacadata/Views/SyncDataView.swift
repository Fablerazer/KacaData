//
//  SyncPageView.swift
//  kacadata
//
//  Created by Faizal Hudya Rizfianto on 18/10/22.
//

import SwiftUI

struct SyncDataView: View {
    
    let image = Image(systemName: "questionmark.circle.fill")
    @StateObject
    var homeVM: HomeViewModel
    @State
    private var isAdded = false
    @State
    private var isOpened = false
    
    private func printInfo() {
        if (!homeVM.documents.isEmpty) {
            homeVM.documents.forEach { document in
                print(document.name ?? "")
                print(document.location ?? "")
                print(document.url ?? "")
            }
        } else {
            print("There is no file added")
        }
    }
    
    var body: some View {
        NavigationView {
            // MARK: - Header Section
            
            VStack {
                Image("ImageHeaderCable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 378)
                    .padding(.bottom, 48)
                    .padding(.leading, -16)
                
                // MARK: - Description Section
                
                HStack(alignment: .bottom){
                    Text("Connecting Data \nwithin KacaData ")
                        .font(.system(size: 36,
                                      weight: .bold,
                                      design: .rounded))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(0)
                    
                    NavigationLink(
                        destination: HelpSyncView()
                            .navigationBarBackButtonHidden(),
                        label: {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                                .frame(width: 26,
                                       height: 26,
                                       alignment: .center)
                                .foregroundColor(.primary)
                        }
                    )
                    .padding(.bottom, 6)
                }
                .padding(EdgeInsets(top: 0,
                                    leading: -16,
                                    bottom: 16,
                                    trailing: 0))
                
                Text("Integrate your POS data and let us do the rest. \nfind the right marketing strategy for your \nbusiness based on your real data.")
                    .font(.system(size: 16,
                                  weight: .regular,
                                  design: .rounded))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
                    .padding(EdgeInsets(top: 0,
                                        leading: -22,
                                        bottom: 20,
                                        trailing: 0))
                    .foregroundColor(.gray)
                
                // MARK: - Button Section
                
                NavigationLink(
                    destination: ConnectMokaView()
                        .navigationBarBackButtonHidden(),
                    label: {
                        Text("Connect Using MOKA")
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 48,
                                alignment: .center)
                            .background(Color.primary)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                            .font(.system(size: 14,
                                          weight: .semibold,
                                          design: .rounded))
                    }
                )
                .padding(.bottom, 4.0)
                
                Text("Import your report file (.csv)")
                    .frame(maxWidth: .infinity,
                           minHeight: 48,
                           alignment: .center)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .font(.system(size: 14,
                                  weight: .semibold,
                                  design: .rounded))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray, lineWidth: 2))
                    .padding(.horizontal, 16)
                    .sheet(isPresented: $isOpened) {
                        DocumentPickerView(homeViewModel: homeVM, added: $isAdded)
                    }
                    .onTapGesture {
                        isOpened.toggle()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
        .accentColor(.primary)
        .onAppear {
            printInfo()
        }
    }
}

struct SyncDataView_Previews: PreviewProvider {
    static var previews: some View {
        SyncDataView(homeVM: HomeViewModel())
    }
}