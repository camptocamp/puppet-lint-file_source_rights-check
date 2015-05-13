require 'spec_helper'

describe 'source_without_rights' do
  context 'when rights are passed' do
    let(:code) do
      <<-EOS
        file { '/tmp/foo':
          ensure => file,
          owner  => 'root',
          group  => '0',
          mode   => '0644',
          source => 'puppet:///modules/bar/foo',
        }

        file { '/tmp/bar':
          ensure  => file,
          content => 'qux',
        }
      EOS
    end

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'when rights are not passed' do
    let(:code) do
      <<-EOS
        file { '/tmp/foo':
          ensure => file,
          source => 'puppet:///modules/bar/foo',
        }
      EOS
    end

    it 'should detect 3 problems' do
      expect(problems).to have(3).problems
    end

    it 'should create warnings' do
      expect(problems).to contain_warning('file with source missing owner').on_line(3).in_column(11)
      expect(problems).to contain_warning('file with source missing group').on_line(3).in_column(11)
      expect(problems).to contain_warning('file with source missing mode').on_line(3).in_column(11)
    end
  end
end
