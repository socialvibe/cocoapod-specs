Pod::Spec.new do |s|
  XCODE_VERSION_MAJOR=%x( xcodebuild -version |  grep -i -E "^xcode [\-beta\ ]*[0-9]+\.[0-9]+" | head -1 | sed "s/[^0-9\.]//g" | cut -d'.' -f1 | tr -d '\n' ) unless defined? XCODE_VERSION_MAJOR
  XCODE_VERSION_MINOR=%x( xcodebuild -version |  grep -i -E "^xcode [\-beta\ ]*[0-9]+\.[0-9]+" | head -1 | sed "s/[^0-9\.]//g" | cut -d'.' -f2 | tr -d '\n' ) unless defined? XCODE_VERSION_MINOR
  xcode_version = "xcode#{XCODE_VERSION_MAJOR}.#{XCODE_VERSION_MINOR}.0"
  puts "Found XCODE_VERSION: #{xcode_version}"
  if(XCODE_VERSION_MAJOR.to_i == 10 && XCODE_VERSION_MINOR.to_i <= 1) 
    xcode_version = 'xcode10.1.0'
  elsif(XCODE_VERSION_MAJOR.to_i == 10 && XCODE_VERSION_MINOR.to_i == 2)
    xcode_version = 'xcode10.2.0'
  elsif(XCODE_VERSION_MAJOR.to_i == 10 && XCODE_VERSION_MINOR.to_i >= 3)
    xcode_version = 'xcode10.3.0'
  elsif(XCODE_VERSION_MAJOR.to_i == 11 && XCODE_VERSION_MINOR.to_i < 2)
    xcode_version = 'xcode11.0.0'
  elsif(XCODE_VERSION_MAJOR.to_i == 11 && XCODE_VERSION_MINOR.to_i == 2)
    xcode_version = 'xcode11.2.1'
  elsif(XCODE_VERSION_MAJOR.to_i == 11 && XCODE_VERSION_MINOR.to_i == 3)
    xcode_version = 'xcode11.3.0'
  elsif(XCODE_VERSION_MAJOR.to_i == 11 && XCODE_VERSION_MINOR.to_i >= 4)
    xcode_version = 'xcode11.4.0'
  elsif(XCODE_VERSION_MAJOR.to_i == 12 && XCODE_VERSION_MINOR.to_i == 0)
    xcode_version = 'xcode12.0.0'
  else 
    puts 'Unhandled Xcode version. Defaulting to Xcode 12.0.0'
    xcode_version = 'xcode12.0.0'
  end

  XCODE_VERSION_OVERRIDE = %x( echo $TX_XCODE ).to_s.strip unless defined? XCODE_VERSION_OVERRIDE
  unless XCODE_VERSION_OVERRIDE.empty?
      puts "Overriding Xcode version to #{XCODE_VERSION_OVERRIDE}"
      xcode_version = XCODE_VERSION_OVERRIDE
  end

  pusher_version = '5.1.1'
  if(XCODE_VERSION_MAJOR.to_i >= 11)
    pusher_version = '7.2'
  end

  s.name         = "TruexAdRenderer"
  s.version      = "3.9.8"
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

  if(XCODE_VERSION_MAJOR.to_i <= 11)
    s.tvos.deployment_target = "10.0"
  else
    s.tvos.deployment_target = "13.0"
  end

  s.source              = { :http => "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v#{s.version}-#{xcode_version}.zip" }
  s.source_files        = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.public_header_files = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.vendored_frameworks = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework"
  s.resource_bundles = {
    'Truex' => ["TruexAdRenderer-tvOS-v#{s.version}/Assets/*.png"]
  }

  s.dependency "InnovidAdRenderer_#{xcode_version}", '1.5.34'
  s.dependency 'SDWebImage', '4.2.3'
  s.dependency 'PusherSwift', "#{pusher_version}"
  s.dependency 'TVOS360Video', '1.1.3'
end
