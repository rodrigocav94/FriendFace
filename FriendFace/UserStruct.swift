//
//  UserStruct.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//

import SwiftUI

struct User: Codable, Identifiable {
    struct Friend: Codable {
        var id: UUID
        var name: String
    }
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [User.Friend]
    
    var wrappedRegistered: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let dateString = formatter.string(from: registered)
        return dateString
    }
}
