class MusicStyle < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end
