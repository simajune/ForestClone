//
//  Users.swift
//  ForestClone
import Foundation

struct Account: Codable {
    var email: String
    var pwd: String
}

struct User: Codable {
    var email: String
    var nickName: String
    var pwd: String
    var cash: Int
    var totalTime: TimeInterval //??
}

