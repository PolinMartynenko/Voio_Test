# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Voio_Test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Voio_Test
pod 'GoogleAPIClientForREST/YouTube', '~> 1.2.1'
pod 'Google/SignIn', '~> 3.0.3'
pod 'SDWebImage', '~> 5.0'
pod "youtube-ios-player-helper"

pod 'Firebase'
pod 'FirebaseCore'
pod 'FirebaseAuth'
pod 'GoogleSignIn'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
