use_frameworks!

def shared_pods
  pod 'DiningStack', :git => 'https://github.com/cuappdev/DiningStack.git', :branch => 'master'
end

target 'Eatery' do
  platform :ios, '8.0'
  pod 'DGElasticPullToRefresh', :git => 'https://github.com/dantheli/DGElasticPullToRefresh.git'
  pod 'Analytics/Segmentio'
  pod 'Tweaks'
  pod 'HanekeSwift'
  shared_pods
end

target 'Today Extension' do
  platform :ios, '8.0'
  shared_pods
end

target 'Eatery Watch App' do
  platform :watchos, '2.0'
  shared_pods
end

target 'Eatery Watch App Extension' do
  platform :watchos, '2.0'
  shared_pods
end
