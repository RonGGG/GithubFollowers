//
//  ErrorMessage.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 19/1/2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "The username created an invalid request."
    case unableToComplete = "Unable to complete your request. Please check the internet connection."
    case invalidResponse = "Invalid response. Please try again."
    case invalidData = "The data from server is invalid. Please try again."
    
    case unableToRetrieveFavorites = "The favorites list is not able to retrieve."
    case unableToSaveFavorites = "The favorites list is not able to save."
    
    case userExistInFavoriteList = "This user is already exist in the favorite list."
    case userNotExistInFavoriteList = "This user is not exist in the favorite list."
}
