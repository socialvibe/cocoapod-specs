Pod::Spec.new do |s|
  verbose_logs = false

  debug_log_lambda = -> (message) {
    # only log if verbose-mode enabled
    if verbose_logs
        puts "[TruexAdRenderer] #{message}"
    end
  }

  # this is an environment variable you can set export TRUEX_VERBOSE_LOGS=YES
  truex_verbose_flag = %x( echo $TRUEX_VERBOSE_LOGS )
  verbose_logs = truex_verbose_flag.strip == 'YES'
  debug_log_lambda.call("Using verbose logs: #{verbose_logs}")

  xcode_version_major=%x( xcodebuild -version |  grep -i -E "^xcode [\-beta\ ]*[0-9]+\.[0-9]+" | head -1 | sed "s/[^0-9\.]//g" | cut -d'.' -f1 | tr -d '\n' ) unless defined? XCODE_VERSION_MAJOR
  xcode_version_minor=%x( xcodebuild -version |  grep -i -E "^xcode [\-beta\ ]*[0-9]+\.[0-9]+" | head -1 | sed "s/[^0-9\.]//g" | cut -d'.' -f2 | tr -d '\n' ) unless defined? XCODE_VERSION_MINOR
  xcode_version = "xcode#{xcode_version_major}.#{xcode_version_minor}"
  debug_log_lambda.call("Found XCODE_VERSION: #{xcode_version}")
  if(xcode_version_major.to_i == 11 && xcode_version_minor.to_i <= 2)
    xcode_version = 'xcode11.2.1'
  elsif(xcode_version_major.to_i == 11 && xcode_version_minor.to_i == 3)
    xcode_version = 'xcode11.3.0'
  elsif(xcode_version_major.to_i == 11 && xcode_version_minor.to_i >= 4)
    xcode_version = 'xcode11.4.0'
  elsif(xcode_version_major.to_i == 12 && xcode_version_minor.to_i == 0)
    xcode_version = 'xcode12.0.0'
  else
    debug_log_lambda.call('Unhandled Xcode version. Defaulting to Xcode 12.0.0')
    xcode_version = 'xcode12.0.0'
  end

  # this is an environment variable you can set export LEGACY_BUILD_SYSTEM_ENABLED=YES
  legacy_build_system_flag = %x( echo $LEGACY_BUILD_SYSTEM_ENABLED )
  legacy_build_system_enabled = legacy_build_system_flag.strip == 'YES'
  debug_log_lambda.call("Using Xcode legacy build system: #{legacy_build_system_enabled}")

  xcode_version_override = ""
  xcode_version_override = %x( echo $TX_XCODE ).to_s.strip unless defined? xcode_version_override
  unless xcode_version_override.empty?
    xcode_version = xcode_version_override
    xcode_version_major = xcode_version.gsub('xcode', '').split('.')[0]
    debug_log_lambda.call("Overriding Xcode version to #{xcode_version_override}")
    debug_log_lambda.call("Overriding Xcode major version to #{xcode_version_major}")
  end

  s.name         = 'TruexAdRenderer'
  s.module_name  = 'TruexAdRenderer'
  s.version      = '3.9.13'
  s.summary      = 'Renderer library for TrueX interactive ads on tvOS'
  s.description  = <<-DESC
  This renderer library is for integrating TrueX interactive ads into a tvOS application. TrueX interactive ads
  offer end-users the opportunity to engage with a brand or sponsor in exchange for fewer (or no) ads in the content
  they are watching. This library specifically handles the rendering of a TrueX ad -- the ad-reduction or
  ad-elimination aspect must be implemented by the application. More information on how that should be implemented
  is available in the initial documentation provided.
                   DESC
  s.homepage     = 'https://www.github.com/socialvibe'
  s.license      = { :text => 'Copyright 2022 Infillion', :type => 'Copyright' }
  s.authors      = {
    'Jesse Albini' => 'jesse.albini@infillion.com',
    'Simon Asselin' => 'simon.asselin@infillion.com',
    'Kyle Lam' => 'kyle.lam@infillion.com',
    'Isaiah Mann' => 'isaiah.mann@infillion.com'
  }

  if(xcode_version_major.to_i <= 11 || legacy_build_system_enabled)
    s.tvos.deployment_target = '10.0'
  else
    s.tvos.deployment_target = '13.0'
  end

  if(xcode_version_major.to_i > 11 && legacy_build_system_enabled)
    # legacy build system does not support Innovid Xcode 12+
    innovid_xcode_version = 'xcode11.4.0'
  else
    innovid_xcode_version = xcode_version
  end

  s.source              = { :http => "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v#{s.version}-#{xcode_version}.zip" }
  s.source_files        = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.public_header_files = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework/Headers/*.h"
  s.vendored_frameworks = "TruexAdRenderer-tvOS-v#{s.version}/TruexAdRenderer.framework"
  s.resource_bundles = {
    'Truex' => ["TruexAdRenderer-tvOS-v#{s.version}/Assets/*.png"]
  }

  s.dependency "InnovidAdRenderer_#{innovid_xcode_version}", '1.6.0'
  s.dependency 'SDWebImage', '~> 4.4.0'
  s.dependency 'PusherSwift', '8.0'
  s.dependency 'TVOS360Video', '1.1.3'

end
