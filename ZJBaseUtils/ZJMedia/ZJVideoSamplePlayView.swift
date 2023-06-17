//
//  ZJVideoSamplePlayView.swift
//  ZJBaseUtils
//
//  Created by eafy on 2023/6/11.
//  Copyright © 2023 ZJ. All rights reserved.
//

import Foundation
import MediaPlayer
import CoreMedia

@objc public enum ZJVideoSamplePlayState: Int {
    case none = 0
    case stopped      //已停止或已结束
    case readyToPlay  //准备播放
    case playing      //正在播放
    case pause        //暂停中
    
    //下面是上报状态，不存储
    case failed       //播放失败
    case end          //播放结束(循环播放不上报)
    case reconnect    //重连播放
}

@objc public class ZJVideoSamplePlayView: UIView {
    fileprivate var player: AVPlayer?
    fileprivate var playerLayer: AVPlayerLayer?
    fileprivate var timeObserver: Any?
    fileprivate var videoOptions: [String: Any] = [:]
    fileprivate var isStatusObserver = false
    
    /// 视频总时长
    fileprivate var totalTime: Double = 0
    /// 当前时间
    fileprivate var currentTime: Double = 0
    /// 播放速率
    fileprivate var playRate: Float = 1.0
    /// 播放链接
    private(set) var videoPath: String?
    /// 播放状态
    private(set) var state: ZJVideoSamplePlayState = .none
    /// 重播检测器
    fileprivate var checkTimer: Timer?
    
    /// 播放进度回调，1s更新1次，(总时长，当前时长)
    @objc public var progressBlock: ((Double, Double) -> Void)?
    /// 播放状态回调
    @objc public var playStatusBlock: ((ZJVideoSamplePlayState) -> Void)?
    /// 是否循环播放，默认false
    @objc public var isLoopPlay: Bool = false
    /// 是否静音，默认NO
    @objc public var isMuted: Bool = false {
        didSet {
            player?.isMuted = isMuted
        }
    }
    /// 音量大小，默认0.8
    @objc public var volume: Float = 0.8 {
        didSet {
            player?.volume = volume
        }
    }
    /// 显示画面样式，默认自适应宽高
    @objc public var videoGravity: AVLayerVideoGravity = .resizeAspect {
        didSet {
            playerLayer?.videoGravity = videoGravity
        }
    }
    /// 重新播放的检测时间，设置0时，不重试播放
    @objc public var reconnectTime: TimeInterval = 6.0
    /// 进入前台是否恢复播放，默认YES
    @objc public var isResumeWhenForeground = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        initAvPlayer()
        initAudioSession()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        
        initAvPlayer()
        initAudioSession()
    }
    
    deinit {
        rempveAvPlayer()
        debugPrint("简易视频播放器已释放")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, let _ = object as? AVPlayerItem else { return }
        
        let newStatus = (change[.newKey] as? NSNumber)?.intValue ?? 0
        let oldStatus = (change[.oldKey] as? NSNumber)?.intValue
        if  oldStatus == nil || newStatus != oldStatus {
            guard let status = AVPlayer.Status(rawValue: newStatus) else { return }
            debugPrint("Video status: \(status.rawValue)")
            switch status {
            case .readyToPlay:
                DispatchQueue.main.async { [weak self] in
                    self?.state = .readyToPlay
                    self?.playStatusBlock?(.readyToPlay)
                }
            case .failed:
                DispatchQueue.main.async { [weak self] in
                    self?.stop(state: .failed)
                }
            default: break
            }
        }
    }
}

