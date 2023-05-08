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
    @EnvironmentObject private var viewModelObj: ViewModelBase
    
    // user details model class instance
    @State var userDetailsModel = UserDetailsModel() {
        willSet{
            // set value in view model
            viewModelObj.userDetailsModel = userDetailsModel
        }
    }
    
    // photos picker item
    @State private var avatarItem: PhotosPickerItem?
    
    // MARK: body
    
    var body: some View {
        ScrollView {
            VStack{
                // top bar for showing title and caption
                TitleAndCaption(
                    title:      Constants.ProfileView.aboutYou,
                    caption:    Constants.ProfileView.aboutYouCaption
                )
                
                // photos picker item
                VStack {
                    // display image
                    viewModelObj.avatarImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                    
                    // photos picker item button
                    // to pick a photo from gallery
                    PhotosPicker(Constants.Placeholder.selectImage,
                        selection:  $avatarItem,
                        matching:   .images
                    )
                    .font(.system(size: 14))
                }
                .padding(.bottom)
                .onChange(of: avatarItem) { _ in
                    Task {
                        // get the data
                        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                            // get ui image
                            if let uiImage = UIImage(data: data) {
                                // set the uiImageData
                                // and update the image in the view
                                withAnimation{
                                    userDetailsModel.uiImageData = uiImage
                                    viewModelObj.avatarImage = Image(uiImage: uiImage)
                                }
                                // return
                                return
                            }
                        }
                        else {
                            // set the error message
                            // set show alert to true
                            viewModelObj.errorMessage = Constants.Errors.imageNotSet
                            viewModelObj.showErrorAlert = true
                        }
                    }
                }
                
                
                // first name text field
                TextFieldAndValidationDrawer(
                    placeholder:        Constants.Placeholder.firstName,
                    textFieldValue:     $userDetailsModel.firstNameTextFieldValue,
                    valitaionMessage:   $userDetailsModel.firstNameValidationMessage
                )
                
                // last name text field
                TextFieldAndValidationDrawer(
                    placeholder:        Constants.Placeholder.lastName,
                    textFieldValue:     $userDetailsModel.lastNameTextFieldValue,
                    valitaionMessage:   $userDetailsModel.lastNameValidationMessage
                )
                
                // age text field
                TextFieldAndValidationDrawer(
                    placeholder:        Constants.Placeholder.age,
                    textFieldValue:     $userDetailsModel.ageTextFieldValue,
                    valitaionMessage:   $userDetailsModel.ageValidationMessage
                )
                .keyboardType(.numberPad)
                .onChange(of: userDetailsModel.ageTextFieldValue){
                    text in
                    // keep the age limit to only 2 digits
                    // if the count of ageTextFieldValue is more than two
                    // get the substring and and assign the ageTextField
                    // thus it always remains less than or equal to two digits
                    if text.count > 2 {
                        userDetailsModel.ageTextFieldValue = String(text.prefix(2))
                    }
                }
                
                // menu for selecting gender with validation message
                Group{
                    Menu {
                        // set the picker
                        // get the genders and place in seleciton
                        // array
                        Picker(selection: $userDetailsModel.genderTextFieldValue) {
                            ForEach(Constants.StringArrays.genderOptions.reversed(), id: \.self) { value in
                                Text(value)
                            }
                        } label: {}
                    } label: {
                        // set the label for menu
                        HStack{
                            Text(viewModelObj.selectedGender)
                                .foregroundColor(viewModelObj.textColor)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .font(.system(size: 14))
                    .padding()
                    .frame(height: 52)
                    .background(.gray.opacity(0.25))
                    .cornerRadius(6)
                    
                    // validation message for select gender menu
                    ValidationMessage(validationMessage: $userDetailsModel.genderValidationMessage)
                }
                
                // continue button
                Button(action: {
                    
                    // check for text field validations
                    userDetailsModel
                        .checkForValidations(textFieldValidate: viewModelObj.textFieldValidate)
                    
                    // check if validations messages are all empty
                    let checkValidations: Bool = userDetailsModel.checkForValidationMessages(textFieldValidate: viewModelObj.textFieldValidate)
                    
                    // if true call the api method
                    if (checkValidations){
                        // call sendApiRequest method in signInViewModel
                        // with request type and data as arguments
                        viewModelObj.sendApiRequest(requestType: .edit)
                    }
                    
                }, label: {
                    // text for continue button
                    ButtonLabel(buttonText: Constants.PrimaryButton.completeProfile)
                })
                .padding(.vertical, 24)
                
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            // show user alert if any error has encountered
            .alert(viewModelObj.errorMessage, isPresented: $viewModelObj.showErrorAlert) {
                Button(Constants.TextButton.okay, role: .cancel) {
                        viewModelObj.disableErrorMessage()
                    }
            }
            .onAppear{
                // reset the text field and validation values when the view appears
                userDetailsModel = .init()
            }
        }
    }
}

struct CompleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteProfileView()
            .environmentObject(ViewModelBase())
    }
}
