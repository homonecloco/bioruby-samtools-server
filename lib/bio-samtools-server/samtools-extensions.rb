class Bio::DB::Fasta::Region
	def to_wig(opts={})
		step_size = opts[:step_size] ? opts[:step_size] : 1
		
		out = StringIO.new
		#fixedStep chrom=chr3 start=400601 step=100 span=5
		out << "fixedStep chrom=#{self.entry} start=#{self.start} step=#{step_size} span=#{step_size}\n"
		return out.string if self.pileup.size == 0
		current_start = self.pileup[0].pos
		current_acc = 0.0
		current_end = current_start + step_size

		self.pileup.each do |pile|

			if pile.pos >= current_end
				#out << current_start << " " << (current_acc/step_size).to_s << "\n"
				out << (current_acc/step_size).to_s << "\n"
				current_start = pile.pos
				current_acc = 0.0
				current_end = current_start + step_size
			end
			current_acc += pile.coverage

		end
		out.string
	end
end