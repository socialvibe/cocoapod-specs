  #
  #  Be sure to run `pod spec lint TruexAdRenderer-tvOS.podspec' to ensure this is a
  #  valid spec and to remove all comments including this before submitting the spec.
  #
  #  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
  #  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
  #

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TruexAdRenderer"
  s.version      = "3.0.4"
  s.summary      = "Renderer library for true[X] interactive ads on tvOS"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  This renderer library is for integrating true[X] interactive ads into a tvOS application. true[X] interactive ads
  offer end-users the opportunity to engage with a brand or sponsor in exchange for fewer (or no) ads in the content
  they are watching. This library specifically handles the rendering of a true[X] ad -- the ad-reduction or
  ad-elimination aspect must be implemented by the application. More information on how that should be implemented
  is available in the initial documentation provided.
                   DESC

  s.homepage     = "https://www.github.com/socialvibe"
  s.license      = {
    "text": "Copyright 2017 true[X]media",
    "type": "Copyright"
  }

  s.author             = { "Jesse Albini" => "jesse@truex.com" }
  s.tvos.deployment_target = "10.0"
  s.source       = { :http => "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v3.0.4_alpha.zip" }

  # s.source_files  = "TruexAdRenderer.framework/Headers/*.h"
  # s.public_header_files = "TruexAdRenderer.framework/Headers/*.h"

  # s.dependency 'Innovid', '1.0.1'
  s.vendored_frameworks = "TruexAdRenderer-tvOS-v3.0.4_alpha/TruexAdRenderer.framework"

end
