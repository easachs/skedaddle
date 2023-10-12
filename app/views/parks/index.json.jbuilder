# frozen_string_literal: true

json.array! @parks, partial: 'parks/park', as: :park
