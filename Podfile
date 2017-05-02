source "https://github.com/CocoaPods/Specs"
platform :ios, "10.3"
use_frameworks!

def shared_pods
  pod 'GoogleMaps'
  pod 'GooglePlaces'

end

target 'Test' do
	shared_pods

end

target 'TestTests' do

end

target 'TestUITests' do
    pod 'GoogleMaps'
    pod 'GooglePlaces'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '3.1'
		end
	end
end
