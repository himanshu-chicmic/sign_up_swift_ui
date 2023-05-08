//
//  DashboardView.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI

struct DashboardView: View {
    
    // MARK: properties
    
    // environment object of signin viewmodel
    @EnvironmentObject private var viewModelObj: ViewModelBase
    
    // MARK: body
    
    var body: some View {
        VStack{
            
            // check and load image url from user data
            if let imageURL = viewModelObj.userDataModel?.imageURL {
                AsyncImage(url: imageURL,
                    content: { image in
                        // customize image
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 300, maxHeight: 100)
                    },
                    placeholder: {
                        // set placeholder for image
                    Image(systemName: Constants.DefaultIcons.profilePicture)
                    }
                )
                .clipShape(Circle())
            }
            
            // check and load user details from user data
            if let data = viewModelObj.userDataModel?.status.data {
                
                // full name
                Text("\(data.firstName) \(data.lastName)")
                
                // age
                Text("\(data.age)")
                
                // gender
                Text(data.gender)
            }
            
            Button(action: {
                // send api request on button click to log out user
                // and clear the session
                viewModelObj.sendApiRequest(requestType: .signOut)
            }, label: {
                // text for logout button
                Text(Constants.TextButton.logOut)
            })
            .padding(.top, 34)
            // hides navigation back button
            .navigationBarBackButtonHidden(true)
            // show user alert if any error has encountered
            .alert(viewModelObj.errorMessage, isPresented: $viewModelObj.showErrorAlert) {
                    // button to dismiss alert message
                Button(Constants.TextButton.okay, role: .cancel) {
                        viewModelObj.disableErrorMessage()
                    }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(ViewModelBase())
    }
}
