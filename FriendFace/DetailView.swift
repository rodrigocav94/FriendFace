//
//  DetailView.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//

import SwiftUI

struct DetailView: View {
    let userList: [User]
    let user: User
    var body: some View {
        List {
            Section(header: Text("Profile")) {
                RowView(tittle: "Name", response: user.name)
                RowView(tittle: "Age", response: "\(user.age) years old")
                RowView(tittle: "Company", response: user.company)
                RowView(tittle: "E-mail", response: user.email)
                HStack {
                    Text("Address:")
                        .foregroundColor(.gray)
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text(user.address)
                    }
                }
                HStack {
                    Text("Status:")
                        .foregroundColor(.secondary)
                    Text(user.isActive ? "Active" : "Inactive")
                        .foregroundColor(user.isActive ? .green : .red)
                }
                RowView(tittle: "Registered since", response: user.wrappedRegistered)
                HStack {
                    Text("Tags:")
                        .foregroundColor(.gray)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< user.tags.count) {tag in
                                Text(user.tags[tag])
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
                Text(user.about)
            }
            Section(header: Text("Friends")) {
                Text("")
            }
        }
        .navigationBarTitle(Text(user.name), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let id = UUID()
        let user1 = User(id: id, isActive: true, name: "Pessoa", age: 26, company: "Secreta", email: "user@secreta.com", address: "Campina Grande", about: "É alguém", registered: Date(), tags: ["Pessoa","Novo","Alguém","Anônimo"], friends: [User.Friend(id: id, name: "Si mesmo")])
        DetailView(userList: [user1], user: user1)
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
