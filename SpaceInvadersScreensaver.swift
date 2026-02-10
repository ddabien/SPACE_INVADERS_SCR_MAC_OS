import Cocoa
import ScreenSaver
import AVKit
import AVFoundation

@available(macOS 13.0, *)
class SpaceInvadersScreensaverView: ScreenSaverView {
    
    private var playerLayer: AVPlayerLayer!
    private var player: AVPlayer!
    private var playerLooper: AVPlayerLooper!
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
        
        setupVideoPlayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupVideoPlayer() {
        guard let bundle = Bundle(for: type(of: self)),
              let videoURL = bundle.url(forResource: "video", withExtension: "mp4") else {
            NSLog("❌ Video no encontrado")
            return
        }
        
        NSLog("✅ Video encontrado: \(videoURL.path)")
        
        // Crear player item
        let playerItem = AVPlayerItem(url: videoURL)
        
        // Crear queue player para loop
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        player = queuePlayer
        
        // Loop infinito
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        
        // Crear layer
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = bounds
        playerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        playerLayer.videoGravity = .resizeAspect
        
        layer?.addSublayer(playerLayer)
        
        NSLog("✅ Player configurado")
    }
    
    override func startAnimation() {
        super.startAnimation()
        player?.play()
        NSLog("▶️ Video reproduciendo")
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        player?.pause()
        NSLog("⏸️ Video pausado")
    }
    
    override func layout() {
        super.layout()
        playerLayer?.frame = bounds
    }
    
    override var hasConfigureSheet: Bool {
        return false
    }
}
