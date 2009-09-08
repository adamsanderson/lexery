# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{lexery}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Sanderson"]
  s.date = %q{2009-09-07}
  s.default_executable = %q{lexery}
  s.description = %q{      An enteraining word game
}
  s.email = %q{netghost@gmail.com}
  s.executables = ["lexery"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    "fonts/MuseoSans_500.otf",
     "fonts/license_agreement.rtf",
     "images/cursor.png",
     "lib/exuberant/abstract_screen.rb",
     "lib/exuberant/button.rb",
     "lib/exuberant/colored.rb",
     "lib/exuberant/container.rb",
     "lib/exuberant/exuberant_game.rb",
     "lib/exuberant/fade.rb",
     "lib/exuberant/game_window.rb",
     "lib/exuberant/gosu_support.rb",
     "lib/exuberant/label.rb",
     "lib/exuberant/move.rb",
     "lib/exuberant/multi_transition.rb",
     "lib/exuberant/positioned.rb",
     "lib/exuberant/publisher.rb",
     "lib/exuberant/support.rb",
     "lib/exuberant/timer.rb",
     "lib/exuberant/transition.rb",
     "lib/lexery.rb",
     "lib/lexery/colors.rb",
     "lib/lexery/dictionary.rb",
     "lib/lexery/fading_message.rb",
     "lib/lexery/fps_counter.rb",
     "lib/lexery/game.rb",
     "lib/lexery/game_over_screen.rb",
     "lib/lexery/game_rules.rb",
     "lib/lexery/game_screen.rb",
     "lib/lexery/layers.rb",
     "lib/lexery/round.rb",
     "lib/lexery/score_board.rb",
     "lib/lexery/stats_screen.rb",
     "lib/lexery/title_screen.rb",
     "lib/lexery/word_control.rb",
     "options.yml",
     "script/console",
     "script/wordlist",
     "sounds/README",
     "sounds/bell.wav",
     "sounds/chick.wav",
     "sounds/click.wav",
     "wordlists/README",
     "wordlists/words.set",
     "wordlists/words.txt"
  ]
  s.homepage = %q{http://github.com/adamsanderson/lexery}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An enteraining word game}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gosu>, ["~> 0.7.14"])
    else
      s.add_dependency(%q<gosu>, ["~> 0.7.14"])
    end
  else
    s.add_dependency(%q<gosu>, ["~> 0.7.14"])
  end
end