require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'

module Bio::WS
  class BAM < Sinatra::Base
    
    def initialize(app = nil, params = {})
      super(app)
      @bootstrap = params.fetch(:bootstrap, false)
      @bam_files = Hash.new
    end
    
    def get_bam(bam,reference)
      return @bam_files[bam] if @bam_files[bam] 
      
      bam_path = "#{self.settings.folder.to_s}/#{bam}.bam"
      reference_path =  "#{self.settings.reference.to_s}/#{reference}"
      return nil unless File.file?(bam_path)
      @bam_files[bam] = Bio::DB::Sam.new( 
          :fasta =>  reference_path,
          :bam => bam_path
      )
      
      return @bam_files[bam] 
    end
      
    get '/region' do
      folder = settings.folder.to_s
      
      bam = params[:bam]
      region = params[:region]
      ref = params[:ref]
      
#      "Hello World from MyApp in separate file! #{ self.settings.folder.to_s} #{bam} #{region}"
      #self.settings.folder.to_s
      stream do |out|
        get_bam(bam, ref).fetch("chr_1", 10,1000) do |sam|
          # test that all the objects are Bio::DB::Alignment objects
          #assert_equal(sam.class, Bio::DB::Alignment)
          #assert_equal(sam.rname, "chr_1")
          out << "#{sam.sam_string}\n"
        end
      end
    end
  
    get '/list' do
       bam = params[:bam]
       ref = params[:ref]
       stream do |out|
         get_bam(bam, ref).each_region do |reg|
           puts reg
          out <<  "#{reg.to_s}\n"
         end
       end
       
    end
    
  end
end
