# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  # rubocop:disable Layout/LineLength
  Descriptions = Types::String.enum(
    'ownership-of-shares-25-to-50-percent',                                                   # "The person holds, directly or indirectly, more than 25% but not more than 50% of the shares in the company."
    'ownership-of-shares-50-to-75-percent',                                                   # "The person holds, directly or indirectly, more than 50% but not more than 75% of the shares in the company."
    'ownership-of-shares-75-to-100-percent',                                                  # "The person holds, directly or indirectly, more than 75% of the shares in the company."
    'ownership-of-shares-25-to-50-percent-as-trust',                                          # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 25% but not more than 50% of the shares in the company."
    'ownership-of-shares-50-to-75-percent-as-trust',                                          # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 50% but not more than 75% of the shares in the company."
    'ownership-of-shares-75-to-100-percent-as-trust',                                         # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 75% of the shares in the company."
    'ownership-of-shares-25-to-50-percent-as-firm',                                           # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 25% but not more than 50% of the shares in the company."
    'ownership-of-shares-50-to-75-percent-as-firm',                                           # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 50% but not more than 75% of the shares in the company."
    'ownership-of-shares-75-to-100-percent-as-firm',                                          # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 75% of the shares in the company."
    'ownership-of-shares-more-than-25-percent-registered-overseas-entity',                    # "The beneficial owner holds, directly or indirectly, more than 25% of the shares in the entity."
    'ownership-of-shares-more-than-25-percent-as-trust-registered-overseas-entity',           # "Beneficial owner is a trustee of a trust and: the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 25% of the shares in the entity."
    'ownership-of-shares-more-than-25-percent-as-firm-registered-overseas-entity',            # "The beneficial owner is a member of a firm that is not a legal person under its governing law, and: the members of that firm (in their capacity as such) hold, directly or indirectly, more than 25% of the shares in the entity."
    'voting-rights-25-to-50-percent',                                                         # "The person holds, directly or indirectly, more than 25% but not more than 50% of the voting rights in the company."
    'voting-rights-50-to-75-percent',                                                         # "The person holds, directly or indirectly, more than 50% but not more than 75% of the voting rights in the company."
    'voting-rights-75-to-100-percent',                                                        # "The person holds, directly or indirectly, more than 75% of the voting rights in the company."
    'voting-rights-25-to-50-percent-as-trust',                                                # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 25% but not more than 50% of the voting rights in the company."
    'voting-rights-50-to-75-percent-as-trust',                                                # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 50% but not more than 75% of the voting rights in the company."
    'voting-rights-75-to-100-percent-as-trust',                                               # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 75% of the voting rights in the company."
    'voting-rights-25-to-50-percent-as-firm',                                                 # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 25% but not more than 50% of the voting rights in the company."
    'voting-rights-50-to-75-percent-as-firm',                                                 # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 50% but not more than 75% of the voting rights in the company."
    'voting-rights-75-to-100-percent-as-firm',                                                # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 75% of the voting rights in the company."
    'voting-rights-more-than-25-percent-registered-overseas-entity',                          # "The beneficial owner holds, directly or indirectly, more than 25% of the voting rights in the entity."
    'voting-rights-more-than-25-percent-as-trust-registered-overseas-entity',                 # "Beneficial owner is a trustee of a trust and: the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 25% of the voting rights in the entity."
    'voting-rights-more-than-25-percent-as-firm-registered-overseas-entity',                  # "The beneficial owner is a member of a firm that is not a legal person under its governing law, and: the members of that firm (in their capacity as such) hold, directly or indirectly, more than 25% of the voting rights in the entity."
    'right-to-appoint-and-remove-directors',                                                  # "The person holds the right, directly or indirectly, to appoint or remove a majority of the board of directors of the company."
    'right-to-appoint-and-remove-directors-as-trust',                                         # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the board of directors of the company."
    'right-to-appoint-and-remove-directors-as-firm',                                          # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the board of directors of the company."
    'significant-influence-or-control',                                                       # "The person has the right to exercise, or actually exercises, significant influence or control over the company."
    'significant-influence-or-control-as-trust',                                              # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such)  have the right to exercise, or actually exercise, significant influence or control over the company."
    'significant-influence-or-control-as-firm',                                               # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) have the right to exercise, or actually exercise, significant influence or control over the company."
    'right-to-share-surplus-assets-25-to-50-percent-limited-liability-partnership',           # "The person holds or is treated as holding, directly or indirectly, the right to share in more than 25% but not more than 50% of any surplus assets of the LLP on a winding up."
    'right-to-share-surplus-assets-50-to-75-percent-limited-liability-partnership',           # "The person holds or is treated as holding, directly or indirectly, the right to share in more than 50% but not more than 75% of any surplus assets of the LLP on a winding up."
    'right-to-share-surplus-assets-75-to-100-percent-limited-liability-partnership',          # "The person holds or is treated as holding, directly or indirectly, the right to share in more than 75% of any surplus assets of the LLP on a winding up."
    'right-to-share-surplus-assets-25-to-50-percent-as-trust-limited-liability-partnership',  # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust; and the trustee of that trust (in their capacity as such) hold or are treated as holding, directly or indirectly, the right to share in more than 25% but not more than 50% of any surplus assets on a winding up of the LLP."
    'right-to-share-surplus-assets-50-to-75-percent-as-trust-limited-liability-partnership',  # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust; and the trustee of that trust (in their capacity as such) hold or are treated as holding, directly or indirectly, the right to share in more than 50% but not more than 75% of any surplus assets on a winding up of the LLP."
    'right-to-share-surplus-assets-75-to-100-percent-as-trust-limited-liability-partnership', # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust; and the trustee of that trust (in their capacity as such) hold or are treated as holding, directly or indirectly, the right to share in more than 75% of any surplus assets on a winding up of the LLP."
    'right-to-share-surplus-assets-25-to-50-percent-as-firm-limited-liability-partnership',   # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold or as treated as holding, directly or indirectly, the right to share in more than 25% but not more than 50% of any surplus assets of the LLP on a winding up."
    'right-to-share-surplus-assets-50-to-75-percent-as-firm-limited-liability-partnership',   # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold or as treated as holding, directly or indirectly, the right to share in more than 50% but not more than 75% of any surplus assets of the LLP on a winding up."
    'right-to-share-surplus-assets-75-to-100-percent-as-firm-limited-liability-partnership',  # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold or as treated as holding, directly or indirectly, the right to share 75% or more of any surplus assets of the LLP on a winding up."
    'voting-rights-25-to-50-percent-limited-liability-partnership',                           # "The person holds, directly or indirectly, more than 25% but not more than 50% of the voting rights in the LLP."
    'voting-rights-50-to-75-percent-limited-liability-partnership',                           # "The person holds, directly or indirectly, more than 50% but not more than 75% of the voting rights in the LLP."
    'voting-rights-75-to-100-percent-limited-liability-partnership',                          # "The person holds, directly or indirectly, more than 75% of the voting rights in the LLP."
    'voting-rights-25-to-50-percent-as-trust-limited-liability-partnership',                  # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 25% but not more than 50% of the voting rights in the LLP."
    'voting-rights-50-to-75-percent-as-trust-limited-liability-partnership',                  # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 50% but not more than 75% of the voting rights in the LLP."
    'voting-rights-75-to-100-percent-as-trust-limited-liability-partnership',                 # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold, directly or indirectly, more than 75% of the voting rights in the LLP."
    'voting-rights-25-to-50-percent-as-firm-limited-liability-partnership',                   # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 25% but not more than 50% of the voting rights in the LLP."
    'voting-rights-50-to-75-percent-as-firm-limited-liability-partnership',                   # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 50% but not more than 75% of the voting rights in the LLP."
    'voting-rights-75-to-100-percent-as-firm-limited-liability-partnership',                  # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) hold, directly or indirectly, more than 75% of the voting rights in the LLP."
    'right-to-appoint-and-remove-members-limited-liability-partnership',                      # "The person holds the right, directly or indirectly, to appoint or remove a majority of the members who are entitled to take part in the management of an LLP."
    'right-to-appoint-and-remove-members-as-trust-limited-liability-partnership',             # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the members who are entitled to take part in the management of the LLP."
    'right-to-appoint-and-remove-members-as-firm-limited-liability-partnership',              # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the members who are entitled to take part in the management of the LLP."
    'significant-influence-or-control-limited-liability-partnership',                         # "The person has the right to exercise, or actually exercises, significant influence or control over the LLP."
    'significant-influence-or-control-as-trust-limited-liability-partnership',                # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such)  have the right to exercise, or actually exercise, significant influence or control over the LLP."
    'significant-influence-or-control-as-firm-limited-liability-partnership',                 # "The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed is not a legal person; and the members of that firm (in their capacity as such) have the right to exercise, or actually exercise, significant influence or control over the LLP."
    'significant-influence-or-control-registered-overseas-entity',                            # "The beneficial owner has the right to exercise, or actually exercises, significant influence or control over the entity."
    'significant-influence-or-control-as-trust-registered-overseas-entity',                   # "Beneficial owner is a trustee of a trust and: the trustees of that trust (in their capacity as such) have the right to exercise, or actually exercise, significant influence or control over the company."
    'significant-influence-or-control-as-firm-registered-overseas-entity',                    # "The beneficial owner is a member of a firm that is not a legal person under its governing law, and: the members of that firm (in their capacity as such) have the right to exercise, or actually exercise, significant influence or control over the company."
    'part-right-to-share-surplus-assets-25-to-50-percent',                                    # 'The person holds or is treated as holding, directly or indirectly, the right to share in more than 25% but not more than 50% of any surplus assets of the partnership on a winding up.'
    'part-right-to-share-surplus-assets-50-to-75-percent',                                    # 'The person holds or is treated as holding, directly or indirectly, the right to share in more than 50% but not more than 75% of any surplus assets of the partnership on a winding up.'
    'part-right-to-share-surplus-assets-75-to-100-percent',                                   # 'The person holds or is treated as holding, directly or indirectly, the right to share in more than 75% of any surplus assets of the partnership on a winding up.'
    'part-right-to-share-surplus-assets-25-to-50-percent-as-trust',                           # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust; and the trustee of that trust (in their capacity as such) hold or are treated as holding, directly or indirectly, the right to share in more than 25% but not more than 50% of any surplus assets on a winding up of the partnership.'
    'part-right-to-share-surplus-assets-50-to-75-percent-as-trust',                           # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust; and the trustee of that trust (in their capacity as such) hold or are treated as holding, directly or indirectly, the right to share in more than 50% but not more than 75% of any surplus assets on a winding up of the partnership.'
    'part-right-to-share-surplus-assets-75-to-100-percent-as-trust',                          # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust; and the trustee of that trust (in their capacity as such) hold or are treated as holding, directly or indirectly, the right to share in more than 75% of any surplus assets on a winding up of the partnership.'
    'part-right-to-share-surplus-assets-25-to-50-percent-as-firm',                            # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold or as treated as holding, directly or indirectly, the right to share in more than 25% but not more than 50% of any surplus assets of the partnership on a winding up.'
    'part-right-to-share-surplus-assets-50-to-75-percent-as-firm',                            # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold or as treated as holding, directly or indirectly, the right to share in more than 50% but not more than 75% of any surplus assets of the partnership on a winding up.'
    'part-right-to-share-surplus-assets-75-to-100-percent-as-firm',                           # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold or as treated as holding, directly or indirectly, the right to share 75% or more of any surplus assets of the partnership on a winding up.'
    'right-to-appoint-and-remove-person',                                                     # 'The person holds the right, directly or indirectly, to appoint or remove a majority of the persons who are entitled to take part in the management of the partnership.'
    'right-to-appoint-and-remove-person-as-firm',                                             # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a firm that, under the law by which it is governed, is not a legal person; and the members of that firm (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the persons who are entitled to take part in the management of the partnership.'
    'right-to-appoint-and-remove-person-as-trust',                                            # 'The person has the right to exercise, or actually exercises, significant influence or control over the activities of a trust, and the trustees of that trust (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the persons who are entitled to take part in the management of the partnership.'
    'right-to-appoint-and-remove-directors-registered-overseas-entity',                       # "The beneficial owner holds the right, directly or indirectly, to appoint or remove a majority of the board of directors of the entity."
    'right-to-appoint-and-remove-directors-as-trust-registered-overseas-entity',              # "Beneficial owner is a trustee of a trust and: the trustees of that trust (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the board of directors of the company."
    'right-to-appoint-and-remove-directors-as-firm-registered-overseas-entity'                # "The beneficial owner is a member of a firm that is not a legal person under its governing law, and: the members of that firm (in their capacity as such) hold the right, directly or indirectly, to appoint or remove a majority of the board of directors of the company."
  )
  # rubocop:enable Layout/LineLength
end
