# frozen_string_literal: true

class Contact < ApplicationRecord
    # Para deixar um campo opcional.
    # belongs_to :kind, optional: true

    # Associations
    belongs_to :kind
    has_many :phones

    def birthdate_br
        I18n.l(self.birthdate) unless self.birthdate.blank?
    end

    def to_br
        { name: self.name,
          birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?),
          email: self.email,
          kind_id: self.kind.id,
          created_at: self.created_at,
          updated_at: self.updated_at
        }
    end
    #def author
    #    "Anderson Firmino"
    #end

    #def kind_description
    #    self.kind.description
    #end

    #def as_json(options={})
    #    super(
    #        root: true,
    #        methods: [:kind_description, :author], 
    #        include: { kind: { only: :description }}
    #    )
    #end
    
end