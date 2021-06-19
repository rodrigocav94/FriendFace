//
//  ContentView.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var userList: [User] = []
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    var body: some View {
        NavigationView {
            List(userList) { user in
                NavigationLink(destination: DetailView(userList: userList, user: user), tag: user.id, selection: $navigationHelper.selection, label: {
                    HStack {
                        Text(user.name)
                            .font(.headline)
                            .layoutPriority(1)
                        Text(String("\(user.age) y/o"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(user.isActive ? "Active" : "Inactive")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .background((Capsule().foregroundColor(user.isActive ? .green : .red)))
                    }
                })
            }
            .navigationBarTitle(Text("FriendFace"))
            .onAppear(perform: fetchData)
        }
    }
    func fetchData() {
        guard let url = URL(string: "https://hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let userData = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            
            let userDecoder = JSONDecoder()
            userDecoder.dateDecodingStrategy = .iso8601

            do {
                let userListBackground = try userDecoder.decode([User].self, from: userData)
                DispatchQueue.main.async {
                    userList = userListBackground
                }
                return
            } catch {
                print("Decoding Failed: \(error)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class NavigationHelper: ObservableObject {
    @Published var selection: UUID? = nil
}
