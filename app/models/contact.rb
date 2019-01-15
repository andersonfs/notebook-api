# frozen_string_literal: true

class Contact < ApplicationRecord

  #validations
  # validates_presence_of :kind
  # validates_presence_of :address

  # Kaminari
  paginates_per 5

  # Para deixar um campo opcional.
  # belongs_to :kind, optional: true

  # Associations
  belongs_to :kind
  has_many :phones
  has_one :address

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def birthdate_br
    I18n.l(birthdate) unless birthdate.blank?
  end

  def as_json(options = {})
    h = super(options)
    h[:birthdate] = (I18n.l(birthdate) unless birthdate.blank?)
    h
  end
  #     def to_br
  #         { name: self.name,
  #           birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?),
  #           email: self.email,
  #           kind_id: self.kind.id,
  #           created_at: self.created_at,
  #           updated_at: self.updated_at
  #         }
  #     end
  # def author
  #    "Anderson Firmino"
  # end

  # def kind_description
  #    self.kind.description
  # end

  # def as_json(options={})
  #    super(
  #        root: true,
  #        methods: [:kind_description, :author],
  #        include: { kind: { only: :description }}
  #    )
  # end
end