fileprivate extension ZJVideoSamplePlayView {
    
    /// 初始化播放器
    func initAvPlayer() {
        guard player == nil else { return }
        player = AVPlayer()
        player?.isMuted = isMuted
        player?.volume = volume
//        player?.automaticallyWaitsToMinimizeStalling = false
        
        playerLayer = AVPlayerLayer(player: player!)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = videoGravity
        layer.addSublayer(playerLayer!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didVideoPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didApplicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didApplicationDidEnterBackGround), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didAudioRouteChangeListener(noti:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    /// 移除播放器
    func rempveAvPlayer() {
        NotificationCenter.default.removeObserver(self)
        stop()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    /// 监听时间更新
    func addUpdateTimeObserver() {
        removeUpdateTimeObserver()
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1), timescale: 1), queue: DispatchQueue.main, using: { [weak self] cmTime in
            guard let self = self, let currentItem = self.player?.currentItem else { return }
            let durationTime = CMTimeGetSeconds(currentItem.duration)
            let currentTime = CMTimeGetSeconds(currentItem.currentTime())
            
            guard currentTime > 0 else { return }
            self.stopConnectToReplayTimer()
            if self.totalTime == 0, self.state == .readyToPlay {
                self.state = .playing
                self.playStatusBlock?(self.state)
            }
            self.totalTime = durationTime
            self.currentTime = currentTime
            self.progressBlock?(durationTime, currentTime)
        })
    }
    
    /// 移除时间监听
    func removeUpdateTimeObserver() {
        if timeObserver != nil {
            player?.removeTimeObserver(timeObserver!)
            timeObserver = nil
        }
    }
    
    /// 添加播放状态监听
    func addStatusObserver() {
        guard let player = player, let item = player.currentItem, !isStatusObserver else { return }
        isStatusObserver = true
        item.addObserver(self, forKeyPath: "status", options: [.initial, .old, .new], context: nil)
    }
    
    /// 移除播放状态监听
    func removeStatusObserver() {
        guard isStatusObserver, let player = player, let item = player.currentItem else { return }
        isStatusObserver = false
        item.removeObserver(self, forKeyPath: "status", context: nil)
    }
    
    
    /// 初始化音频播放模式
    func initAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        } catch _ {
            debugPrint("设置音频播放模式出错")
        }
    }
}

extension ZJVideoSamplePlayView {
    
    @objc func didVideoPlayToEndTime() {
        guard state != .stopped else { return }
        DispatchQueue.main.async { [weak self] in
            guard self?.isLoopPlay ?? false else {
                self?.stop(state: .end)
                return
            }
            
            self?.replay()
        }
    }
    
    @objc func didApplicationWillEnterForeground() {
        guard state == .pause, isResumeWhenForeground else { return }    //状态是暂停，且不允许后台播放时
        play()
    }
    
    @objc func didApplicationDidEnterBackGround() {
        guard AVAudioSession.sharedInstance().category != .playback else { return }
        pause()
    }
    
    @objc func didAudioRouteChangeListener(noti: Notification) {
        guard let userInfo = noti.userInfo, let routeChangeReason = userInfo[AVAudioSessionRouteChangeReasonKey] as? Int else { return }
        switch routeChangeReason {
        case kAudioSessionRouteChangeReason_OldDeviceUnavailable:
            didApplicationWillEnterForeground()
        default:break
        }
    }
}

private extension ZJVideoSamplePlayView {
    
    func connectToReplayTimer() {
        guard let _ = videoPath, currentTime == 0, reconnectTime > 0 else { return }
        stopConnectToReplayTimer()
        checkTimer = Timer.scheduledTimer(withTimeInterval: reconnectTime, repeats: false, block: { [weak self] timer in
            self?.playStatusBlock?(.reconnect)
            self?.replay()
        })
    }
    
    func startConnectToReplayTimer() {
        if Thread.isMainThread {
            connectToReplayTimer()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.connectToReplayTimer()
            }
        }
    }
    
    func stopConnectToReplayTimer() {
        guard checkTimer != nil else { return }
        if Thread.isMainThread {
            checkTimer?.invalidate()
            checkTimer = nil
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.checkTimer?.invalidate()
                self?.checkTimer = nil
            }
        }
    }
    
}

public extension ZJVideoSamplePlayView {
    
