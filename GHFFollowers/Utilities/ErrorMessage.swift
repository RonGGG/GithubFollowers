//
//  ErrorMessage.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 19/1/2024.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername = "The username created an invalid request."
    case unableToComplete = "Unable to complete your request. Please check the internet connection."
    case invalidResponse = "Invalid response. Please try again."
    case invalidData = "The data from server is invalid. Please try again."
}
