import ScreenSaver
import AVKit
import AVFoundation

final class SpaceInvadersScreensaverView: ScreenSaverView {

    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        setupVideoPlayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVideoPlayer()
    }

    private func setupVideoPlayer() {

        // Bundles candidatos (ScreenSaver a veces NO usa Bundle.main)
        let bundles: [Bundle] = [
            Bundle(for: type(of: self)),
            Bundle.main
        ]

        // Buscar el video.mp4 en Resources
        let videoURL = bundles
            .compactMap { $0.url(forResource: "video", withExtension: "mp4") }
            .first

        guard let videoURL else {
            NSLog("❌ video.mp4 no encontrado. Bundles probados:")
            bundles.forEach { NSLog("   • \($0.bundlePath)") }
            return
        }

        let playerItem = AVPlayerItem(url: videoURL)
        let player = AVPlayer(playerItem: playerItem)
        player.isMuted = true
        player.actionAtItemEnd = .none

        // Loop infinito
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(restartVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )

        let layer = AVPlayerLayer(player: player)
        layer.frame = bounds
        layer.videoGravity = .resizeAspectFill

        wantsLayer = true
        self.layer?.addSublayer(layer)

        self.player = player
        self.playerLayer = layer

        player.play()
    }

    @objc private func restartVideo() {
        player?.seek(to: .zero)
        player?.play()
    }

    override func resizeSubviews(withOldSize oldSize: NSSize) {
        super.resizeSubviews(withOldSize: oldSize)
        playerLayer?.frame = bounds
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
