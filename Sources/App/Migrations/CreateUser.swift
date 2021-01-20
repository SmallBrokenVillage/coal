//
//  File.swift
//  
//
//  Created by 方泓睿 on 2021-01-17.
//

import Foundation
import Fluent
import Vapor

extension User{
    struct Migration: Fluent.Migration{
        var name: String = "CreateUser"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(User.schema)
                .id()
                .field("name", .string, .required)
                .field("email", .string, .required)
                .field("password_hash", .string, .required)
                .field("created_at", .datetime)
                .field("deleted_at", .datetime)
                .unique(on: "name", "email")
                .ignoreExisting()
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(User.schema)
                .delete()
        }
    }
}
