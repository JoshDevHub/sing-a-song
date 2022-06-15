# frozen_string_literal: true

# class for individual animals in the song
module AnimalFactory
  # animal abstract parent
  class Animal
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def unique_lyric
      raise NotImplementedError
    end
  end

  # subclass for the spider
  class Spider < Animal
    def unique_lyric
      'That wriggled and wiggled and tickled inside her.'
    end
  end

  # subclass for the bird
  class Bird < Animal
    def unique_lyric
      'How absurd to swallow a bird.'
    end
  end

  # subclass for the cat
  class Cat < Animal
    def unique_lyric
      'Fancy that to swallow a cat!'
    end
  end

  # sublcass for the cat
  class Dog < Animal
    def unique_lyric
      'What a hog, to swallow a dog!'
    end
  end

  # subclass for the cow
  class Cow < Animal
    def unique_lyric
      "I don't know how she swallowed a cow!"
    end
  end

  CLASSES_BY_NAME = {
    'spider' => Spider,
    'bird' => Bird,
    'cat' => Cat,
    'dog' => Dog,
    'cow' => Cow
  }.freeze

  def self.for(name)
    animal = CLASSES_BY_NAME.fetch(name) do |(new_animal, phrase)|
      new_animal_class = Class.new(Animal)
      unique_lyric_method = -> { phrase }
      new_animal_class.send(:define_method, :unique_lyric, unique_lyric_method)
      Animal.send(:const_set, new_animal.upcase, new_animal_class)
      class_get = const_get "Animal::#{new_animal.upcase}"
      return class_get.new(new_animal)
    end
    animal.new(name)
  end
end

# class for the nursery rhyme
class Song
  def initialize(animals = %w[spider bird cat dog cow])
    @animals = animals.map { |animal| AnimalFactory.for(animal) }
    @past_animals = []
  end

  def full_song
    <<~HEREDOC
      #{first_verse}
      #{intermediate_verses}#{final_verse}
    HEREDOC
  end

  def first_verse
    <<~HEREDOC
      There was an old lady who swallowed a fly.
      I don't know why she swallowed a fly - perhaps she'll die!
    HEREDOC
  end

  def final_verse
    <<~HEREDOC.chomp
      There was an old lady who swallowed a horse...
      ...She's dead, of course!
    HEREDOC
  end

  private

  def intermediate_verses
    verses = String.new
    until @animals.empty?
      current_animal = @animals.shift
      verses += <<~HEREDOC
        There was an old lady who swallowed a #{current_animal.name};
        #{current_animal.unique_lyric}
        #{descending_chain_for(current_animal)}
        I don't know why she swallowed a fly - perhaps she'll die!\n
      HEREDOC
    end
    verses
  end

  def descending_chain_for(animal)
    @past_animals.unshift(animal)
    chain = String.new
    @past_animals.each_cons(2) do |current_animal, next_animal|
      chain += "She swallowed the #{current_animal.name} to catch the #{next_animal.name},\n"
    end
    "#{chain}She swallowed the #{@past_animals.last.name} to catch the fly;"
  end
end

animals = [
  'spider',
  'bird',
  'cat',
  ['goat', 'She just opened her throat and swallowed the goat!'],
  'horse'
]
puts Song.new(animals).full_song
