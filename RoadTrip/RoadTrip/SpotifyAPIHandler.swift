//
//  SpotifyAPI.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/4/20.
//

import Foundation
import Combine
import SpotifyWebAPI

let sharedSpotifyAPI = SpotifyAPIHandler()

class SpotifyAPIHandler {
    var spotifyEngine = SpotifyAPI(
        authorizationManager: ClientCredentialsFlowManager(
            clientId: Auth.clientID, clientSecret: Auth.clientSecret
        )
    )
    
    var cancellables: Set<AnyCancellable> = []
    
    func authorize() {
        spotifyEngine.authorizationManager.authorize()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        print("successfully authorized application")
                    case .failure(let error):
                        print("could not authorize application: \(error)")
                }
            })
            .store(in: &cancellables)
    }
    
    func search(input: String, category: Int) -> [SongTrack] {
        let dispatchGroup = DispatchGroup()
        print("searching...")
        var categories = [IDCategory]()
        switch category {
            case 0:
                categories = [.track]
            case 1:
                categories = [.artist, .track]
            case 2:
                categories = [.album, .track]
            default:
                categories = [.track]
        }
        
        var songTracks = [SongTrack]()
        dispatchGroup.enter()
        spotifyEngine.search(query: input, categories: categories)
            .sink(
                receiveCompletion: { completion in
                    print(completion)
                    dispatchGroup.leave()
                },
                receiveValue: { results in
                    let tracks = results.tracks?.items ?? []
                    print("found \(tracks.count) tracks:")
                    print("------------------------")
                    
                    for track in tracks {
                        var artistName: String? = nil
                        if let artists = track.artists {
                            var artistConcat = artists[0].name
                            if artists.count > 1 {
                                for (i, artist) in artists.enumerated() {
                                    if i != 0 {
                                        artistConcat.append(", \(artist.name)")
                                    }
                                }
                            }
                            artistName = artistConcat
                        }
                        
                        var imageURL: String? = nil
                        if let album = track.album {
                            if let images = album.images {
                                if images.count > 0 {
                                    imageURL = images[0].url
                                }
                            }
                        }
                        
                        if let uri = track.uri {
                            let newTrack = SongTrack(
                                title: track.name,
                                artist: artistName,
                                album: track.album?.name ?? nil,
                                uri: uri,
                                popularity: track.popularity ?? nil,
                                imageURI: imageURL)
                            
                            songTracks.append(newTrack)
                        }
                    }
                }
            )
            .store(in: &cancellables)
        dispatchGroup.wait()
        print("apihandler: \(songTracks.count)")
        return songTracks
    }
    

    init() {
        
    }
}
