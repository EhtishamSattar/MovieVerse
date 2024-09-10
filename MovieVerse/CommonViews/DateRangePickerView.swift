import SwiftUI

struct DateRangePickerAlert: View {
    @ObservedObject var movies_Data : MoviesViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Dates")
                .font(.headline)
            
            // DatePicker for Start Date
            DatePicker("Start Date", selection: $movies_Data.startDate, displayedComponents: .date)

            // DatePicker for End Date
            DatePicker("End Date", selection: $movies_Data.endDate, displayedComponents: .date)
                .tint(.white)
                

            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button(action: {
                    movies_Data.getMoviesDataInDateRange()
                    isPresented = false
                    
                }) {
                    Text("Confirm")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top)
        }
        .padding()
        .background(Color("BackgroundColor"))
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(color:.white ,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DateRangePickerAlert(movies_Data : MoviesViewModel(), isPresented: Binding.constant(false))
}
