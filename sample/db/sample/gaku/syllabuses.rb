# encoding: utf-8

syllabuses = [
	             { :name => "Introduction to Biology", :code => "B01",
                :description => "A general introduction to the world of organisms and how they function", :credits => 5 }, 
	             { :name => "Trigonometry", :code => "M401", 
                :description => "TRIANGLES!", :credits => 3 },
	             { :name => "Literature", :code => "LIT", 
                :description => "In this course you will read a series of short stories and essays by stuck up self-proclaimed writers.", :credits => 1 },
	             { :name => "Introductory Japanese[日本語入門]", :code => "NH1", 
                :description => "Learn basic moonspeak. This course covers introductions, greetings and basic questions and answers for every day life. This course also covers both sets of kana and some basic kanji.", :credits => 2 },
	             { :name => "ブルガリア語入門", :code => "BG1", 
                :description => "ブルガリアで日常生活が出来る様、挨拶や日常に使う質問と答えの仕方が学べます。ブルガリア語に使われるキリル文字の読み書きも出来る様になります。", :credits => 2},
	             { :name => "メカトロニクス", :code => "MT", 
                :description => "電子回路と電気機器とメカニカル機械を効率良く合わせてロボットの基礎や様々のデバイスや機械が作れる様になります。", :credits => 8},
	             { :name => "Атомна физика", :code => "AF1", 
                :description => "", :credits => 8},
	             { :name => "нинджи начин", :code => "NJ1", 
                :description => "Научете разнообразие от техники нинджа.Аз ще се промъкне в сенките.", :credits => 3},
                
	           ]

syllabuses.each do |syllabus|
	Gaku::Syllabus.create(syllabus)
end