    /// 开始播放或继续播放（支持本地视频和http、https在线视频）
    /// - Parameter path: 播放路径，若无则播放上次设置的路径
    /// - Parameter options: 播放参数
    @objc func play(path: String? = nil, options: [String: Any]? = nil) {
        if let path = path, path != videoPath {
            guard path.count > 7 else {
                debugPrint("无效视频链接：\(String(describing: path))，options:\(String(describing: options))")
                playStatusBlock?(.failed)
                return
            }
            
            var url: URL? = URL(fileURLWithPath: path)
            if path.hasPrefix("http://") || path.hasPrefix("https://") {
                url = URL(string: path)
            }
            guard let uRL = url else {
                debugPrint("Videp Play: \(String(describing: path)), options:\(String(describing: options))")
                playStatusBlock?(.failed)
                return
            }
            debugPrint("Videp Play: \(String(describing: path)), options:\(String(describing: options))")
            
            videoPath = path
            videoOptions = options ?? [:]
            player?.rate = 0
            removeStatusObserver()
            removeUpdateTimeObserver()
            
            player?.replaceCurrentItem(with: AVPlayerItem(asset: AVURLAsset(url: uRL, options: videoOptions)))
            totalTime = 0
            currentTime = 0
            addStatusObserver()
            addUpdateTimeObserver()
            
            if reconnectTime > 0, options != nil {
                startConnectToReplayTimer()
            }
        } else if let _ = videoPath {
            guard state != .playing, state != .readyToPlay else { return }
            if currentTime == 0, totalTime == 0 {   //初始状态
                state = .readyToPlay
            } else {
                state = .playing
            }
        } else {
            debugPrint("Videp Play Fail: \(String(describing: path)), options:\(String(describing: options))")
            playStatusBlock?(.failed)
            return
        }
        
        debugPrint("Videp Play: \(String(describing: self.videoPath)), options:\(String(describing: self.videoOptions))")
        player?.rate = playRate
    }
    
    /// 按指定速率播放
    /// - Parameters:
    ///   - rate: 速率，正常播放为1.0
    ///   - path: 播放路径
    /// - Returns: 是否正常播放
    @objc func playRate(rate: Float, path: String? = nil, options: [String: Any]? = nil) {
        playRate = rate
        play(path: path, options: options)
    }
    
    /// 重新开始播放
    @objc func replay() {
        let videoPathT = self.videoPath
        self.videoPath = nil
        play(path: videoPathT, options: videoOptions)
    }
    
    /// 暂停播放
    @objc func pause() {
        guard state == .playing || state == .readyToPlay else { return }
        state = .pause
        player?.rate = 0
        playStatusBlock?(state)
    }
    
    /// 定位播放
    /// - Parameter time: 需要播放的时间点
    @objc func seek(_ time: Int64) {
//        guard !totalTime.isNaN, totalTime != 0 else { return }
//        guard Double(time) <= totalTime, time >= 0 else { return }
        player?.seek(to: CMTimeMake(value: time, timescale: 1), completionHandler: { success in
        })
    }
    
    /// 停止播放
    @objc func stop() {
        stop(state: .stopped)
    }
    
    fileprivate func stop(state: ZJVideoSamplePlayState) {
        debugPrint("Video stop：\(String(describing: videoPath))")
        self.state = .stopped
        stopConnectToReplayTimer()
        player?.rate = 0
        seek(0)
        removeUpdateTimeObserver()
        removeStatusObserver()
        playStatusBlock?(state)
        
        totalTime = 0
        currentTime = 0
    }
    
    /// 是否正在播放
    /// - Returns: true：正在播放或准备播放
    @objc func isPlaying() -> Bool {
        return self.state == .readyToPlay || self.state == .playing
    }
    
    /// 获取视频总时长
    /// - Returns: 视频时长
    @objc func duration() -> Float64 {
        guard let player = player, let item = player.currentItem else { return 0 }
        return CMTimeGetSeconds(item.duration)
    }
 
    /// 检测已播放链接是否和当前链接一直
    /// - Parameter videoUrl: 播放链接
    /// - Returns: true，一致
    @objc func isSameVideoUrl(_ videoUrl: String) -> Bool{
        return videoUrl == videoPath
    }
    
    /// 当前播放的视频链接
    /// - Returns: 视频链接
    @objc func videoUrl() -> String? {
        return videoPath
    }
}
