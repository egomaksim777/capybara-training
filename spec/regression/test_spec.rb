describe 'Something', type: :feature, js: true do
  it 'Something' do
    visit '/'
    fill_in 'q', with: 'kitty'
    find('.lsb').click
    find('#uid_0').click

    [8,9,10,11,12,14,15,16,17,18].each do |el|
      all('img')[el].click
    end
  end
end
