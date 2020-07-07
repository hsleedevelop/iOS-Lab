source "https://cdn.cocoapods.org/"

install! 'cocoapods', :generate_multiple_pod_projects => true, incremental_installation: true

platform :ios, '13.0'
use_frameworks! :linkage => :static
#use_modular_headers!

def podsForUmbrella
  # API Helper
#  pod 'AFNetworking',             '~> 3.2.1'
#  pod 'Alamofire',                '~> 5.0.5'
#  pod 'SDWebImage',               '~> 5.1.1'
#  pod 'Arrow',                    '~> 5.0.0'    #JSON Parsing Library for Swift that infers type
#  pod 'RxKingfisher',             '~> 1.0.0'
#
#  # Keychain
#  pod 'SAMKeychain',              '~> 1.5.3'

  # RX
  # pod 'RxSwift',                  '~> 5.1.1'
  # pod 'RxCocoa',                  '~> 5.1.1'
  # pod 'RxRelay',                  '~> 5.1.1'

  # DI
  # pod 'Swinject',                 '~> 2.7.1'
end

workspace 'Cardoc'

project 'Cardoc.xcodeproj'

target 'Cardoc' do
    pod 'Firebase',                 '~> 6.4.0'

    target 'CardocTests' do
        inherit! :search_paths
    end
end

target 'CardocUmbrella' do
    project 'CardocUmbrella/CardocUmbrella'

    podsForUmbrella
    #   pod 'RxSwift'
    #   pod 'RxRelay'
    #   pod 'RxCocoa'
    #   pod 'SwiftGRPC'

    target 'CardocTestsUmbrella' do
        inherit! :search_paths
        pod 'RxTest',                  '~> 5.1.1'
    end
end


 post_install do |installer|
   work_dir = Dir.pwd
   installer.aggregate_targets.each do |target|
     target.user_build_configurations.each do |key, name|
       xcconfig_filename = "#{work_dir}/Pods/Target Support Files/#{target}/#{target}.#{name}.xcconfig"
       xcconfig = File.read(xcconfig_filename)
       framework_search_paths = xcconfig.match(/(?<=FRAMEWORK_SEARCH_PATHS = )(.*)/)
       header_search_paths = xcconfig.match(/(?<=HEADER_SEARCH_PATHS = )(.*)/)
       other_ldflags = xcconfig.match(/(?<=OTHER_LDFLAGS = )(.*)/)

       # use these PODS prefix variables to override in xcconfig if frameworks are implicitly linked
       File.open(xcconfig_filename, "a") do |file|
         file.puts("PODS_FRAMEWORK_SEARCH_PATHS = #{framework_search_paths}")
         file.puts("PODS_HEADER_SEARCH_PATHS = #{header_search_paths}")
         file.puts("PODS_OTHER_LDFLAGS = #{other_ldflags}")
       end
     end
   end
 end
