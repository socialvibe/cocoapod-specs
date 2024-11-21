
# Gives a podspec that points to the project source tree. Use in client apps as:
# pod "TruexAdRendererSource", :path => "../TruexAdRenderer-tvOS"

Pod::Spec.new do |s|
  # Always verbose for local builds
  #VERBOSE_LOGS = %x( echo $TRUEX_VERBOSE_LOGS ).strip == 'YES'
  VERBOSE_LOGS = true

  log = -> (message) {
    if VERBOSE_LOGS
        puts "[TruexAdRenderer] #{message}"
    end
  }

  # We track which Xcode we are using to a) decide with Innovid pod to use, and b) to also label our
  # hosted xcframework .zip, in case we need to have multiple Xcode builds.
  XCODE_RUNNING_VERSION = %x( xcodebuild -version |  grep -i "^xcode" | head -1 | sed "s/[^0-9.]//g" | tr -d '\n' )
  log.("running in Xcode #{XCODE_RUNNING_VERSION}")

  VERSION_PARTS = XCODE_RUNNING_VERSION.split('.')
  XCODE_MAJOR = VERSION_PARTS[0].to_i
  XCODE_MINOR = VERSION_PARTS[1].to_i

  # Map some known cases to the same hosted xcode build
  # By default we use the unspecified fallback build.
  xcode_build_version = ''
  if XCODE_MAJOR == 11 && XCODE_MINOR <= 2
    xcode_build_version = 'xcode11.2.1'
  elsif XCODE_MAJOR == 11 && XCODE_MINOR == 3
    xcode_build_version = 'xcode11.3.0'
  elsif XCODE_MAJOR == 11 && XCODE_MINOR >= 4
    xcode_build_version = 'xcode11.4.0'
  elsif XCODE_MAJOR == 12 && XCODE_MINOR < 5
    xcode_build_version = 'xcode12.0.0'
  end
  log.("using Xcode build version '#{xcode_build_version}'")

  s.name         = 'TruexAdRendererSource'
  s.module_name  = 'TruexAdRenderer'
  s.version      = '3.12.0'
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
  if XCODE_MAJOR <= 11
    s.tvos.deployment_target = '10.0'
  else
    s.tvos.deployment_target = '13.0'
  end

  s.source              = { :path => '.' }
  s.source_files        = 'TruexAdRenderer/**/*.{h,m}'
  s.resources           = [
    'TruexAdRenderer/Assets/Footer/*.png',
    'TruexAdRenderer/Assets/Player/*.png',
    'TruexAdRenderer/Assets/TruexTvmlCore.js',
    'TruexAdRenderer/Assets/TruexTrueTargetingCore.js',
    'TruexAdRenderer/Assets/TVML/*.tvml',
    'TruexAdRenderer/**/*.storyboard'
  ]

  s.dependency "InnovidAdRendererFramework", '~> 1.7.0'
  s.dependency 'SDWebImage', '~> 5.19.2'
  s.dependency 'PusherSwift', '8.0'
end