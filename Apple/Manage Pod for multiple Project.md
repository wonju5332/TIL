```
# Uncomment this line to define a global platform for your project
platform :ios, '8.2'
# Uncomment this line if you're using Swift
use_frameworks!

# Define main pods.
def main_pods

    #your main pods
    pod 'AwesomeCache', '~> 5.0'
    pod 'DZNEmptyDataSet', '1.8.1'


end

# Your FirstProjectName.
target 'FirstProyectName' do

    main_pods
    #here you can add any other for this specific project
    pod 'Branch'

end

# Your SecondProjectName.
target 'SecondProjectName' do

    main_pods
    #here you can add any other for this specific project
    pod 'Alamofire'
    pod 'Fabric'
    pod 'Crashlitycs'

end

target 'FirstProjectTestName' do

end

target 'FirstProjectTestUIName' do

end

post_install do |installer|
        puts("Update debug pod settings to speed up build time")
        Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
            File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
        end
    end
end
```

* 핵심은 target 프로젝트를 구분하고, pod 설치하는 것
* 알아봐야할 부분은, 공통된 라이브러리의 경우는 어떻게 처리할 것인가..
