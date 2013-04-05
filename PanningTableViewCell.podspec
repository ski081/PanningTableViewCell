#
# Be sure to run `pod spec lint PanningTableViewCell.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "PanningTableViewCell"
  s.version      = "0.0.1"
  s.summary      = "A TableViewCell that implements a right swipe-to-reveal"
  s.homepage     = "https://github.com/ski081/PanningTableViewCell"
  s.license      = 'MIT (example)'
  s.author       = { "Mark Struzinski" => "ski081@gmail.com" }
  s.source       = { :git => "git@github.com:ski081/PanningTableViewCell.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'PanningTableViewCell', 'PanningTableViewCell/**/*.{h,m}'
  s.requires_arc = true
end
