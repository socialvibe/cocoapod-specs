Pod::Spec.new do |s|
  # this is an environment variable you can set export TRUEX_VERBOSE_LOGS=YES
  VERBOSE_LOGS = %x( echo $TRUEX_VERBOSE_LOGS ).strip == 'YES'
  #VERBOSE_LOGS = true

  log = -> (message) {
    if VERBOSE_LOGS
        puts "[TruexAdRenderer] #{message}"
    end
  }

  s.name         = 'TruexAdRenderer'
  s.module_name  = 'TruexAdRenderer'
  s.version      = '3.15.3'
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
  s.tvos.deployment_target = '13.0'

  lib_url = "https://stash.truex.com/integration/TruexAdRenderer-tvOS-v#{s.version}-cocoapods.zip"
  log.("#{s.name} lib url: #{lib_url}")
  s.source = { :http => lib_url }
  s.vendored_frameworks = "TruexAdRenderer.xcframework"

  s.dependency "InnovidAdRendererFramework", '~> 1.7.40'
end
