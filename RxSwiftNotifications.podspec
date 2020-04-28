Pod::Spec.new do |s|

    s.name         = "RxSwiftNotifications"
    s.version      = "0.0.1"
    s.platform = :ios
    s.ios.deployment_target = '10.0'
    s.requires_arc = true
    s.summary      = "A small group of extensions on top of NSNotification center and RxSwift that allows for strong-typed notifications"
    s.description  = <<-DESC
    Have strong-typed notifications and parameters. Easyly register listeners and access the parameters of the notification with no boilerplate code. Transform the notification in a rx observavble to react to it in a seamless way.
    DESC
    s.homepage     = "https://github.com/leandromperez/rxswift-notifications"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "Leandro Perez" => "leandromperez@gmail.com" }
    s.social_media_url   = "https://medium.com/@leandromperez"
    s.source       = { :git => "https://github.com/leandromperez/rxswift-notifications.git", :tag => "#{s.version}" }
    s.source_files = 'RxSwiftNotifications/Classes/**/*'

    # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.framework = "UIKit"

    # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.swift_version = "5.0"
    s.framework = "UIKit"
    s.dependency "RxSwift", "~> 5.0"
    s.dependency "RxCocoa", "~> 5.0"

end
