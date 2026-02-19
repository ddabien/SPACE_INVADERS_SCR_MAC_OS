import ScreenSaver
import AVKit
import AVFoundation

final class SpaceInvadersScreensaverView: ScreenSaverView {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        wantsLayer = true  // ✅ PRIMERO que todo
        setupVideoPlayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true  // ✅ PRIMERO que todo
        setupVideoPlayer()
    }

    private func setupVideoPlayer() {
        let bundlesToTry: [Bundle] = [
            Bundle(for: type(of: self)),
            Bundle.main
        ]

        let videoURL = bundlesToTry
            .compactMap { $0.url(forResource: "video", withExtension: "mp4") }
            .first

        guard let videoURL else {
            NSLog("❌ Video no encontrado")
            bundlesToTry.forEach { NSLog("   • \($0.bundlePath)") }
            return
        }

        let item = AVPlayerItem(url: videoURL)
        let player = AVPlayer(playerItem: item)
        player.isMuted = true
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(restartVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item
        )

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = bounds
        playerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]

        // ✅ Usar layer directamente, sin opcional
        self.layer!.addSublayer(playerLayer)

        self.player = player
        self.playerLayer = playerLayer

        // ✅ Pequeño delay para que el layer esté listo antes de reproducir
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.player?.play()
        }
    }

    override func layout() {
        super.layout()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        playerLayer?.frame = bounds
        CATransaction.commit()
    }

    // ✅ Necesario para screensavers
    override func startAnimation() {
        super.startAnimation()
        player?.play()
    }

    override func stopAnimation() {
        super.stopAnimation()
        player?.pause()
    }

    @objc private func restartVideo() {
        player?.seek(to: .zero)
        player?.play()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
