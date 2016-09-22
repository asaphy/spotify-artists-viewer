//
//  SAViewModel.swift
//  Spotify Artists Viewer
//
//  Created by Asaph Yuan on 9/22/16.
//  Copyright © 2016 Asaph Yuan. All rights reserved.
//

import Foundation

class RequestManager {
    static let sharedInstance = RequestManager()
    var artists: [Artist] = []
    func getArtistsWithQuery(query: String, completion: @escaping (_ artists: [Artist]?, _ error: NSError?) -> ()) {
        if let url = URL(string: "https://api.spotify.com/v1/search?q=" + query + "&type=artist") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {data, response, err in
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    for (key, value) in json!{
                        if key == "name" {
                            print("key")
                            let artist = Artist(name: String(describing: value))
                            self.artists.append(artist)
                        }
                    }
                }
                //print(self.artists)
                completion(self.artists, err as NSError?)
            }.resume()
        }
        
    }
}
