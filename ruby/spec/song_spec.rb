# frozen_string_literal: true

require_relative '../song'

# rubocop: disable Metrics/BlockLength
describe Song do
  describe '#full_song' do
    context 'when the animal list is the normal song' do
      subject(:default_song) { described_class.new(animals) }

      let(:animals) { %w[spider bird cat dog cow] }

      it 'returns the expected lyrics' do
        expected_lyrics =
          <<~HEREDOC
            There was an old lady who swallowed a fly.
            I don't know why she swallowed a fly - perhaps she'll die!

            There was an old lady who swallowed a spider;
            That wriggled and wiggled and tickled inside her.
            She swallowed the spider to catch the fly;
            I don't know why she swallowed a fly - perhaps she'll die!

            There was an old lady who swallowed a bird;
            How absurd to swallow a bird.
            She swallowed the bird to catch the spider,
            She swallowed the spider to catch the fly;
            I don't know why she swallowed a fly - perhaps she'll die!

            There was an old lady who swallowed a cat;
            Fancy that to swallow a cat!
            She swallowed the cat to catch the bird,
            She swallowed the bird to catch the spider,
            She swallowed the spider to catch the fly;
            I don't know why she swallowed a fly - perhaps she'll die!

            There was an old lady who swallowed a dog;
            What a hog, to swallow a dog!
            She swallowed the dog to catch the cat,
            She swallowed the cat to catch the bird,
            She swallowed the bird to catch the spider,
            She swallowed the spider to catch the fly;
            I don't know why she swallowed a fly - perhaps she'll die!

            There was an old lady who swallowed a cow;
            I don't know how she swallowed a cow!
            She swallowed the cow to catch the dog,
            She swallowed the dog to catch the cat,
            She swallowed the cat to catch the bird,
            She swallowed the bird to catch the spider,
            She swallowed the spider to catch the fly;
            I don't know why she swallowed a fly - perhaps she'll die!

            There was an old lady who swallowed a horse...
            ...She's dead, of course!
          HEREDOC
        expect(default_song.full_song).to eq(expected_lyrics)
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
