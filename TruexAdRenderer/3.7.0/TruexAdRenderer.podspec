Pod::Spec.new do |s|
  XCODE_VERSION_MAJOR=%x( xcodebuild -version |  grep -i -E "^xcode [\-beta\ ]*[0-9]+\.[0-9]+" | head -1 | sed "s/[^0-9\.]//g" | cut -d'.' -f1 | tr -d '\n' )
  XCODE_VERSION_MINOR=%x( xcodebuild -version |  grep -i -E "^xcode [\-beta\ ]*[0-9]+\.[0-9]+" | head -1 | sed "s/[^0-9\.]//g" | cut -d'.' -f2 | tr -d '\n' )
  XCODE_VERSION = "xcode#{XCODE_VERSION_MAJOR}_#{XCODE_VERSION_MINOR}"
  if(XCODE_VERSION != 'xcode10_1' and XCODE_VERSION != 'xcode10_2')
      print('Unable to determine Xcode version. Defaulting to Xcode 10.2')
      XCODE_VERSION = 'xcode10_2'
  end
  XCODE_VERSION_OVERRIDE = %x( echo $TX_XCODE ).to_s.strip
  unless XCODE_VERSION_OVERRIDE.empty?
      print("Overriding Xcode version to #{XCODE_VERSION_OVERRIDE}")
      XCODE_VERSION = XCODE_VERSION_OVERRIDE
  end

  s.name         = "TruexAdRenderer"
  s.version      = "3.7.0"
  s.summary      = "Renderer library for true[X] interactive ads on tvOS"
  s.description  = <<-DESC
  This renderer library is for integrating true[X] interactive ads into a tvOS application. true[X] interactive ads
  offer end-users the opportunity to engage with a brand or sponsor in exchange for fewer (or no) ads in the content
  they are watching. This library specifically handles the rendering of a true[X] ad -- the ad-reduction or
  ad-elimination aspect must be implemented by the application. More information on how that should be implemented
  is available in the initial documentation provided.
                   DESC
  s.homepage     = "https://www.github.com/socialvibe"
  s.license      = { :text => "Copyright 2019 true[X]media", :type => "Copyright" }
  s.authors      = {
    "Jesse Albini" => "jesse@truex.com",
    "Simon Asselin" => "simon@truex.com",
    "Kyle Lam" => "kyle@truex.com"
  }

  s.tvos.deployment_target = "10.0"

  s.source              = { :http => "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v#{s.version}-#{XCODE_VERSION}.zip" }
  s.source_files        = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.public_header_files = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.vendored_frameworks = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework"
  s.resource_bundles = {
    'Truex' => ["TruexAdRenderer-tvOS-v#{s.version}/Assets/*.png"]
  }

  s.dependency 'YouiTVAdRenderer', '~> 1.1.1'
  s.dependency "InnovidAdRenderer_#{XCODE_VERSION}", '1.4.5'
  s.dependency 'SDWebImage', '~> 4.2.3'
  s.dependency 'OptimizelySDKTVOS', '~> 3.0'
  s.dependency 'PusherSwift', '>= 5.1', '<= 6.1'
  s.dependency 'TVOS360Video', '1.1.3'
end
