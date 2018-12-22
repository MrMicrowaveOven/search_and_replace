require_relative '../search_and_replace'

RSpec.describe 'search_and_replace' do
  it 'replaces basic interpolations in the pattern' do
    pattern = 'Hey look, that {0} is {1}!'
    replacements = ["dog", "cute"]

    replaced = search_and_replace(pattern, replacements)
    expectation = 'Hey look, that dog is cute!'
    expect(replaced).to eq(expectation)
  end

  it 'replaces interpolations that are out of order' do
    pattern = '{2} look, that {0} is {1}!'
    replacements = ["dog", "cute", "Hey"]

    replaced = search_and_replace(pattern, replacements)
    expectation = 'Hey look, that dog is cute!'
    expect(replaced).to eq(expectation)
  end

  it 'allows for "{" to be used as an escape from interpolation' do
    pattern = '{2} look, that {{0} is {1}!'
    replacements = ["dog", "cute", "Hey"]

    replaced = search_and_replace(pattern, replacements)
    expectation = 'Hey look, that {0} is cute!'
    expect(replaced).to eq(expectation)
  end

  it 'allows for interpolation immediately after an escape' do
    pattern = '{2} look, that {{{0} is {1}!'
    replacements = ["dog", "cute", "Hey"]

    replaced = search_and_replace(pattern, replacements)
    expectation = 'Hey look, that {dog is cute!'
    expect(replaced).to eq(expectation)
  end

  it 'allows for several escapes before an interpolation' do
    pattern = '{2} look, that {{{{{0} is {1}!'
    replacements = ["dog", "cute", "Hey"]

    replaced = search_and_replace(pattern, replacements)
    expectation = 'Hey look, that {{dog is cute!'
    expect(replaced).to eq(expectation)
  end

  it 'allows for an escaped interpolation after several escapes' do
    pattern = '{2} look, that {{{{{0} is {1}!'
    replacements = ["dog", "cute", "Hey"]

    replaced = search_and_replace(pattern, replacements)
    expectation = 'Hey look, that {{dog is cute!'
    expect(replaced).to eq(expectation)
  end
end
