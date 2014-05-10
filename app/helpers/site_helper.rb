#encoding:utf-8
module SiteHelper

	Letters = %w(A、 B、 C、 D、)

	def to_label(index,q)
		"#{index + 1}、 #{q}"
	end

	def to_collections(data_arrry)
		res = []

		data_arrry.each_with_index do |item,index|
			#res << [Letters[index]+item,index]
			res << [item,index]
		end
		res
	end
end
