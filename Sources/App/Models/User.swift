//
//  File.swift
//  
//
//  Created by 方泓睿 on 2021-01-17.
//

import Foundation
import Vapor
import Fluent

final class User: Model, Content{
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         name: String,
         email: String,
         passwordHash: String,
         createdAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.createdAt = createdAt
        self.deletedAt = deletedAt
    }
}
