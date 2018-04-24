//
//  Constants.swift
//  ChampSelect
//
//  Created by Chinmay Ghotkar on 4/23/18.
//  Copyright © 2018 Chinmay Ghotkar. All rights reserved.
//

import Foundation

// MARK: - URLS that do not have rate limit for API calls

// Static Data on All Champions

func generateURLforAllChampionData(withVersion currentVersion : String) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/\(currentVersion)/data/en_US/champion.json"
}

// Get detailed information about a specifc Champion

func generateURLforSpecificChampionData(withId championId : Int) -> String {
    return "https://na1.api.riotgames.com/lol/static-data/v3/champions/\(championId)?locale=en_US&champData=allytips&champData=enemytips&champData=passive&champData=spells&api_key=\(Key.Riot.API)"
}

// Get all version numbers for the game
let versionDataURL : String = "https://ddragon.leagueoflegends.com/api/versions.json"

// MARK: - URLS with rate limit for API calls
