//
//  ServiceParsingKeys.swift
//  Assignment
//
//  Created by Atinderpal Singh on 05/02/19.
//  Copyright © 2019 Abc. All rights reserved.
//

import Foundation

enum ServiceParsingKeys : String, CodingKey {
    case page     =   "page"
    case total_results     =   "total_results"
    case total_pages     =   "total_pages"
    case results     =   "results"
    case adult     =   "adult"
    case id     =   "id"
    case backdrop_path     =   "backdrop_path"
    case original_language     =   "original_language"
    case original_title     =   "original_title"
    case overview     =   "overview"
    case popularity     =   "popularity"
    case poster_path     =   "poster_path"
    case release_date     =   "release_date"
    case title     =   "title"
    case video     =   "video"
    case vote_average     =   "vote_average"
    case vote_count     =   "vote_count"
}

