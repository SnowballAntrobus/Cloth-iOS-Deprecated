//
//  CropperView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/25/21.
//

import SwiftUI
import Resolver

struct ManualCropperView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    
    @State var imageSize: CGSize = .zero
    @State var points: [CGPoint] = []
    @State var pointsResized: [CGPoint] = []
    
    @Binding var image: UIImage?
    
    @State var croppedImage: UIImage?
    
    @State private var newclothItemData = ClothItem.Datas()
    @State var activeSheet = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if (croppedImage != nil){
            VStack {
                Image(uiImage: croppedImage ?? UIImage(systemName: "circle")!)
                    .resizable()
                    .scaledToFit()
                Button(action: {croppedImage = nil; points = []; pointsResized = []}, label: {
                    Text("Reset")
                }).padding()
                
                Button(action: {activeSheet = true}, label: {
                                        Text("Add")
                                    }).padding()
                
                .sheet(isPresented: $activeSheet) {
                    VStack {
                        NavigationView {
                            ClothItemEditView(clothItemData: $newclothItemData, image: croppedImage)
                                .navigationBarItems(leading: Button("Dismiss") { activeSheet = false}, trailing: Button("Add") { _ = ClothItem(type: newclothItemData.type.id, color: newclothItemData.color, brand: newclothItemData.brand, price: newclothItemData.price, image: croppedImage!); activeSheet = false; image = nil; self.presentationMode.wrappedValue.dismiss()})
                        }
                    }
                }
            }
        } else {
            VStack{
                Image(uiImage: image ?? UIImage(systemName: "circle")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(rectReader())
                    .gesture(DragGesture().onChanged( { value in self.addNewPoint(value)}))
                    .overlay(DrawShape(points: points)
                                .stroke(lineWidth: 5)
                                .foregroundColor(.green))
                Button(action: {cropImage()}, label: { Text("Crop") }).padding()
                Button(action: {points = []; pointsResized = []}, label: { Text("Reset") }).padding()
            }
        }
    }
    
    private func rectReader() -> some View {
        return GeometryReader { (geometry) -> AnyView in
            let imageSize = geometry.size
            DispatchQueue.main.async {
                self.imageSize = imageSize
                self.imageSize.height = image!.size.height / imageSize.height
                self.imageSize.width = image!.size.width / imageSize.width
            }
            return AnyView(Rectangle().fill(Color.clear))
        }
    }
    
    private func addNewPoint(_ value: DragGesture.Value) {
        var x: CGFloat = value.location.x
        var y: CGFloat = value.location.y
        
        x = x * imageSize.width
        y = y * imageSize.height
        
        pointsResized.append(CGPoint(x: x, y: y))
        points.append(value.location)
    }
    
    private func cropImage() {
        croppedImage = ZImageCropper.cropImage(ofImageView: UIImageView(image: image), withinPoints: pointsResized)
    }
}

struct DrawShape: Shape {
    
    var points: [CGPoint]
    
    // drawing is happening here
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }
        
        path.move(to: firstPoint)
        for pointIndex in 1..<points.count {
            path.addLine(to: points[pointIndex])
            
        }
        return path
    }
}

struct ManualCropperView_Previews: PreviewProvider {
    static var previews: some View {
        ManualCropperView(clothItemsRepo: .constant(Resolver.resolve()), image: .constant(UIImage(named: "pants")))
    }
}
