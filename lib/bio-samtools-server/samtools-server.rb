require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'

module Bio::WS
  class BAM < Sinatra::Base
    
    configure do
      mime_type :js, 'text/javascript'
    end

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
      
    get '/biojs/*' do
      file=params[:splat]
      biojs_path = "#{self.settings.biojs.to_s}"
      puts "loading!: #{biojs_path}"
      if file and file.last.end_with?(".js")
        content_type :js 
      end
      File.read(File.join(biojs_path, file))
    end
      
    get '/*/*/alignment' do |ref, bam|
      region = params[:region]
      reg = Bio::DB::Fasta::Region.parse_region(region)
      stream do |out|
        get_bam(bam, ref).fetch(reg.entry, reg.start, reg.end) do |sam|
          out << "#{sam.sam_string}\n"
        end
      end
    end

    get '/*/*/wig' do |ref, bam|
      step_size = 1
      step_size = params[:step_size].to_i if params[:step_size]
      region = params[:region]
      step_size = 1 if step_size < 1
      reg = Bio::DB::Fasta::Region.parse_region(region)
      stream do |out|
         pile_region = get_bam(bam, ref).fetch_region({:region=>reg}) 
         out << pile_region.to_wig({:step_size=>step_size})
      end
    end

    get '/*/*/reference' do |ref, bam|
      region = params[:region]
      reg = Bio::DB::Fasta::Region.parse_region(region)
      stream do |out|
         ref = get_bam(bam, ref).fetch_reference(reg.entry, reg.start, reg.end)
          out << "#{ref}\n"
       end
      
    end
  
    get '/*/*/list' do |ref, bam|
       stream do |out|
         get_bam(bam, ref).each_region do |reg|
          out <<  "#{reg.to_s}\n"
         end
       end
    end
    
  end
end
