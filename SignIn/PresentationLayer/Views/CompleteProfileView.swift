//
//  CompleteProfileView.swift
//  SignIn
//
//  Created by Himanshu on 5/1/23.
//

import SwiftUI
import PhotosUI

struct CompleteProfileView: View {
    
    // MARK: properties
    
    // environmnt object for signin viewmodel
    @EnvironmentObject private var signInViewModel: SignInViewModel
    
    @State var userDetailsModel = UserDetailsModel()
    
    // instance for textFieldValidations
    private let textFieldValidate = TextFieldValidations()
    
    // property to get the text field value color
    // in gender field (selectable in menu style)
    var textColor: Color {
        userDetailsModel.genderTextFieldValue.isEmpty ? .gray.opacity(0.5) : .black
    }
    
    // property to get selected gender
    // for showing in the menu picker
    var selectedGender: String {
        userDetailsModel.genderTextFieldValue.isEmpty ? Constants.selectGender : userDetailsModel.genderTextFieldValue
    }
    
    // photos picker item
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image = Image(systemName: Constants.defaultProfile)
    
    // MARK: body
    
    var body: some View {
        ScrollView {
            VStack{
                // top bar for showing title and caption
                TitleAndCaption(title: Constants.aboutYou, caption: Constants.aboutYouCaption)
                
                // photos picker item
                VStack {
                    avatarImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                    PhotosPicker(Constants.selectImage, selection: $avatarItem, matching: .images)
                        .font(.system(size: 14))
                }
                .padding(.bottom)
                .onChange(of: avatarItem) { _ in
                    Task {
                        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                withAnimation{
                                    userDetailsModel.uiImageData = uiImage
                                    avatarImage = Image(uiImage: uiImage)
                                }
                                return
                            }
                        }

                        signInViewModel.errorMessage = Constants.imageNotSetPhotosPicker
                        signInViewModel.showErrorAlert = true
                    }
                }
                
                
                // first name text field
                TextFieldAndValidationDrawer(placeholder: Constants.firstName, textFieldValue: $userDetailsModel.firstNameTextFieldValue, valitaionMessage: $userDetailsModel.firstNameValidationMessage)
                
                // last name text field
                TextFieldAndValidationDrawer(placeholder: Constants.lastName, textFieldValue: $userDetailsModel.lastNameTextFieldValue, valitaionMessage: $userDetailsModel.lastNameValidationMessage)
                
                // age text field
                TextFieldAndValidationDrawer(placeholder: Constants.age, textFieldValue: $userDetailsModel.ageTextFieldValue, valitaionMessage: $userDetailsModel.ageValidationMessage)
                    .onChange(of: userDetailsModel.ageTextFieldValue){
                        text in
                        if text.count > 2 {
                            userDetailsModel.ageTextFieldValue = String(text.prefix(2))
                        }
                    }
                
                // menu for selecting gender
                Menu {
                    Picker(selection: $userDetailsModel.genderTextFieldValue) {
                        ForEach(Constants.genderOptions.reversed(), id: \.self) { value in
                            Text(value)
                        }
                    } label: {}
                } label: {
                    HStack{
                        Text(selectedGender)
                            .foregroundColor(textColor)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .font(.system(size: 14))
                .padding()
                .frame(height: 52)
                .background(.gray.opacity(0.25))
                .cornerRadius(6)
                
                ValidationMessage(validationMessage: $userDetailsModel.genderValidationMessage)
                
                // continue button
                Button(action: {
                    
                    userDetailsModel.checkForValidations(textFieldValidate: textFieldValidate)
                    
                    // check if validations messages are all empty
                    if (userDetailsModel.checkForValidationMessages(textFieldValidate: textFieldValidate)
                    ){
                        
                        // create data for sending with api request
                        let data = userDetailsModel.getData()
                        
                        // call sendApiRequest method in signInViewModel
                        // with request type and data as arguments
                        signInViewModel.sendApiRequest(requestType: .edit, data: data)
                    }
                    
                }, label: {
                    ButtonLabel(buttonText: Constants.profileButtonText)
                })
                .padding(.vertical, 24)
                
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .alert(signInViewModel.errorMessage, isPresented: $signInViewModel.showErrorAlert) {
                    Button(Constants.okay, role: .cancel) {
                        signInViewModel.showErrorAlert = false
                        signInViewModel.errorMessage = ""
                    }
            }
            .onAppear{
                userDetailsModel.resetValues()
            }
        }
    }
}

struct CompleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteProfileView()
    }
}
