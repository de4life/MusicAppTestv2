//
//  ContentView.swift
//  MusicAppTestv2
//
//  Created by Артур Агеев on 17.10.2022.
//

import SwiftUI

    //MARK:- Public
    struct Album: Hashable {
    var id = UUID()
    var name: String
    var image: String
    var songs: [Song]
    }

    struct Song: Hashable {
    var id = UUID()
    var name: String
    var time: String
    }

    private var imageLogo = 4
private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    //MARK:- Hardcode cells
    struct ContentView: View {

    var albums = [Album(name: "Album 1", image: "1",
                        songs: [Song(name: "Song 1", time: "2:36"),
                                Song(name: "Song 2", time: "2:36"),
                                Song(name: "Song 3", time: "2:36"),
                                Song(name: "Song 4", time: "2:36")]),
                 Album(name: "Album 2", image: "2",
                            songs: [Song(name: "Song 1", time: "2:36"),
                                    Song(name: "Song 2", time: "2:36"),
                                    Song(name: "Song 3", time: "2:36"),
                                    Song(name: "Song 4", time: "2:36")]),
                 Album(name: "Album 3", image: "3",
                            songs: [Song(name: "Song 1", time: "2:36"),
                                Song(name: "Song 2", time: "2:36"),
                                Song(name: "Song 3", time: "2:36"),
                                Song(name: "Song 4", time: "2:36")]),
                Album(name: "Album 4", image: "4",
                        songs: [Song(name: "Song 1", time: "2:36"),
                                Song(name: "Song 2", time: "2:36"),
                                Song(name: "Song 3", time: "2:36"),
                                Song(name: "Song 4", time: "2:36")]),
                Album(name: "Album 5", image: "5",
                        songs: [Song(name: "Song 1", time: "2:36"),
                                Song(name: "Song 2", time: "2:36"),
                                Song(name: "Song 3", time: "2:36"),
                                Song(name: "Song 4", time: "2:36")])]
                
    @State private var currentAlbum: Album?
    @State private var currentIndex = 0
    var body: some View {
        NavigationView {
        GeometryReader { proxy in
            TabView(selection: $currentIndex) {
            Youtube(videoID: "HEwBHlLheTs")
                        .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                        .cornerRadius(20)
                        .padding(.horizontal,21.0)
            ForEach(1..<imageLogo) { num in
                Image("\(num)")
                    .resizable()
                    .scaleEffect()
                    .overlay(Color.black.opacity(0.4))
                    .tag(num)
                
            }
        }.navigationTitle("YouTube API").tabViewStyle(PageTabViewStyle())
                .frame(width: 340, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
                .onReceive(timer, perform: { _ in
                    currentIndex = currentIndex < imageLogo ? currentIndex + 1 : 0
                })

      }
        }
        NavigationView {
            ScrollView {
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack {
                ForEach(self.albums, id: \.self, content: {
                    album in
                    AlbumArt(album: album,isWithText: true).onTapGesture {
                        self.currentAlbum = album
                    }
                    
                })
                    
                }
            })
            LazyVStack {
                ForEach((self.currentAlbum?.songs ?? self.albums.first?.songs) ??
                            [Song(name: "Song 1", time: "2:36"),
                                    Song(name: "Song 2", time: "2:36"),
                                    Song(name: "Song 3", time: "2:36"),
                                    Song(name: "Song 4", time: "2:36")], id: \.self, content: {
                                        song in
                                        SongCell(album: currentAlbum ?? albums.first!, song: song)
                    })
            }
            }.navigationTitle("Playlist Name")
    }
    }
    }
    //MARK:- Cells for player
    struct AlbumArt: View {
    var album: Album
    var isWithText: Bool
    var body: some View {
        ZStack (alignment: .bottom, content: {
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            if isWithText == true {
            ZStack {
                Blur(style: .dark)
                Text(album.name).foregroundColor(.white)
            }.frame(height: 60, alignment: .center)
            }
        }).frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
    }
    struct SongCell: View {
    var album: Album
    var song: Song
    var body: some View {
        NavigationLink(destination: PlayerView(album: album, song: song),
                       label: {
                        HStack {
                        ZStack {
                            Circle().frame(width: 50, height: 500, alignment: .center).foregroundColor(.blue)
                            Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.yellow)
                        }
                        Text(song.name).bold()
                        Spacer()
                        Text(song.time)
                    }.padding(20)
                       }).buttonStyle(PlainButtonStyle())
    }
    }

    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    }
