//
//  Youtube.swift
//  MusicAppTestv2
//
//  Created by Артур Агеев on 17.10.2022.
//
import SwiftUI
import WebKit

struct Youtube: UIViewRepresentable {
     
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {return}
            uiView.scrollView.isScrollEnabled = false
            uiView.load(URLRequest(url: youtubeURL))
        
    }
    
}
