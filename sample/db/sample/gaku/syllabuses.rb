# encoding: utf-8

syllabuses = [
	             { :name => "Biology Syllabus", :code => "S1" }, 
	             { :name => "Math Syllabus", :code => "S2" },
	             { :name => "Literature Syllabus", :code => "S3" },
	             { :name => "日本語", :code => "NH" },
	             { :name => "メカトロニクス", :code => "MT" }
	           ]

syllabuses.each do |syllabus|
	Gaku::Syllabus.create(syllabus)
end