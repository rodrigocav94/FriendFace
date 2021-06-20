//
//  DetailView.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let user: UserCore
    
    @FetchRequest(entity: UserCore.entity(), sortDescriptors: []) var users: FetchedResults<UserCore>
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    
    var body: some View {
        List {
            Section(header: Text("Profile")) {
                RowView(tittle: "Name", response: user.wrappedName)
                RowView(tittle: "Age", response: "\(user.wrappedAge) years old")
                RowView(tittle: "Company", response: user.wrappedCompany)
                RowView(tittle: "E-mail", response: user.wrappedEmail)
                HStack {
                    Text("Address:")
                        .foregroundColor(.gray)
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text(user.wrappedAddress)
                    }
                }
                HStack {
                    Text("Status:")
                        .foregroundColor(.secondary)
                    Text(user.isActive ? "Active" : "Inactive")
                        .foregroundColor(user.isActive ? .green : .red)
                }
                HStack {
                    Text("Tags:")
                        .foregroundColor(.gray)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< user.wrappedTags.count) {tag in
                                Text(user.wrappedTags[tag])
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .background((Capsule().foregroundColor(.blue)))
                            }
                        }
                    }
                }
            }
            Section(header: Text("About")) {
                Text(user.wrappedAbout)
            }
            Section(header: Text("Friends")) {
                ForEach(0..<user.friendsArray.count) { friend in
                    NavigationLink(destination: DetailView(user: findFriend(friend: user.friendsArray[friend])), label: { Text(user.friendsArray[friend].wrappedName) })
                    
                }
            }
        }
        .navigationBarTitle(Text(user.wrappedName), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { navigationHelper.selection = nil }, label: { Image(systemName: "house") })
            }
        }
    }
    func findFriend(friend: FriendCore) -> UserCore {
        let match = users.first(where: { $0.id == friend.id })!
        return match
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user1 = UserCore()
        DetailView(user: user1)
    }
}

struct RowView: View {
    var tittle: String
    var response: String
    var body: some View {
        HStack {
            Text("\(tittle):")
                .foregroundColor(.gray)
            Text(response)
        }
    }
}
