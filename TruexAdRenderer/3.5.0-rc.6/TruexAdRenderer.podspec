Pod::Spec.new do |s|
  s.name         = "TruexAdRenderer"
  s.version      = "3.5.0-rc.6"
  s.summary      = "Renderer library for true[X] interactive ads on tvOS"
  s.description  = <<-DESC
  This renderer library is for integrating true[X] interactive ads into a tvOS application. true[X] interactive ads
  offer end-users the opportunity to engage with a brand or sponsor in exchange for fewer (or no) ads in the content
  they are watching. This library specifically handles the rendering of a true[X] ad -- the ad-reduction or
  ad-elimination aspect must be implemented by the application. More information on how that should be implemented
  is available in the initial documentation provided.
                   DESC
  s.homepage     = "https://www.github.com/socialvibe"
  s.license      = { :text => "Copyright 2018 true[X]media", :type => "Copyright" }
  s.authors      = {
    "Jesse Albini" => "jesse@truex.com",
    "Simon Asselin" => "simon@truex.com",
    "Kyle Lam" => "kyle@truex.com"
  }
 
  s.tvos.deployment_target = "10.0"
 
  s.source              = { :http => "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v#{s.version}.zip" }
  s.source_files        = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.public_header_files = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.vendored_frameworks = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework"
  s.resource_bundles = {
    'Truex' => ["TruexAdRenderer-tvOS-v#{s.version}/Assets/*.png"]
  }
 
  s.dependency 'YouiTVAdRenderer', '~> 1.1.1'
  s.dependency 'InnovidAdRenderer', '1.3.11'
  s.dependency 'SDWebImage', '~> 4.2.3'
  s.dependency 'OptimizelySDKTVOS', '1.1.9'
end
 
