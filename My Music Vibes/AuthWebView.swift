//
//  AuthWebView.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import SwiftUI
import WebKit

struct AuthWebView:UIViewRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self, self.vm)
    }
    
    @ObservedObject var vm:AuthViewModel
    //let url:URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.navigationDelegate = context.coordinator
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: vm.authEndpointURL)
        uiView.load(request)
    }
    
}

extension AuthWebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        private let parent: AuthWebView
        @ObservedObject private var webViewModel: AuthViewModel
        init(_ parent: AuthWebView, _ webViewModel: AuthViewModel) {
            self.parent = parent
            self.webViewModel = webViewModel
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            //webViewModel.webViewState = .loading
            guard let url = webView.url else { return }
            
            guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
            webView.isHidden = true
            Task {
                do{
                    try await self.parent.vm.getAndSaveAuthToken(authCode: code)
                    webViewModel.webViewState = .success
                } catch {
                    print("request didnt work")
                }
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            webViewModel.isLoading = false
//            webViewModel.title = webView.title ?? ""
//            webViewModel.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            webViewModel.isLoading = false
        }
    }
}
