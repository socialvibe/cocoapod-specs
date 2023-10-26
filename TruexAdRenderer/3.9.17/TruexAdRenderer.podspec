Pod::Spec.new do |s|
  # this is an environment variable you can set export TRUEX_VERBOSE_LOGS=YES
  truex_verbose_flag = %x( echo $TRUEX_VERBOSE_LOGS )
  verbose_logs = truex_verbose_flag.strip == 'YES'

  log = -> (message) {
    # only log if verbose-mode enabled
    if verbose_logs
        puts "[TruexAdRenderer] #{message}"
    end
  }

  xcode_version_raw = %x( xcodebuild -version |  grep -i "^xcode" | head -1 | sed "s/[^0-9.]//g" )
  xcode_version_parts = xcode_version_raw.split('.')
  xcode_version_major = xcode_version_parts[0].to_i
  xcode_version_minor = xcode_version_parts[1].to_i
  xcode_version = "xcode#{xcode_version_major}.#{xcode_version_minor}"
  log.call("running in Xcode #{xcode_version}")

  # this is an environment variable you can set export LEGACY_BUILD_SYSTEM_ENABLED=YES
  legacy_build_system_flag = %x( echo $LEGACY_BUILD_SYSTEM_ENABLED )
  legacy_build_system_enabled = legacy_build_system_flag.strip == 'YES'
  if legacy_build_system_enabled
    log.call("Using Xcode legacy build system: #{legacy_build_system_enabled}")
  end

  s.name         = 'TruexAdRenderer'
  s.module_name  = 'TruexAdRenderer'
  s.version      = '3.9.17'
  s.summary      = 'Renderer library for TrueX interactive ads on tvOS'
  s.description  = <<-DESC
  This renderer library is for integrating TrueX interactive ads into a tvOS application. TrueX interactive ads
  offer end-users the opportunity to engage with a brand or sponsor in exchange for fewer (or no) ads in the content
  they are watching. This library specifically handles the rendering of a TrueX ad -- the ad-reduction or
  ad-elimination aspect must be implemented by the application. More information on how that should be implemented
  is available in the initial documentation provided.
                   DESC
  s.homepage     = 'https://www.github.com/socialvibe'
  s.license      = { :text => 'Copyright 2023 Infillion', :type => 'Copyright' }
  s.authors      = {
    'Jesse Albini' => 'jesse.albini@infillion.com',
    'Simon Asselin' => 'simon.asselin@infillion.com',
    'Kyle Lam' => 'kyle.lam@infillion.com',
    'Isaiah Mann' => 'isaiah.mann@infillion.com'
  }

  s.platform = :tvos
  if(xcode_version_major <= 11 || legacy_build_system_enabled)
    s.tvos.deployment_target = '10.0'
  else
    s.tvos.deployment_target = '13.0'
  end

  lib_url = "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v#{s.version}.zip"
  log.call("#{s.name} lib url: #{lib_url}")
  s.source = { :http => lib_url }
  s.vendored_frameworks = "TruexAdRenderer.xcframework"

  # Not sure the bundle is needed, the .pngs are present on their own it seems
#  s.resource_bundles = {
#    'Truex' => ["TruexAdRenderer-tvOS-v#{s.version}/Assets/*.png"]
#  }

  innovid_xcode_version = "xcode12.0.0"
  if(xcode_version_major >= 13 || xcode_version_major == 12 && xcode_version_minor >= 5)
    innovid_xcode_version = "xcode12.5.1"
  elsif(xcode_version_major > 11 && legacy_build_system_enabled)
    # legacy build system does not support Innovid Xcode 12+
    innovid_xcode_version = 'xcode11.4.0'
  end
  log.call("using InnovidRenderer_#{innovid_xcode_version}")
  s.dependency "InnovidAdRenderer_#{innovid_xcode_version}", '~> 1.6.0'

  s.dependency 'SDWebImage', '~> 4.4.0'
  s.dependency 'PusherSwift', '8.0'
  s.dependency 'TVOS360Video', '1.1.3'
end
