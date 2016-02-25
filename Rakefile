require 'net/http'
require 'uri'

desc '正字俗字辞書を取得・生成する'
task :build do
  uri = URI 'https://raw.githubusercontent.com/ne-sachirou/c4se-web/master/lib/SeiJi/%E6%96%B0%E5%AD%97%E8%88%8A%E5%AD%97%E5%B0%8D%E7%85%A7%E8%A1%A8.txt'
  res = Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
    req = Net::HTTP::Get.new uri
    http.request req
  end
  dic = res.body.force_encoding('utf-8').sub(/\A---.+?^---\n/m, '').gsub(/\s*#.*$/, '').gsub(/^\n/, '')
  File.open('dictionary/translation.dic', 'w:utf-8') {|f| f.write dic.each_line.select{|line| line.length == 4 }.join('') }
  File.open('dictionary/proposition.dic', 'w:utf-8') {|f| f.write dic.each_line.select{|line| line.length > 4 }.join('') }
end
