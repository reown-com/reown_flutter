#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint reown_yttrium_utils.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'reown_yttrium_utils'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'reown_yttrium_utils/Sources/reown_yttrium_utils/**/*.swift'
  s.dependency 'Flutter'
  # Keep in step with the Yttrium version in reown_yttrium_utils/Package.swift.
  s.dependency 'YttriumUtilsWrapper', '0.10.59'
  # For local development, comment out version constraint
  #s.dependency 'YttriumUtilsWrapper'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # The same privacy manifest Swift Package Manager bundles. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  s.resource_bundles = {'reown_yttrium_utils_privacy' => ['reown_yttrium_utils/Sources/reown_yttrium_utils/PrivacyInfo.xcprivacy']}
end