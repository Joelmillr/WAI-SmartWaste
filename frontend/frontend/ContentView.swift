//
//  ContentView.swift
//  frontend
//
//  Created by Joel Miller on 2022-02-24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    // prediction
    @State private var prediction: String = ""
    @State private var showingPopover = false
    
    // images
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    // loading
    @State private var isLoading = false
    
    var vSpinner : UIView?
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(prediction)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                    
                    if(isLoading){
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint:.blue))
                            .scaleEffect(3)
                    }
                }
                .onTapGesture {
                    // select an image
                    showingImagePicker = true
                }
                
                HStack {
                    Button("Select image") {
                        // select an image
                        showingImagePicker = true
                    }
                    
                    Spacer()
                    
                    Button("Detect Trash"){
                        Task {
                            await detectTrash()
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Detect Trash")
            .onChange(of: inputImage) {
                _ in loadImage()
                prediction = ""
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showingPopover) {
                ActionSheet(title: Text("This image is most likely " + prediction),
                            buttons: [.cancel()])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func detectTrash() async {
        guard let inputImage = inputImage else { return }
        
        isLoading = true
        let jpgData = inputImage.jpegData(compressionQuality: 1.0)!
        let path = documentDirectoryPath()?.appendingPathComponent("trash.jpg")
        try? jpgData.write(to: path!)
        
        let url = URL(string:"https://smartwaste-backend.uk.r.appspot.com/predict")!
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let paramName = "file"
        let fileName = "trash.jpg"
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(inputImage.pngData()!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let responseJson = jsonData as? [String: Any] {
                    if let pred = responseJson["prediction"] as? Int {
                        print(pred)
                        prediction = interpretResponse(response: pred)
                        showingPopover = true
                        isLoading = false
                    }
                }
            }
        }).resume()
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask)
        return path.first
    }
    
    func interpretResponse(response: Int) -> String {
        let types = ["cardboard","glass","metal", "paper","plastic","trash"]
        prediction = types[response]
        return (types[response])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

