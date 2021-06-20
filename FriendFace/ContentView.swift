//
//  ContentView.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UserCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserCore.name, ascending: true)]) var users: FetchedResults<UserCore>
    
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: DetailView(user: user), tag: user.wrappedId, selection: $navigationHelper.selection, label: {
                    HStack {
                        Text(user.wrappedName)
                            .font(.headline)
                            .layoutPriority(1)
                        Text(String("\(user.wrappedAge) y/o"))
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
            .onAppear(perform:
                        { if users.isEmpty {
                            fetchData()
                        }})
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
                    for person in userListBackground {
                        
                        let newUser = UserCore(context: self.moc)
                        newUser.id = person.id
                        newUser.isActive = person.isActive
                        newUser.name = person.name
                        newUser.age = Int16(person.age)
                        newUser.company = person.company
                        newUser.email = person.email
                        newUser.address = person.address
                        newUser.about = person.about
                        newUser.registered = person.registered
                        newUser.tags = person.tags
                        
                        var tempFriends = [FriendCore]()
                        
                        for friend in person.friends {
                            let newFriend = FriendCore(context: self.moc)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            tempFriends.append(newFriend)
                        }
                        
                        newUser.friends = NSSet(array: tempFriends)
                        
                        if moc.hasChanges {
                            try? self.moc.save()
                        }
                    }
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
