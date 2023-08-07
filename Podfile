# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'HealthDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HealthDemo
  pod 'Masonry'
  pod 'WCDB.objc','~> 2.0.2.5'
  pod 'MJRefresh'
  pod 'LookinServer', :configurations => ['Debug']
  
  target 'HealthDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HealthDemoUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
