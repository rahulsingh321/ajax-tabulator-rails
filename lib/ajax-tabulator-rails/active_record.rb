# frozen_string_literal: true

module AjaxTabulatorRails
  class ActiveRecord < AjaxTabulatorRails::Base
    include AjaxTabulatorRails::ORM::ActiveRecord
  end
end
