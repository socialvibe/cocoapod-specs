Pod::Spec.new do |s|
  s.name         = "TruexAdRenderer-iOS"
  s.module_name  = "TruexAdRenderer"
  s.version      = "3.4.0"
  s.summary      = "Renderer library for true[X] interactive ads on iOS"
  s.description  = <<-DESC
  This renderer library is for integrating true[X] interactive ads into an iOS application. true[X] interactive ads
  offer end-users the opportunity to engage with a brand or sponsor in exchange for fewer (or no) ads in the content
  they are watching. This library specifically handles the rendering of a true[X] ad -- the ad-reduction or
  ad-elimination aspect must be implemented by the application. More information on how that should be implemented
  is available in the initial documentation provided.
                   DESC
  s.homepage     = "https://www.github.com/socialvibe"
  s.license      = { :text => "Copyright 2023 true[X]media", :type => "Copyright" }
  s.authors      = {
    "Jesse Albini" => "jesse@truex.com",
    "Kyle Lam" => "kyle@truex.com",
  }

  s.platform = :ios
  s.ios.deployment_target = "12.0"

  s.source = { :http => "https://stash.truex.com/integration/TruexAdRenderer-iOS-v#{s.version}.zip" }
  s.vendored_frameworks = "TruexAdRenderer.xcframework"
end
