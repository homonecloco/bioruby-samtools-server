require 'optparse'
#require 'sinatra/base'

$: << File.expand_path(File.dirname(__FILE__) + '/../lib')
$: << File.expand_path('.')
path=File.expand_path(File.dirname(__FILE__) + '/../lib/bio-samtools-server.rb')
$stderr.puts "Loading: #{path}"
require path


options = {}


OptionParser.new do |opts|
  opts.banner = "Usage: bam-server.rb [options]"
  
  opts.on("-r", "--reference FOLDER", "Folder with fasta files with the reference sequences. Make sure to run faidx before running bfr in parallel") do |o|
     options[:reference] = o
   end
   
   opts.on("-f", "--bam FOLDER", "Folder containing the BAM files") do |o|
     options[:folder] = o
   end   
   
end.parse!  
   
#Bio::WS::BAM.set :folder, options[:folder]
Bio::WS::BAM.run!(options)